#include "tree_sitter/parser.h"
#include "tree_sitter/alloc.h"

#include <string.h>

enum TokenType {
    MARKER_START,
    FILENAME,
    MARKER_END,
    CONTENT_LINE,
};

typedef struct {
    // Number of bytes the FILENAME token should consume on the next call.
    // Set during MARKER_START scanning while we're validating the line; consumed
    // by the FILENAME branch on the immediately following call.
    uint32_t filename_length;
} Scanner;

void *tree_sitter_txtar_external_scanner_create(void) {
    return ts_calloc(1, sizeof(Scanner));
}

void tree_sitter_txtar_external_scanner_destroy(void *payload) {
    ts_free(payload);
}

unsigned tree_sitter_txtar_external_scanner_serialize(void *payload, char *buffer) {
    Scanner *scanner = (Scanner *)payload;
    memcpy(buffer, &scanner->filename_length, sizeof(scanner->filename_length));
    return sizeof(scanner->filename_length);
}

void tree_sitter_txtar_external_scanner_deserialize(void *payload, const char *buffer, unsigned length) {
    Scanner *scanner = (Scanner *)payload;
    if (length == sizeof(scanner->filename_length)) {
        memcpy(&scanner->filename_length, buffer, sizeof(scanner->filename_length));
    } else {
        scanner->filename_length = 0;
    }
}

static inline void advance(TSLexer *lexer) {
    lexer->advance(lexer, false);
}

static bool scan_content_line_to_eol(TSLexer *lexer) {
    while (lexer->lookahead != '\n' && !lexer->eof(lexer)) {
        advance(lexer);
    }
    if (lexer->lookahead == '\n') {
        advance(lexer);
    }
    lexer->mark_end(lexer);
    lexer->result_symbol = CONTENT_LINE;
    return true;
}

bool tree_sitter_txtar_external_scanner_scan(void *payload, TSLexer *lexer, const bool *valid_symbols) {
    Scanner *scanner = (Scanner *)payload;

    // FILENAME follows immediately after a MARKER_START we just emitted.
    // Consume exactly the byte count we measured during validation.
    if (valid_symbols[FILENAME] && !valid_symbols[MARKER_START] && !valid_symbols[CONTENT_LINE]) {
        if (scanner->filename_length == 0) {
            return false;
        }
        for (uint32_t i = 0; i < scanner->filename_length; i++) {
            if (lexer->eof(lexer) || lexer->lookahead == '\n') {
                return false;
            }
            advance(lexer);
        }
        lexer->result_symbol = FILENAME;
        return true;
    }

    // MARKER_END follows immediately after FILENAME. Consumes " --" plus the
    // line terminator (\n or EOF).
    if (valid_symbols[MARKER_END] && !valid_symbols[MARKER_START] && !valid_symbols[CONTENT_LINE]) {
        if (lexer->lookahead != ' ') return false;
        advance(lexer);
        if (lexer->lookahead != '-') return false;
        advance(lexer);
        if (lexer->lookahead != '-') return false;
        advance(lexer);
        if (lexer->lookahead == '\n') {
            advance(lexer);
        }
        lexer->result_symbol = MARKER_END;
        return true;
    }

    // We're at the start of a fresh line. Both MARKER_START and CONTENT_LINE are
    // candidates. Try to validate a marker first; if the line isn't a valid
    // `^-- NAME --(\n|EOF)$`, fall through and emit the whole line as CONTENT_LINE.
    if (valid_symbols[MARKER_START] || valid_symbols[CONTENT_LINE]) {
        if (lexer->eof(lexer)) {
            return false;
        }

        bool try_marker = valid_symbols[MARKER_START] && lexer->get_column(lexer) == 0;

        if (try_marker && lexer->lookahead == '-') {
            advance(lexer);
            if (lexer->lookahead == '-') {
                advance(lexer);
                if (lexer->lookahead == ' ') {
                    advance(lexer);
                    // Tentatively a marker: token would end here at "-- ".
                    lexer->mark_end(lexer);

                    // Look ahead through the rest of the line to confirm it ends
                    // with " --". Track filename_chars so FILENAME knows how much
                    // to consume on the next call.
                    uint32_t filename_chars = 0;
                    int trailing = 0; // 0=normal, 1=" ", 2=" -", 3=" --"
                    while (lexer->lookahead != '\n' && !lexer->eof(lexer)) {
                        int32_t c = lexer->lookahead;
                        if (c == ' ') {
                            trailing = 1;
                        } else if (c == '-' && trailing == 1) {
                            trailing = 2;
                        } else if (c == '-' && trailing == 2) {
                            trailing = 3;
                        } else {
                            trailing = 0;
                        }
                        filename_chars++;
                        advance(lexer);
                    }

                    // Valid marker: ends with " --" and has at least one byte of
                    // filename before that closer (filename_chars > 3 because the
                    // closing " --" itself contributes 3 to the count).
                    if (trailing == 3 && filename_chars > 3) {
                        scanner->filename_length = filename_chars - 3;
                        lexer->result_symbol = MARKER_START;
                        return true;
                    }

                    // Not a marker. Fall through to emit CONTENT_LINE for the
                    // whole line we've already advanced past.
                }
            }
            // Marker validation failed somewhere in the prefix. Continue
            // consuming the rest of the line as content.
            if (valid_symbols[CONTENT_LINE]) {
                return scan_content_line_to_eol(lexer);
            }
            return false;
        }

        if (valid_symbols[CONTENT_LINE]) {
            return scan_content_line_to_eol(lexer);
        }
    }

    return false;
}

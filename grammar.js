/**
 * @file A Tree Sitter Grammar for the txtar file format (https://pkg.go.dev/golang.org/x/tools/txtar)
 * @author Tom Fleet <me@followtheprocess.codes>
 * @license MIT
 *
 * The txtar format:
 *   - Optional pre-marker comment region (any text)
 *   - Zero or more file entries, each introduced by a line of the form `-- name --`
 *   - Marker lines must begin with the three bytes "-- " and end with the three bytes " --"
 *   - The filename is the trimmed text between the start and end markers
 *   - Anything between one marker and the next (or EOF) is the file's content
 *   - Per spec there are no syntax errors and a missing trailing newline is treated as present
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

export default grammar({
  name: "txtar",

  // Whitespace and newlines are part of the line-oriented structure, so no extras.
  extras: () => [],

  rules: {
    source_file: ($) => seq(optional($.comment), repeat($.file_entry)),

    // The comment section is whatever appears before the first file marker.
    comment: ($) => repeat1($.text_line),

    file_entry: ($) =>
      seq(
        field("marker", $.file_marker),
        field("content", optional($.file_content)),
      ),

    // Grouped wrapper so injection queries can target the whole body of a file.
    file_content: ($) => repeat1($.text_line),

    file_marker: ($) =>
      seq(
        $.marker_start,
        field("filename", $.filename),
        $.marker_end,
        // Optional newline so a final marker without a trailing newline still parses,
        // matching the spec's "treat missing trailing newline as present" rule.
        /\r?\n?/,
      ),

    // The Go reference parser checks for the literal byte sequences "-- " and " --".
    // We allow extra inner whitespace which the reference implementation trims.
    marker_start: () => token(seq("-- ", /[ \t]*/)),
    marker_end: () => token(seq(/[ \t]*/, " --")),

    // Filenames are arbitrary trimmed text on a marker line. We forbid leading
    // and trailing whitespace or '-' so the regex does not greedily consume the
    // ' --' end marker. Filenames containing a '-' (e.g. `my-file.txt`) are
    // supported; filenames that start or end with '-' are not (rare in practice).
    filename: () => /[^\s-]([^\n]*[^\s-])?/,

    // Any line that is not a file marker. Lines starting with the literal
    // marker prefix "-- " are excluded so the parser routes them to file_marker.
    text_line: () =>
      token(
        prec(
          -1,
          choice(
            // empty line
            /\r?\n/,
            // line not starting with '-'
            /[^-\n][^\n]*\n?/,
            // line starting with a single '-' (followed by something other than '-')
            /-([^-\n][^\n]*)?\n?/,
            // line starting with '--' but not "-- " (i.e. not a marker prefix)
            /--([^ \n][^\n]*)?\n?/,
          ),
        ),
      ),
  },
});

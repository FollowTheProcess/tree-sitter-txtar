/**
 * @file A Tree Sitter Grammar for the txtar file format (https://pkg.go.dev/golang.org/x/tools/txtar)
 * @author Tom Fleet <me@followtheprocess.codes>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

export default grammar({
  name: "txtar",

  // txtar is strictly line-oriented and the marker syntax (-- NAME --) is
  // ambiguous with content (a content line may begin with `-- ` and not be a
  // marker). Tokenisation is delegated to src/scanner.c which validates each
  // candidate marker line against the spec before emitting marker tokens, and
  // emits whole-line CONTENT_LINE tokens otherwise. Extras must stay empty so
  // the parser cannot skip across newlines or eat content as whitespace.
  extras: ($) => [],

  externals: ($) => [
    $.marker_start,
    $.filename,
    $.marker_end,
    $._content_line,
  ],

  rules: {
    source_file: ($) =>
      seq(optional($.comment_section), repeat($.file_entry)),

    comment_section: ($) => repeat1($.comment_line),
    comment_line: ($) => $._content_line,

    file_entry: ($) =>
      seq(
        field("marker", $.file_marker),
        field("content", optional($.file_content)),
      ),

    file_content: ($) => repeat1($.file_content_line),
    file_content_line: ($) => $._content_line,

    file_marker: ($) =>
      seq(
        field("marker_start", $.marker_start),
        field("filename", $.filename),
        field("marker_end", $.marker_end),
      ),
  },
});

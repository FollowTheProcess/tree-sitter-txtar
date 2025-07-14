/**
 * @file A Tree Sitter Grammar for the txtar file format (https://pkg.go.dev/golang.org/x/tools/txtar)
 * @author Tom Fleet <me@followtheprocess.codes>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "txtar",

  extras: ($) => [
    token(
      choice(
        seq("#", /[^\n]*/), // line comments
        /\s/,
      ),
    ),
  ],

  rules: {
    source_file: ($) => seq(optional($.comment_section), repeat($.file_entry)),

    comment_section: ($) => repeat1($.comment_line),
    comment_line: ($) => token(prec(-1, /[^\n]*\n?/)),

    file_entry: ($) =>
      seq(
        field("marker", $.file_marker),
        field("content", repeat($.file_content_line)), // inline repeat to avoid empty rule
      ),

    file_marker: ($) =>
      seq(
        field("marker_start", $.marker_start),
        field("filename", $.filename),
        field("marker_end", $.marker_end),
        "\n",
      ),

    marker_start: ($) => token(seq("--", /[ \t]*/)),
    marker_end: ($) => token(seq(/[ \t]*/, "--")),

    filename: ($) => /[^-\n \t][^-\n]*[^-\n \t]/,

    file_content_line: ($) => token(prec(-1, /[^\n]*\n?/)),
  },
});

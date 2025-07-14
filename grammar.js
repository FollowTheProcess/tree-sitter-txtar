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
    // Allow line comments that begin with '#' and ignore them
    token(choice(seq("#", /.*/), /\s/)),
  ],

  rules: {
    // Root of the grammar
    source_file: ($) => seq(optional($.comment_section), repeat($.file_entry)),

    // Comment section is anything before the first file marker
    comment_section: ($) => repeat1($.comment_line),

    comment_line: ($) => token(prec(-1, /[^\n]*\n?/)),

    file_entry: ($) => seq($.file_marker, repeat($.file_content_line)),

    // File marker line -- filename --
    file_marker: ($) =>
      seq(
        alias(token(seq("--", field("pre_space", /[ \t]*/))), "marker_start"),
        field("filename", $.filename),
        alias(token(seq(field("post_space", /[ \t]*/), "--")), "marker_end"),
        "\n",
      ),

    filename: ($) => token(prec(1, /[^\n\-][^-\n]*[^\n\-]|[^\n\-]/)),

    // File content is just raw lines until the next marker
    file_content_line: ($) => token(prec(-1, /[^\n]*\n?/)),
  },
});

/**
 * @file A Tree Sitter Grammar for the txtar file format (https://pkg.go.dev/golang.org/x/tools/txtar)
 * @author Tom Fleet <me@followtheprocess.codes>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "txtar",

  rules: {
    // TODO: add the actual grammar rules
    source_file: ($) => "hello",
  },
});

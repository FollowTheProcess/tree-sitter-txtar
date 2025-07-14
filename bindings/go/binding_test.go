package tree_sitter_txtar_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_txtar "github.com/followtheprocess/tree-sitter-txtar/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_txtar.Language())
	if language == nil {
		t.Errorf("Error loading Txtar grammar")
	}
}

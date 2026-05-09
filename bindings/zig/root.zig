extern fn tree_sitter_txtar() callconv(.c) *const anyopaque;

pub fn language() *const anyopaque {
    return tree_sitter_txtar();
}

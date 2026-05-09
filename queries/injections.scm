; Inject embedded language syntax into a file's content based on its filename.
;
; Each rule matches the filename against an extension and selects an injection
; language. `injection.combined` joins all the content lines into a single
; injection so the embedded parser sees the file as a contiguous document.

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.go$")
  (#set! injection.language "go")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(py|pyi)$")
  (#set! injection.language "python")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.rs$")
  (#set! injection.language "rust")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(js|mjs|cjs)$")
  (#set! injection.language "javascript")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(ts|tsx)$")
  (#set! injection.language "typescript")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.json$")
  (#set! injection.language "json")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(ya?ml)$")
  (#set! injection.language "yaml")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.toml$")
  (#set! injection.language "toml")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.md$")
  (#set! injection.language "markdown")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(sh|bash)$")
  (#set! injection.language "bash")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(c|h)$")
  (#set! injection.language "c")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(cpp|cc|cxx|hpp|hh|hxx)$")
  (#set! injection.language "cpp")
  (#set! injection.combined))

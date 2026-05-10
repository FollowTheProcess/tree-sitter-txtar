; Inject embedded language syntax into a file's content based on its filename.
;
; Each rule matches the captured filename against an extension or a full
; filename and selects an injection language. `injection.combined` joins all
; the content lines into a single injection so the embedded parser sees the
; file as a contiguous document.
;
; Patterns are split into two groups:
;   1. Extension-based matches (e.g. `\.go$`).
;   2. Filename-anchored matches (e.g. `(^|/)go\.mod$`) for files that have no
;      conventional extension. The `(^|/)` prefix lets paths like
;      `subdir/go.mod` resolve correctly, since txtar markers may carry paths.

;; -- extension-based ----------------------------------------------------------

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

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(zig|zon)$")
  (#set! injection.language "zig")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.nu$")
  (#set! injection.language "nu")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.html?$")
  (#set! injection.language "html")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.css$")
  (#set! injection.language "css")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.http$")
  (#set! injection.language "http")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.sql$")
  (#set! injection.language "sql")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.lua$")
  (#set! injection.language "lua")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(mk|mak)$")
  (#set! injection.language "make")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.dockerfile$")
  (#set! injection.language "dockerfile")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.xml$")
  (#set! injection.language "xml")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.proto$")
  (#set! injection.language "proto")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.(graphql|gql)$")
  (#set! injection.language "graphql")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.java$")
  (#set! injection.language "java")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.kts?$")
  (#set! injection.language "kotlin")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.swift$")
  (#set! injection.language "swift")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.rb$")
  (#set! injection.language "ruby")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.php$")
  (#set! injection.language "php")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.exs?$")
  (#set! injection.language "elixir")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.erl$")
  (#set! injection.language "erlang")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.nix$")
  (#set! injection.language "nix")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.hs$")
  (#set! injection.language "haskell")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "\\.mli?$")
  (#set! injection.language "ocaml")
  (#set! injection.combined))

;; -- filename-anchored --------------------------------------------------------

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "(^|/)go\\.mod$")
  (#set! injection.language "Go Mod")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "(^|/)go\\.sum$")
  (#set! injection.language "Go Sum")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "(^|/)go\\.work$")
  (#set! injection.language "Go Work")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "(^|/)Dockerfile(\\..+)?$")
  (#set! injection.language "dockerfile")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "(^|/)(GNU)?[Mm]akefile$")
  (#set! injection.language "make")
  (#set! injection.combined))

((file_entry
  (file_marker (filename) @_filename)
  (file_content) @injection.content)
  (#match? @_filename "(^|/)(Rakefile|Gemfile)$")
  (#set! injection.language "ruby")
  (#set! injection.combined))

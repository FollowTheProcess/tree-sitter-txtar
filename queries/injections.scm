;; Detect the language in a txtar file and using it for syntax highlighting
(
  (file_entry
    (file_marker (filename) @injection.language)
    (file_content_line) @injection.content)
)

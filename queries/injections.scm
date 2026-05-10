;; Inject the syntax of the language indicated by each file's filename into
;; that file's content. Editors that resolve a `@injection.language` capture
;; against filenames (rather than language IDs) can drive highlighting from
;; the marker line.
((file_entry
   (file_marker (filename) @injection.language)
   (file_content) @injection.content)
 (#set! injection.combined))

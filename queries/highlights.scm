;; Highlight comment lines (before first marker)
(comment_line) @comment

;; Filename inside file marker
(filename) @string.special.path

;; Content of the file, highlight as generic text
(file_content_line) @text

;; Optional: highlight the full file_marker as punctuation
(file_marker) @punctuation.delimiter

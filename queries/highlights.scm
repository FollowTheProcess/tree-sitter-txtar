;; Lines in the leading comment section
(comment_line) @comment

;; Filename inside a file marker
(filename) @string.special.path

;; The literal `--` framing on a marker line
(marker_start) @punctuation.delimiter
(marker_end) @punctuation.delimiter

;; File body content
(file_content_line) @text

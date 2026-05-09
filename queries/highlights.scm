; Pre-marker comment region
(comment) @comment

; The filename inside a marker line
(filename) @string.special.path

; The "-- " and " --" delimiters around the filename
[
  (marker_start)
  (marker_end)
] @punctuation.delimiter

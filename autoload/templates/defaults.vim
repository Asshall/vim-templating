" ============================================
" =                                          =
" =                [ __txt__ ]               =
" =                                          =
" ============================================
let g:defaults#simpleTitle = json_decode('{"overrides": {"textId": "__txt__", "comCharId": "__comchar__", "markerStartId": "__marker-s__", "markerEndId": "__marker-e__", "wrap": null, "minimumPadding": null}, "prepend": [{"chars": "__comchar__", "nmb": 1}, {"chars": " ", "nmb": 1}], "lines": [[{"chars": "=", "nmb": 44}], [{"chars": "=", "nmb": 1}, {"chars": " ", "nmb": 42}, {"chars": "=", "nmb": 1}], {"size": 44, "padding": {"left": [{"chars": " ", "nmb": 1}], "right": [{"chars": " ", "nmb": 1}]}, "surround": {"left": [{"chars": "[", "nmb": 1}, {"chars": " ", "nmb": 1}], "right": [{"chars": " ", "nmb": 1}, {"chars": "]", "nmb": 1}]}, "lineContent": {"left": [{"chars": "=", "nmb": 1}], "right": [{"chars": "=", "nmb": 1}]}}, [{"chars": "=", "nmb": 1}, {"chars": " ", "nmb": 42}, {"chars": "=", "nmb": 1}], [{"chars": "=", "nmb": 44}]]}')
" let g:defaults#title = {
"                 \'prepend': [
"                     \{ 'chars' : '__comchar__'},
"                     \{ 'chars' : ' '}
"                 \],
"                 \'lines' : [
"                     \{
"                         \'chars' : '=',
"                         \'nmb' : 44
"                     \},
"                     \[
"                         \{ 'chars' : '='},
"                         \{
"                             \'chars' : ' ',
"                             \'nmb' : 42
"                         \},
"                         \{ 'chars' : '='}
"                     \],
"                     \{
"                         \'size' : 44,
"                         \'padding' : {
"                             \'left' : ' ',
"                             \'right' : ' '
"                         \},
"                         \'surround': {
"                             \'left' : { 'chars' : '[ '},
"                             \'right' : { 'chars' : ' ]'}
"                         \},
"                         \'lineContent' : {
"                             \'left' : { 'chars' : '='},
"                             \'right' : { 'chars' : '='}
"                         \}
"                     \},
"                     \[
"                         \{ 'chars' : '='},
"                         \{
"                             \'chars' : ' ',
"                             \'nmb' : 42
"                             \},
"                         \{ 'chars' : '='}
"                     \],
"                     \{
"                         \'chars' : '=',
"                         \'nmb' : 44
"                     \}
"                 \]
"             \}


" =================[ __txt__ ]================
let g:defaults#subTitle = json_decode('{"overrides": {"textId": "__txt__", "comCharId": "__comchar__", "markerStartId": "__marker-s__", "markerEndId": "__marker-e__", "wrap": "0", "minimumPadding": null}, "prepend": [{"chars": "__comchar__", "nmb": 1}, {"chars": " ", "nmb": 1}], "lines": [{"size": 44, "padding": {"left": [{"chars": "=", "nmb": 1}], "right": [{"chars": "=", "nmb": 1}]}, "surround": {"left": [{"chars": "[", "nmb": 1}, {"chars": " ", "nmb": 1}], "right": [{"chars": " ", "nmb": 1}, {"chars": "]", "nmb": 1}]}, "lineContent": {"left": [], "right": []}}]}')
" let g:defaults#subTitle = {
"         \'prepend': [
"             \{'chars' : '__comchar__' },
"             \{'chars' : ' '}
"         \],
"         \'overrides' : {
"             \'wrap': '0'
"         \},
"         \'lines' : {
"             \'size' : 44,
"             \'padding' : {
"                 \'left' : '=',
"                 \'right' : '='
"             \},
"             \'surround' : {
"                 \'left' : { 'chars' : '[ '},
"                 \'right' : { 'chars' : ' ]'}
"             \},
"             \'lineContent': v:none
"         \}
"     \}


" {{{===============[ __txt_ ]==============
let g:defaults#markerSubTitle = json_decode('{"overrides": {"textId": "__txt__", "comCharId": "__comchar__", "markerStartId": "__marker-s__", "markerEndId": "__marker-e__", "wrap": null, "minimumPadding": null}, "prepend": [{"chars": "__comchar__", "nmb": 1}, {"chars": " ", "nmb": 1}], "lines": [{"size": 42, "padding": {"left": [{"chars": "=", "nmb": 1}], "right": [{"chars": "=", "nmb": 1}]}, "surround": {"left": [{"chars": "[", "nmb": 1}, {"chars": " ", "nmb": 1}], "right": [{"chars": " ", "nmb": 1}, {"chars": "]", "nmb": 1}]}, "lineContent": {"left": [{"chars": "__marker-s__", "nmb": 1}], "right": []}}]}')


" ============================================================================
"                                                                            |
" File:        __filename__                                                  |
" Description: __txt__                                                       |
" License:     __txt__                                                       |
"                                                                            |
" ============================================================================
let g:defaults#titleFlowerBox = json_decode('{"overrides": {"textId": "__txt__", "comCharId": "__comchar__", "markerStartId": "__marker-s__", "markerEndId": "__marker-e__", "wrap": null, "minimumPadding": null}, "prepend": [{"chars": "__comchar__", "nmb": 1}, {"chars": " ", "nmb": 1}], "lines": [[{"chars": "=", "nmb": 76}], [{"chars": " ", "nmb": 75}, {"chars": "|", "nmb": 1}], [{"chars": "F", "nmb": 1}, {"chars": "i", "nmb": 1}, {"chars": "l", "nmb": 1}, {"chars": "e", "nmb": 1}, {"chars": ":", "nmb": 1}, {"chars": " ", "nmb": 8}, {"chars": "_", "nmb": 2}, {"chars": "f", "nmb": 1}, {"chars": "i", "nmb": 1}, {"chars": "l", "nmb": 1}, {"chars": "e", "nmb": 1}, {"chars": "n", "nmb": 1}, {"chars": "a", "nmb": 1}, {"chars": "m", "nmb": 1}, {"chars": "e", "nmb": 1}, {"chars": "_", "nmb": 2}, {"chars": " ", "nmb": 50}, {"chars": "|", "nmb": 1}], {"size": 76, "padding": {"left": [], "right": [{"chars": " ", "nmb": 1}]}, "surround": {"left": [{"chars": " ", "nmb": 1}], "right": [{"chars": " ", "nmb": 1}]}, "lineContent": {"left": [{"chars": "D", "nmb": 1}, {"chars": "e", "nmb": 1}, {"chars": "s", "nmb": 1}, {"chars": "c", "nmb": 1}, {"chars": "r", "nmb": 1}, {"chars": "i", "nmb": 1}, {"chars": "p", "nmb": 1}, {"chars": "t", "nmb": 1}, {"chars": "i", "nmb": 1}, {"chars": "o", "nmb": 1}, {"chars": "n", "nmb": 1}, {"chars": ":", "nmb": 1}], "right": [{"chars": "|", "nmb": 1}]}}, {"size": 76, "padding": {"left": [], "right": [{"chars": " ", "nmb": 1}]}, "surround": {"left": [{"chars": " ", "nmb": 1}], "right": [{"chars": " ", "nmb": 1}]}, "lineContent": {"left": [{"chars": "L", "nmb": 1}, {"chars": "i", "nmb": 1}, {"chars": "c", "nmb": 1}, {"chars": "e", "nmb": 1}, {"chars": "n", "nmb": 1}, {"chars": "s", "nmb": 1}, {"chars": "e", "nmb": 1}, {"chars": ":", "nmb": 1}, {"chars": " ", "nmb": 4}], "right": [{"chars": "|", "nmb": 1}]}}, [{"chars": " ", "nmb": 75}, {"chars": "|", "nmb": 1}], [{"chars": "=", "nmb": 76}]]}')



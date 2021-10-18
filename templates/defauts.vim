" the format :
"     number of chars per line (not counting the comment chars.s)
"     $chars`$nmb^
"     $chars is the character that should be printed and can be
"
"     the special value __cbtxt__ which is then replace by the comment
"     $nmb is the number of times a chars is repeated and it can be :
"           * null (in which case it's turned to one)
"           * l or r meaning its size is determined by the comment length
"           * any number

" ============================================
" =                                          =
" =                [ __txt__ ]               =
" =                                          =
" ============================================

let g:title = {
                \'prepend': [
                    \{ 'chars' : '__comchar__'},
                    \{ 'chars' : ' '}
                \],
                \'lines' : [
                    \{
                        \'chars' : '=',
                        \'nmb' : 44
                    \},
                    \[
                        \{ 'chars' : '='},
                        \{
                            \'chars' : ' ',
                            \'nmb' : 42
                        \},
                        \{ 'chars' : '='}
                    \],
                    \{
                        \'size' : 46,
                        \'leftPadding' : ' ',
                        \'rightPadding' : ' ',
                        \'surround': {
                            \'left' : { 'chars' : '[ '},
                            \'right' : { 'chars' : ' ]'}
                        \},
                        \'lineContent' : {
                            \'left' : { 'chars' : '='},
                            \'right' : { 'chars' : '='}
                        \}
                    \},
                    \[
                        \{ 'chars' : '='},
                        \{
                            \'chars' : ' ',
                            \'nmb' : 42
                            \},
                        \{ 'chars' : '='}
                    \],
                    \{
                        \'chars' : '=',
                        \'nmb' : 44
                    \}
                \]
            \}

" ================[ __txt__ ]===============
let g:subTitle = {
        \'prepend': [
            \{'chars' : '__comchar__' },
            \{'chars' : ' '}
        \],
        \'lines' : {
            \'size' : 46,
            \'leftPadding' : '=',
            \'rightPadding' : '=',
            \'surround' : {
                \'left' : { 'chars' : '[ '},
                \'right' : { 'chars' : ' ]'}
            \}
        \}
    \}







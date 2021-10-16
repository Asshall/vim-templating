" the format :
"     number of chars per line (not counting the comment char.s)
"     $char`$nmb^
"     $char is the character that should be printed and can be
"
"     the special value __cbtxt__ which is then replace by the comment
"     $nmb is the number of times a char is repeated and it can be :
"           * null (in which case it's turned to one)
"           * l or r meaning its size is determined by the comment length
"           * any number

" ============================================
" =                                          =
" =                [ __txt__ ]               =
" =                                          =
" ============================================
let g:title =<< END
46
__prep__^__comchar__^ ^
__surround__^[ ^ ]
=`44
=^ `42^=
=^ `l^__txt__^ `r^=
=^ `42^=
=`44
END

" ================[ __txt__ ]===============
let g:subTitle =<< END
46
__prep__^__comchar__^ ^
__surround__^[ ^ ]
=`l^__txt__^=`r
END

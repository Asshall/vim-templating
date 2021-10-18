" ============================================
" =                                          =
" =         [ Prints comment blocks ]        =
" =                                          =
" ============================================

" ==================[ Todos ]==================
" * Rn multiline text will be cut wherever
"       (probably in the middle of a word) => cut at
"       right len => :
"               - char is a space => continue (should the space be removed ?)
"               - char isn't a space => :
"                       - iterate left to find the closest space => :
"                               - found a space less than x chars away => continue
"                               - found a space x+n chars away, iterate right => :
"                                       - compare which is the closes => continue
" * May wanna look at justifing text
" * Add more templates
" * Look at the 'Section' thingy and vim doc in general
"       (if thats already been done, i'll be pissed)
" * Try and make a script to convert blocks to templates (should be easy ;) )


" =========[ Comments per filetype ]=========
" Shamefully stolen for nerdCommenter : https://github.com/preservim/nerdcommenter
" Somewhat 'adapted' (read => made barely functional)
let s:ftCommentAssoc = {
    \ 'aap':'#',
    \ 'abc':'%',
    \ 'acedb':'//',
    \ 'actionscript':'//',
    \ 'ada':'--',
    \ 'ahdl':'--',
    \ 'ahk':';',
    \ 'amiga':';',
    \ 'aml':'/*',
    \ 'ampl':'#',
    \ 'ansible':'#',
    \ 'apache':'#',
    \ 'apachestyle':'#',
    \ 'apdl':'!',
    \ 'applescript':'--',
    \ 'armasm':';',
    \ 'asciidoc':'//',
    \ 'asm':';',
    \ 'asm68k':';',
    \ 'asn':'--',
    \ 'asp':'%',
    \ 'aspvbs':'''',
    \ 'asterisk':';',
    \ 'asy':'//',
    \ 'atlas':'C',
    \ 'augeas':'(*',
    \ 'autohotkey':';',
    \ 'autoit':';',
    \ 'ave':"'",
    \ 'awk':'#',
    \ 'basic':"'",
    \ 'bbx':'%',
    \ 'bc':'#',
    \ 'bib':'//',
    \ 'bindzone':';',
    \ 'bind-named':'//',
    \ 'blade':'{{--',
    \ 'bst':'%',
    \ 'btm':'::',
    \ 'c':'/*',
    \ 'cabal':'--',
    \ 'calibre':'//',
    \ 'caos':'*',
    \ 'catalog':'--',
    \ 'cf':'<!---',
    \ 'cfg':'#',
    \ 'cg':'//',
    \ 'ch':'//',
    \ 'cl':'#',
    \ 'clean':'//',
    \ 'clipper':'//',
    \ 'clojure':';',
    \ 'cmake':'#',
    \ 'cocci':'//',
    \ 'coffee':'#',
    \ 'conkyrc':'#',
    \ 'context':'%',
    \ 'coq':'(*',
    \ 'cpp':'//',
    \ 'crontab':'#',
    \ 'cs':'//',
    \ 'csp':'--',
    \ 'cterm':'*',
    \ 'cucumber':'#',
    \ 'cuda':'//',
    \ 'cvs':'CVS:',
    \ 'cypher':'//',
    \ 'cython':'# ',
    \ 'd':'//',
    \ 'dakota':'#',
    \ 'dcl':'$!',
    \ 'debcontrol':'#',
    \ 'debsources':'#',
    \ 'def':';',
    \ 'desktop':'#',
    \ 'dhcpd':'#',
    \ 'diff':'#',
    \ 'django':'{% comment %}',
    \ 'dns':';',
    \ 'docbk':'<!--',
    \ 'dockerfile':'#',
    \ 'dosbatch':'REM ',
    \ 'dosini':';',
    \ 'dot':'//',
    \ 'dracula':';',
    \ 'dsl':';',
    \ 'dtml':'<dtml-comment>',
    \ 'dylan':'//',
    \ 'ebuild':'#',
    \ 'ecd':'#',
    \ 'eclass':'#',
    \ 'eiffel':'--',
    \ 'elf':"'",
    \ 'elixir':'#',
    \ 'elm':'--',
    \ 'elmfilt':'#',
    \ 'ember-script':'#',
    \ 'emblem':'/',
    \ 'erlang':'%',
    \ 'eruby':'<%#',
    \ 'esmtprc':'#',
    \ 'exim':'#',
    \ 'expect':'#',
    \ 'exports':'#',
    \ 'factor':'! ',
    \ 'fancy':'#',
    \ 'faust':'//',
    \ 'fgl':'#',
    \ 'fluent':'#',
    \ 'focexec':'-*',
    \ 'form':'*',
    \ 'fortran':'!',
    \ 'foxpro':'*',
    \ 'fsharp':'(*',
    \ 'fstab':'#',
    \ 'fvwm':'#',
    \ 'fx':'//',
    \ 'gams':'*',
    \ 'gdb':'#',
    \ 'gdmo':'--',
    \ 'gdscript3':'# ',
    \ 'geek':'GEEK_COMMENT:',
    \ 'genshi':'<!--',
    \ 'gentoo-conf-d':'#',
    \ 'gentoo-env-d':'#',
    \ 'gentoo-init-d':'#',
    \ 'gentoo-make-conf':'#',
    \ 'gentoo-package-keywords':'#',
    \ 'gentoo-package-mask':'#',
    \ 'gentoo-package-use':'#',
    \ 'gitcommit':'#',
    \ 'gitconfig':';',
    \ 'gitignore':'#',
    \ 'gitrebase':'#',
    \ 'glsl':'//',
    \ 'gnuplot':'#',
    \ 'go':'//',
    \ 'groff':'\#',
    \ 'groovy':'//',
    \ 'gsp':'<%--',
    \ 'gtkrc':'#',
    \ 'h':'//',
    \ 'haml':'-#',
    \ 'handlebars':'{{!-- ',
    \ 'haskell':'--',
    \ 'haxe':'//',
    \ 'hb':'#',
    \ 'hbs':'{{!-- ',
    \ 'hercules':'//',
    \ 'hive':'-- ',
    \ 'hocon':'//',
    \ 'hog':'#',
    \ 'hostsaccess':'#',
    \ 'htmlcheetah':'##',
    \ 'htmldjango':'{% comment %}',
    \ 'htmlos':'#',
    \ 'hxml':'#',
    \ 'hyphy':'//',
    \ 'ia64':'#',
    \ 'icon':'#',
    \ 'idl':'//',
    \ 'idlang':';',
    \ 'idris':'{-',
    \ 'incar':'!',
    \ 'inform':'!',
    \ 'inittab':'#',
    \ 'ishd':'//',
    \ 'iss':';',
    \ 'ist':'%',
    \ 'jade':'//-',
    \ 'java':'//',
    \ 'javacc':'//',
    \ 'javascript':'//',
    \ 'javascriptreact':'//',
    \ 'javascript.jquery':'//',
    \ 'jess':';',
    \ 'jgraph':'(*',
    \ 'jinja':'{#',
    \ 'jproperties':'#',
    \ 'jsonc':'//',
    \ 'jsonnet':'//',
    \ 'jsp':'<%--',
    \ 'julia':'# ',
    \ 'kivy':'#',
    \ 'kix':';',
    \ 'kscript':'//',
    \ 'lace':'--',
    \ 'laravel':'{{--',
    \ 'ldif':'#',
    \ 'ledger':'#',
    \ 'less':'/*',
    \ 'lhaskell':'>{-',
    \ 'lilo':'#',
    \ 'lilypond':'%',
    \ 'liquid':'{% comment %}',
    \ 'lisp':';',
    \ 'llvm':';',
    \ 'lotos':'(*',
    \ 'lout':'#',
    \ 'lpc':'//',
    \ 'lprolog':'%',
    \ 'lscript':"'",
    \ 'lss':'#',
    \ 'lua':'--',
    \ 'lynx':'#',
    \ 'lytex':'%',
    \ 'm4':'dnl ',
    \ 'mail':'> ',
    \ 'mako':'##',
    \ 'man':'."',
    \ 'mandoc':'.\\"',
    \ 'map':'%',
    \ 'maple':'#',
    \ 'markdown':'<!--',
    \ 'masm':';',
    \ 'mason':'<% #',
    \ 'master':'$',
    \ 'matlab':'%',
    \ 'mel':'//',
    \ 'meson':'#',
    \ 'mib':'--',
    \ 'minizinc':'% ',
    \ 'mips':'#',
    \ 'mirah':'#',
    \ 'mkd':'<!---',
    \ 'mma':'(*',
    \ 'model':'$',
    \ 'modula2':'(*',
    \ 'modula3':'(*',
    \ 'molpro':'!',
    \ 'monk':';',
    \ 'mush':'#',
    \ 'mustache':'{{!',
    \ 'nagios':';',
    \ 'named':'//',
    \ 'nasm':';',
    \ 'nastran':'$',
    \ 'natural':'/*',
    \ 'ncf':';',
    \ 'newlisp':';',
    \ 'nginx':'#',
    \ 'nimrod':'#',
    \ 'nix':'#',
    \ 'nroff':'\"',
    \ 'nsis':'#',
    \ 'ntp':'#',
    \ 'objc':'//',
    \ 'objcpp':'//',
    \ 'objj':'//',
    \ 'ocaml':'(*',
    \ 'occam':'--',
    \ 'octave':'%',
    \ 'omlet':'(*',
    \ 'omnimark':';',
    \ 'ooc':'//',
    \ 'openroad':'//',
    \ 'opl':'REM',
    \ 'ora':'#',
    \ 'ox':'//',
    \ 'paludis-use-conf':'#',
    \ 'pandoc':'<!--',
    \ 'pascal':'{',
    \ 'patran':'$',
    \ 'pcap':'#',
    \ 'pccts':'//',
    \ 'pdf':'%',
    \ 'perl':'#',
    \ 'pfmain':'//',
    \ 'php':'//',
    \ 'pic':';',
    \ 'pike':'//',
    \ 'pilrc':'//',
    \ 'pine':'#',
    \ 'plm':'//',
    \ 'plsql':'-- ',
    \ 'po':'#',
    \ 'poscar':'!',
    \ 'postscr':'%',
    \ 'pov':'//',
    \ 'povini':';',
    \ 'ppd':'%',
    \ 'ppwiz':';;',
    \ 'praat':'#',
    \ 'privoxy':'#',
    \ 'processing':'//',
    \ 'prolog':'%',
    \ 'proto':'//',
    \ 'ps1':'#',
    \ 'psf':'#',
    \ 'ptcap':'#',
    \ 'pug':'//-',
    \ 'puppet':'#',
    \ 'pyrex':'# ',
    \ 'python':'# ',
    \ 'r':'#',
    \ 'racket':';',
    \ 'radiance':'#',
    \ 'ratpoison':'#',
    \ 'rc':'//',
    \ 'rebol':';',
    \ 'registry':';',
    \ 'rego':'#',
    \ 'remind':'#',
    \ 'renpy':'# ',
    \ 'resolv':'#',
    \ 'rgb':'!',
    \ 'rib':'#',
    \ 'rmd':'<!--',
    \ 'robot':'#',
    \ 'robots':'#',
    \ 'rspec':'#',
    \ 'ruby':'#',
    \ 'rust':'//',
    \ 'sa':'--',
    \ 'samba':';',
    \ 'sass':'//',
    \ 'sather':'--',
    \ 'scala':'//',
    \ 'scheme':';',
    \ 'scilab':'//',
    \ 'scilla':'(*',
    \ 'scons':'#',
    \ 'scsh':';',
    \ 'scss':'//',
    \ 'sdc':'#',
    \ 'sed':'#',
    \ 'sentinel':'#',
    \ 'sgmldecl':'--',
    \ 'sgmllnx':'<!--',
    \ 'sh':'#',
    \ 'shader_test':'#',
    \ 'sicad':'*',
    \ 'sile':'%',
    \ 'simula':'%',
    \ 'sinda':'$',
    \ 'skill':';',
    \ 'slang':'%',
    \ 'slice':'//',
    \ 'slim':'/',
    \ 'slrnrc':'%',
    \ 'sls':'#',
    \ 'sm':'#',
    \ 'smarty':'{*',
    \ 'smil':'<!',
    \ 'smith':';',
    \ 'sml':'(*',
    \ 'snakemake':'#',
    \ 'snippets':'#',
    \ 'snnsnet':'#',
    \ 'snnspat':'#',
    \ 'snnsres':'#',
    \ 'snobol4':'*',
    \ 'spec':'#',
    \ 'specman':'//',
    \ 'spectre':'//',
    \ 'spice':'$',
    \ 'spin':'''',
    \ 'sql':'-- ',
    \ 'sqlforms':'-- ',
    \ 'sqlj':'-- ',
    \ 'sqr':'!',
    \ 'squid':'#',
    \ 'ss':';',
    \ 'sshconfig':'#',
    \ 'sshdconfig':'#',
    \ 'st':'"',
    \ 'stan':'//',
    \ 'stp':'/*',
    \ 'supercollider':'//',
    \ 'swift':'/*',
    \ 'systemverilog':'//',
    \ 'tads':'//',
    \ 'tags':';',
    \ 'tak':'$',
    \ 'tasm':';',
    \ 'tcl':'#',
    \ 'teak':'//',
    \ 'terraform':'#',
    \ 'tex':'%',
    \ 'texinfo':'@c ',
    \ 'texmf':'%',
    \ 'tf':'#',
    \ 'tidy':'#',
    \ 'tli':'#',
    \ 'tmux':'#',
    \ 'toml':'#',
    \ 'trasys':'$',
    \ 'troff':'.\\"',
    \ 'tsalt':'//',
    \ 'tsscl':'#',
    \ 'tssgm':"comment = '",
    \ 'ttl':'#',
    \ 'tup':'#',
    \ 'twig':'{#',
    \ 'txt2tags':'%',
    \ 'typescript':'//',
    \ 'typescriptreact':'//',
    \ 'uc':'//',
    \ 'uc4':'!',
    \ 'uil':'!',
    \ 'upstart':'#',
    \ 'vala':'//',
    \ 'vasp':'!',
    \ 'vb': { 'left': "'" },
    \ 'velocity':'##',
    \ 'vera':'/*',
    \ 'verilog':'//',
    \ 'verilog_systemverilog':'//',
    \ 'vgrindefs':'#',
    \ 'vhdl':'--',
    \ 'vimperator':'"',
    \ 'vim':'"',
    \ 'virata':'%',
    \ 'vrml':'#',
    \ 'vsejcl':'/*',
    \ 'webmacro':'##',
    \ 'wget':'#',
    \ 'wikipedia':'<!--',
    \ 'winbatch':';',
    \ 'wml':'#',
    \ 'wvdial':';',
    \ 'xdefaults':'!',
    \ 'xkb':'//',
    \ 'xmath':'#',
    \ 'xpm2':'!',
    \ 'xquery':'(:',
    \ 'yaml':'#',
    \ 'z8a':';',
\ }

" ================[ Commands ]================
command! -nargs=1 Tc call s:PrintTemplate(g:title,<q-args>)
command! -nargs=1 Stc call s:PrintTemplate(g:subTitle,<q-args>)

let g:minimumPadding = 4

" These options define what delimitators should be
" used for templating
let g:blockTextId = '__txt__'
let g:blockComCharId = '__comchar__'

" Returns the comment char for the current file
function! g:FiletypeComment()
    try
        let comChar = s:ftCommentAssoc[&filetype]
    catch
        let comChar = s:ftCommentAssoc['sh']
    endtry
    return comChar
endfunction

" Prints the templates
function! s:PrintTemplate(block, text)
    let g:userText = trim(a:text)

   " Support for prepending every line
    let g:prep = s:ParseElement(a:block.prepend)
    let lines = a:block.lines
    if type(lines) == 3
        for line in lines
            call s:ParseLine(line)
        endfor
    else
        call s:ParseLine(lines)
    endif
endfunction

function! s:ParseLine(toParse)
    let result = s:ParseElement(a:toParse)
    if type(result) == 3
        for resultLine in result
            call s:PrintLine(resultLine)
        endfor
    else
        call s:PrintLine(result)
    endif
endfunction

function! s:PrintLine(toPrint)
    :norm O<CR>
    call setline('.',g:prep.a:toPrint)
endfunction
function s:ParseUDText(uDLine)

    let blockLength = str2nr(a:uDLine.size)
    let surround = {
        \'left': s:ParseElement(a:uDLine.surround.left),
        \'right': s:ParseElement(a:uDLine.surround.right)
    \}
    " Very bad solution.... Should intercept all exeption for missing keys
    " and act in contect of this application or have all values in templates
    if !has_key(a:uDLine, 'lineContent')
        call extend(a:uDLine, {'lineContent': {
                                \'left' : {'chars' : ''},
                                \'right': {'chars' : ''}
                            \}
                        \})
    endif

    " Calculate how much space is left by substracting the length of you line of txt,
    " the length of the string use to prepend / surround text (if present),
    " and all chars present in the template to the max number of chars per line
    let lineContent = [a:uDLine.lineContent.left, a:uDLine.lineContent.right]
    let additionalChars = strchars(g:prep) + strchars(join([surround.left,surround.right],"")) + strchars(s:ParseElement(lineContent))
    let maxCharPerLine = blockLength - additionalChars - g:minimumPadding
    " TODO : What happens if you have multiple lines of userdefined text ?
    " TODO : Hyphenation or word that are longer than a line

    " Determines how many lines should be necessary to print the text
    " in the comment
    let textPerLine = []
    let nmbLine = 0
    let counter = 0
    let wordList = split(g:userText)
    while counter < str2nr(system('echo "'.g:userText.'" | wc -w'))
        let currWord = wordList[counter]
        " Checking if adding a new word to the line will overflow
        " the + 1 is because every word (except for the first one of the line)
        " is prepended with a space
        if nmbLine + 1 > len(textPerLine)
                call add(textPerLine, '')
        endif
        if strchars(textPerLine[nmbLine]) + strchars(currWord) + 1 > maxCharPerLine
            if !empty(textPerLine[nmbLine])
                let nmbLine += 1
            else
                " TODO: Hyphenate word
            endif
        else
            if !empty(textPerLine[nmbLine])
               let textPerLine[nmbLine] .= ' '
            endif
            let textPerLine[nmbLine] .= currWord
            let counter += 1
        endif
    endwhile

    " Per lines of text
    let buff = []
    let counter = 0
    for text in textPerLine
        " Calculate what how much padding you should have on the left/right and substitute
        " the template string with thoses values
        let padding = blockLength - (strchars(text) + additionalChars)
        if counter + 1 > len(buff)
            call insert(buff, "")
        endif
        let buff[0] = s:ParseElement([
                            \a:uDLine.lineContent.left,
                            \{ 'chars' : a:uDLine.leftPadding, 'nmb': padding/2 + padding%2},
                            \{ 'chars' : surround.left },
                            \{ 'chars' : text },
                            \{ 'chars' : surround.right },
                            \{ 'chars' : a:uDLine.rightPadding, 'nmb': padding/2 },
                            \a:uDLine.lineContent.right
                        \])
        let counter += 1
    endfor
    return buff
endfunction

function s:ParseChars(item)
    let chars = a:item.chars
    if chars == g:blockComCharId
        let chars = g:FiletypeComment()
    endif

    if has_key(a:item, 'nmb')
        let nmb = a:item.nmb
    else
        let nmb = 1
    endif
    let nmb = str2nr(nmb)
    return repeat(chars,nmb)
endfunction

function! s:ParseList(list)
    let buffer = ''
    for chars in a:list
        let buffer .= s:ParseChars(chars)
    endfor
    return buffer
endfunction

function! s:ParseElement(el)
    let result = ''
    let elType = type(a:el)
    if elType == 3
        let result = s:ParseList(a:el)
    elseif elType == 4
        if has_key(a:el, 'size')
            let result = s:ParseUDText(a:el)
        else
            let result = s:ParseChars(a:el)
        endif
    endif
    return result
endfunction

" Prints a figlet title as a comment
command! -nargs=1 Fgc call s:PrintFgTitle(<q-args>)
function! s:PrintFgTitle(title)
    let title = split(system('figlet -ck -w '.&textwidth.
    \' -d '.expand('~/.vim/plug_perso/figlet_fonts').' -f cosmic '.trim(a:title)),'\n')
    for line in title
        :norm o<CR>
        call setline('.',g:FiletypeComment().' '.line)
    endfor
endfunction

" runtime templates/*

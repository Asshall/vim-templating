" ============================================
" =                                          =
" =         [ Prints comment blocks ]        =
" =                                          =
" ============================================

" ==================[ Todos ]==================
" * Add more templates
" * Look at the 'Section' thingy and vim doc in general
"       (if thats already been done, i'll be pissed)
" * Try and make a script to convert blocks to templates (should be easy ;) )


" if exists('g:blockTemplating#Loaded')
"     finish
" endif
" let g:blockTemplating#Loaded = 1

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


let g:blockTemplating#minimumPadding = get(g:, 'blockTemplating#minimumPadding', 4)
" These options define what delimitators should be
" used for templating
let g:blockTemplating#blockTextId = get(g:, 'blockTemplating#blockTextId', '__txt__')
let g:blockTemplating#blockComCharId = get(g:, 'blockTemplating#blockComCharId', '__comchar__')

" Returns the comment char for the current file
function! g:blockTemplating#ftComment()
    if has_key(s:ftCommentAssoc, &filetype)
        let l:comChar = s:ftCommentAssoc[&filetype]
    else
        let l:comChar = s:ftCommentAssoc['sh']
    endif
    return l:comChar
endfunction

" Prints the templates
function! s:PrintTemplate(block, text)
    let s:userText = trim(a:text)
    " Support for prepending every line
    let s:prep = s:ParseElement(a:block.prepend)


    let l:lines = a:block.lines
    if type(l:lines) == 3
        for line in l:lines
            call s:ParseLine(line)
        endfor
    else
        call s:ParseLine(l:lines)
    endif
endfunction

function! s:ParseLine(toParse)
    let l:result = s:ParseElement(a:toParse)
    if type(l:result) == 3
        for l:resultLine in l:result
            call s:PrintLine(l:resultLine)
        endfor
    else
        call s:PrintLine(l:result)
    endif
endfunction

function! s:PrintLine(toPrint)

    :norm O<CR>
    call setline('.',s:prep.a:toPrint)
endfunction

function s:ParseUDText(uDLine)

    let l:blockLength = str2nr(a:uDLine.size)
    let l:surround = {
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
    let l:lineContent = [a:uDLine.lineContent.left, a:uDLine.lineContent.right]
    let l:additionalChars = strchars(s:prep) + strchars(join([l:surround.left,l:surround.right],"")) + strchars(s:ParseElement(l:lineContent))
    let l:maxCharPerLine = l:blockLength - l:additionalChars - g:blockTemplating#minimumPadding
    " TODO : What happens if you have multiple lines of userdefined text ?
    " TODO : Hyphenation or word that are longer than a line

    " Determines how many lines should be necessary to print the text
    " in the comment
    let l:textLine = []
    let l:nmbLine = 0
    let l:counter = 0
    let l:wordList = split(s:userText)
    while l:counter < str2nr(system('echo "'.s:userText.'" | wc -w'))
        let l:currWord = l:wordList[l:counter]
        " Checking if adding a new word to the line will overflow
        " the + 1 is because every word (except for the first one of the line)
        " is prepended with a space
        if l:nmbLine + 1 > len(l:textLine)
                call add(l:textLine, '')
        endif
        if strchars(l:textLine[l:nmbLine]) + strchars(l:currWord) + 1 > l:maxCharPerLine
            if !empty(l:textLine[l:nmbLine])
                let l:nmbLine += 1
            else
                " TODO: Hyphenate word
            endif
        else
            if !empty(l:textLine[l:nmbLine])
               let l:textLine[l:nmbLine] .= ' '
            endif
            let l:textLine[l:nmbLine] .= l:currWord
            let l:counter += 1
        endif
    endwhile

    " Per lines of text
    let l:buffer = []
    let l:counter = 0
    for l:text in l:textLine
        " Calculate what how much padding you should have on the left/right and substitute
        " the template string with thoses values
        let l:padding = l:blockLength - (strchars(l:text) + l:additionalChars)
        if l:counter + 1 > len(l:buffer)
            call insert(l:buffer, "")
        endif
        let l:buffer[0] = s:ParseElement([
                            \a:uDLine.lineContent.left,
                            \{ 'chars' : a:uDLine.leftPadding, 'nmb': l:padding/2 + l:padding%2},
                            \{ 'chars' : surround.left },
                            \{ 'chars' : l:text },
                            \{ 'chars' : surround.right },
                            \{ 'chars' : a:uDLine.rightPadding, 'nmb': l:padding/2 },
                            \a:uDLine.lineContent.right
                        \])
        let l:counter += 1
    endfor
    return l:buffer
endfunction

function s:ParseChars(item)
    let l:chars = a:item.chars
    if l:chars == g:blockTemplating#blockComCharId
        let l:chars = g:blockTemplating#ftComment()
    endif

    if has_key(a:item, 'nmb')
        let l:nmb = a:item.nmb
    else
        let l:nmb = 1
    endif
    return repeat(l:chars,nmb)
endfunction

function! s:ParseList(list)
    let l:buffer = ''
    for l:chars in a:list
        let l:buffer .= s:ParseChars(l:chars)
    endfor
    return l:buffer
endfunction

function! s:ParseElement(el)
    let l:result = ''
    let l:elType = type(a:el)
    if l:elType == 3
        let l:result = s:ParseList(a:el)
    elseif l:elType == 4
        if has_key(a:el, 'size')
            let l:result = s:ParseUDText(a:el)
        else
            let l:result = s:ParseChars(a:el)
        endif
    endif
    return l:result
endfunction

runtime templates/*

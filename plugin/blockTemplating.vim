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

" These options define what delimitators should be
" used for templating
let g:blockTextId = '__txt__'
let g:blockCharSep = '\^'
let g:blockNmbSep = '\`'
let g:blockComCharId = '__comchar__'
let g:blockPrepId = '__prep__'
let g:blockSurrId = '__surround__'

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
    let text = trim(a:text)
    " The first line in a template is always the length of the block
    let blockLength = a:block[0]
    let dataStartIndex = 1

    " Support for prepending every line
    let prep = ""
    let prepLine = split(a:block[dataStartIndex], g:blockCharSep)
    if prepLine[0] == g:blockPrepId
        let prep = s:ParseLine(prepLine[1:-1])
        let dataStartIndex += 1
    endif
    unlet prepLine

    " Support for surrounding text
    let surround = ["",""]
    let surroundLine = split(a:block[dataStartIndex], g:blockCharSep)
    if surroundLine[0] == g:blockSurrId
        let surround = surroundLine[1:2]
        let dataStartIndex += 1
    endif
    unlet surroundLine

    let additionalChars = (strchars(prep) + strchars(join(surround,"")))
    let maxCharPerline = blockLength - additionalChars
    for line in a:block[dataStartIndex:-1]
        if !empty(matchstr(line,g:blockTextId))
            " Determines how many lines should be necessary to print the text
            " in the comment while keeping 4 chars of padding (if present in template)
            let textLen = strchars(text)
            " Weird way to devide by two and get the bigger half if there is one
            let nmbOfLines = float2nr(ceil(textLen / (maxCharPerline + 0.0) ))
            let textPerLine = []
            let nmbCharPerLine = textLen / nmbOfLines
            let splittedString = split(text,'\zs')
            let counter = 0
            " Divides the string in nth substring dependant on it's size
            while counter < nmbOfLines
                call add(textPerLine, join(splittedString[counter * nmbCharPerLine
                \:(counter + 1) * nmbCharPerLine], ""))
                let counter += 1
            endwhile
            " No idea if that's necessary
            unlet counter
            unlet textLen
            unlet nmbCharPerLine
            unlet nmbOfLines
            unlet splittedString
            " Per lines of text
            for textline in textPerLine
                " Calculate how much space is left by substracting the length of you line of txt,
                " the length of the string use to prepend / surround text (if present),
                " and all chars present in the template to the max number of chars per line
                let padding = blockLength - (strchars(s:ParseLine(
                            \substitute(line, g:blockTextId.g:blockCharSep, '', '')))
                            \+ strchars(textline) + additionalChars)
                " Calculate what how much padding you should have on the left/right and substitute
                " the template string with thoses values
                let beginPad = float2nr(ceil(padding / 2.0))
                let fullLine = substitute(line, 'l', beginPad, '')
                \->substitute('r', padding - beginPad, '')
                \->substitute(g:blockTextId, surround[0].textline.surround[1], '')
                :norm O<CR>
                call setline('.',prep.s:ParseLine(fullLine))
            endfor
        else
            :norm O<CR>
            call setline('.',prep.s:ParseLine(line))
        endif
    endfor
endfunction

function s:ParseLine(line)
    let result = ""
    " Type casting to a string if input is a list
    let typeLine = type(a:line)
    if typeLine == 1
        let line = split(a:line, g:blockCharSep)
    elseif typeLine == 3
        let line = a:line
    endif
    for operation in line
        try
            let [char, nmb] = split(operation,g:blockNmbSep)
        catch
            let char = split(operation,g:blockNmbSep)[0]
            let nmb = 1
        endtry
        " Doesn't handle multiple comment chars
        if char == g:blockComCharId
            let char = g:FiletypeComment()
        endif
        if str2nr(nmb) == 0 " Continue if nmb is not a number
            continue
        endif
        let nmb = str2nr(nmb)
        let result = result.repeat(char,nmb)
    endfor
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

runtime templates/*

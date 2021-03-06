" ============================================
" =                                          =
" =  [ Filetype comment char lookup table ]  =
" =                                          =
" ============================================

" Shamefully stolen for nerdCommenter : https://github.com/preservim/nerdcommenter
" Soewhat 'adapted' (read => made barely functional)
" {{{ Comment lookup table
let s:assoc = {
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
" }}}
" Returns the comment char for the current file
function! g:ftComment#get()
    return has_key(s:assoc, &filetype) ?
    \s:assoc[&filetype] : '#'
endfunction

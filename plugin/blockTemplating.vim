
" ==================[ Todos ]==================
" TODO : Add more templates
" TODO :Try and make a script to convert blocks to templates (should be easy ;) )
" TODO :Is there a way to better handle nulls and wrong values in the templates ?
"       making a tool to make templates should cover the wrong values but I still
"       want to keep the options of making/modifying your templates by hand viable...
" TODO: Documentation...

" if exists('g:blockTemplating#Loaded')
"     finish
" endif
" let g:blockTemplating#Loaded = 1

"{{{ ================[ Commands ]================
nnoremap <silent> <leader>b :Bt g:defaults#
command! -complete=var -nargs=+ Bt call s:PrintTemplate(<f-args>,<q-args>)
"}}
" Define the minimum number of chars to pad the text (can be set to 0)
let g:blockTemplating#minimumPadding = get(g:, 'blockTemplating#minimuomPadding', 4)
" If set the text will no wrap on multiple lines if too long for the block
let g:blockTemplating#wrap = get(g:, 'blockTemplating#wrap', 1)
" These options define what special should be
" used for templating
let g:blockTemplating#textId = get(g:, 'blockTemplating#textId', '__txt__')
let g:blockTemplating#comCharId = get(g:, 'blockTemplating#comCharId', '__comchar__')
let g:blockTemptating#markerStartId = get(g:, 'blockTemplating#markerStartId', '__marker-s__')
let g:blockTemplating#markerEndId = get(g:, 'blockTemplating#markerEndId', '__marker-e__')

" Prints the templates
function! s:PrintTemplate(json, text) abort
    let s:userText = split(trim(a:text), '\\')
    let s:json = {a:json}

    " Support for prepending every line
    let s:prep = ''
    if has_key(s:json, 'prepend')
        let s:prep = s:ParseElement(s:json.prepend)
    endif
    " Template level option override
    let s:overrides = {}
    if has_key(s:json, 'overrides')
        for override in s:json.overrides->keys()
            let val = s:json.overrides[override]
            if !empty(val)
                execute 'let s:overrides.'.override.' = "'.val.'"'
            endif
        endfor
    endif
    let lines = s:json.lines
    let block = ''
    " The 'lines' element of a dict can either be a list
    " or a single element (if there is only one line)
    " Is there a way to handle both case the same way
    " without changing the 'lines' element to always be a list ?
    if type(lines) == 3
        for line in lines
            let block .= s:ParseElement(line)."\n"
        endfor
    else
            let block .= s:ParseElement(lines)
    endif
    " Print lines to file (is there a better way ?)
    " I don't like having to split the block
    for line in split(block, '\n')
        :norm o<CR>
        call setline('.',s:prep.line)
    endfor
endfunction

function s:getOpt(name)
    return get(s:overrides, a:name,get(g:, 'blockTemplating#'.a:name))
endfunction

" Parse the lines of text
function s:ParseUDText(uDLine) abort

    " To accomodate for empty values in the template
    for key in ['padding', 'surround', 'lineContent']
        if !has_key(a:uDLine,key) || empty(a:uDLine[key])
            let a:uDLine[key] = {}
        endif
        for side in ['left', 'right']
            if !has_key(a:uDLine[key],side) || empty(a:uDLine[key][side])
                let a:uDLine[key][side] = [{ 'chars' : '' }]
            endif
        endfor
    endfor
    unlet key side
    let blockLength = str2nr(a:uDLine.size)
    " Calculate how much space is left by substracting the length of the text
    " you input, the length of the string use to prepend / surround text (if present),
    " and all chars other chars present in the template on that line
    " to the max number of chars per line
    let additionalChars =
        \+ strchars(s:ParseElement([a:uDLine.surround.left,a:uDLine.surround.right]))
        \+ strchars(s:ParseElement([a:uDLine.lineContent.left,a:uDLine.lineContent.right]))
    let maxCharPerLine = blockLength - (additionalChars + g:blockTemplating#minimumPadding)
    " TODO : What happens if you have multiple lines of userdefined text ?
    " TODO : Hyphenation of word that are longer than a line

    " Determines how many lines should be necessary to print the text
    let textLine = []
    if s:getOpt('wrap')
        let wordList = split(s:userText[0])
        call remove(s:userText,0)
        let lineIdx = 0
        for word in wordList
            if lineIdx == len(textLine) | call add(textLine, '') | endif
            " If the text on the current line is too long
            if strchars(textLine[lineIdx]) + strchars(word) + 1 > maxCharPerLine
                " The line is composed of multiple word go to next line
                if !empty(textLine[lineIdx])
                    let lineIdx += 1
                else
                    " TODO: Hyphenate word
                endif
            else
                " Add a space between word if this is not the first of the line
                if !empty(textLine[lineIdx])
                    let textLine[lineIdx] .= ' '
                endif
                let textLine[lineIdx] .= word
            endif
        endfor
        unlet lineIdx wordList word
    else " If the wrap option is not set, expand the line size for the whole text to fit
        call add(textLine, s:userText[0])
        let diff = blockLength - (strchars(s:userText[0]) + s:getOpt('minimumPadding') + additionalChars)
        call remove(s:userText,0)
        if diff < 0
            let blockLength += abs(diff)
        endif
        unlet diff
    endif

    " Is there a better way to initialize an empty list with n items
    let nmbLines = len(textLine)->range()
    " This definitly does not feel like the intented solution...
    " but it's a oneliner so...
    let buffer = copy(nmbLines)->map('""')

    " Per lines of text
    for i in nmbLines
        " Calculate how much padding you should need on the line
        let nmbToPad = blockLength - (strchars(textLine[i]) + additionalChars)
        " Divides the padding by 1 (nop) if there is only padding on one side
        " and by two if there is padding on both sides
        let bySide = nmbToPad

        for j in len(copy(a:uDLine.padding)->filter('!empty(v:val[0].chars)'))->range()
            if !empty(a:uDLine.padding->values()[j]) | let bySide /= j + 1  | endif
        endfor

        " Build the line
        let buffer[i] .= s:ParseElement(a:uDLine.lineContent.left)
        let buffer[i] .= repeat(a:uDLine.padding.left[0].chars,bySide + nmbToPad % 2)
        let buffer[i] .= s:ParseElement(a:uDLine.surround.left)
        let buffer[i] .= textLine[i]
        let buffer[i] .= s:ParseElement(a:uDLine.surround.right)
        let buffer[i] .= repeat(a:uDLine.padding.right[0].chars, bySide)
        let buffer[i] .= s:ParseElement(a:uDLine.lineContent.right)
    endfor
    return buffer->join("\n")
endfunction

" Parse the smallest element of a template => the dict { char : nmb }
function s:ParseChars(item) abort
    if empty(a:item)
        return ''
    endif
    let chars = a:item.chars
    " Special characters
    if chars == s:getOpt('comCharId')
        let chars = g:ftComment#get()
    elseif chars == s:getOpt('markerStartId')
        let chars = split(&foldmarker, ',')[0]
    elseif chars == s:getOpt('markerEndId')
        let chars = split(&foldmarker, ',')[1]
    endif
    if a:item->has_key('nmb')
        let nmb = a:item.nmb
    else
        let nmb = 1
    endif
    return repeat(chars,nmb)
endfunction

" Wrapper to parse any element, for now thoses elements are
" sorted by type... I'd like to find another way
function! s:ParseElement(el) abort
    let result = ''
    let elType = type(a:el)

    if elType == 3
        for item in a:el
            let result .= s:ParseElement(item)
        endfor
    elseif elType == 4
        if a:el->has_key('size')
            let result = s:ParseUDText(a:el)
        else
            let result = s:ParseChars(a:el)
        endif
    endif
    return result
endfunction

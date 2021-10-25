#!/usr/bin/python

from usage import defaultUsage, morehelp
from sys import argv, exit as sys_exit
from os import path
from getopt import gnu_getopt as getopt, GetoptError
from json import dumps as dump_json
from re import compile as re_compile, search as re_search

def expand_return(func):
    def wrapper_func(*args):
        result = func(*args)
        if len(result) == 1 :
            return result[0]
        elif len(result) == 0:
            return {}
        else:
            return result
    return wrapper_func

def get_ids():
    return [id[1] for id in OPTIONS['overrides'].items() if id[0][-2:] == 'Id']

# Add special char support
def get_special_char_idx(l):
    idReg = re_compile('|'.join(get_ids()))
    return [match.start() for match in idReg.finditer(l)], \
        [match.end() for match in idReg.finditer(l)]


def get_index(l):
    return l[0] if l else None

# Remove the padding char in front of line content
def clean_lineContent(lc,p):
    parsedLc = parse_line(lc)
    if p and 'chars' in p[0] :
        return parsedLc[:-1] if parsedLc[-1]['chars'] == p[0]['chars'] else parsedLc
    else : 
        return parsedLc

# The reverse argument is to traverse the line from
# right to left. Padding and surround are defined by the fact
# that they're surrounding user text, so you need to traverse
# from where user text is situated in the original block
# aka   left side : right to left
#       right side: left to right
@expand_return
def parse_text_line(line, isLeft=False):
    padding, surround, lineContent, prevChar = '', '','', ''
    counter = 0
    def inverse(s):
        return  s[::-1] if isLeft else s
    line = inverse(line)

    starts, ends = get_special_char_idx(line)
    while counter < len(line):
        start = get_index(starts)
        if counter == start:
            end = get_index(ends)
            if prevChar == line[start:end]:
                padding = prevChar
                surround = line[:counter-1]
                lineContent = line[counter-1:]
            else:
                prevChar = line[start:end]
                counter += end - start
                starts.pop(0); ends.pop(0)
        # Skip the first iter
        if counter > 0:
            # If you haven't found values at the end of the line
            # the padding is the last char and surround is the rest
            if counter == len(line) - 1:
                padding = line[counter]
                surround = line[:counter]
            # If you have twice the same char then it's padding*
            # Whatever came before is surround and anything after
            # that is not consecutively the padding char is linecontent
            #
            # *: This limitation means that you can't surround your text
            # with multiple time the same chars. But this can be
            # remediated by supplying the surround option
            elif line[counter] == prevChar:
                padding = line[counter]
                surround = line[:counter-1]
                lineContent = line[counter-1:]
                break
            # If the char if different for the last, loop again
            else: prevChar = line[counter]
        counter += 1

    lineContent = clean_lineContent(lineContent, padding)
    return { 'chars' : padding }, parse_line(inverse(surround)), inverse(lineContent)

def parse_line(line):
    result = []

    def append_result(char):
        result.append({'chars': char, 'nmb' : 1 })
    counter = 0
    starts, ends = get_special_char_idx(line)
    while counter < len(line):
        start = get_index(starts)
        if counter == start:
            end = get_index(ends)
            if result and result[-1]['chars'] == line[start:end]:
                result[-1]['nmb'] += 1
            else:
                append_result(line[start:end])
            counter += end - start - 1
            starts.pop(0); ends.pop(0)
        elif not result or result[-1]['chars'] != line[counter]:
            append_result(line[counter])
        else:
            result[-1]['nmb'] += 1
        counter += 1
    return result

def parse_line_wrapper(line):
    currIndex = 0

    if OPTIONS['overrides']['textId'] in line:
        splittedLine = line.split(OPTIONS['overrides']['textId'])
        # Compute the length of the line by making all ids size (but textId) only 1
        ids = re_compile('|'.join(\
        [id for id in get_ids() if id != OPTIONS['overrides']['textId']]))

        result = {
                        'size': len(line) - sum([len(match)\
                                - 1 for match in ids.findall(line)]),
                        'padding' : {},
                        'surround' : {},
                        'lineContent': {}
        }
        # This is dumb, and is a consequence of bad code
        # plz change me
        try:
            exceptMsg = '''{0} {1} char : "{2}" 
            is not null and not contained in line : "{3}"'''
            for attr in ['surround', 'padding']:
                dictTmp = {'left' : {}, 'right' : {}}
                if OPTIONS[attr][0]:
                    for side in ['left', 'right']:
                        if OPTIONS[attr][0][side] and\
                        OPTIONS[attr][0][side] not in line:
                            raise Exception(exceptMsg.format(attr,\
                            side, OPTIONS[attr][0][side], line))
                        else: dictTmp[side] = parse_line(OPTIONS[attr][0][side])
                    result[attr] = dictTmp
        except Exception as err:
            sys_exit('''ERROR Bad option(s): {0}\n If provided surround/padding chars should be contained in the text line\n Check the format :\n\n{1}'''.format(err,usage))

        #  print(result)
        # I don't how I feel about this... This is really cumbersome
        # Espcially having to reverse the left part twice (it has to be reversed to
        # precess it and is then returned reverse once more)
        if result['surround'] and result['padding']:
            # If both surround and padding are known, lineContent is the rest
            result['lineContent']['left'] = clean_lineContent(\
                    splittedLine[0][::-1][len(result['padding']['left']) + len(result['surround']['left']):][::-1],\
                    result['padding']['left'])

            result['lineContent']['right'] = clean_lineContent(\
                    splittedLine[1][len(result['padding']['right']) + len(result['surround']['right']):],\
                        result['padding']['right'])
            # Not a brilliant move but it's either this or keep an
            # index of the line your processing
            OPTIONS['padding'].pop(0); OPTIONS['surround'].pop(0);
        elif result['surround']:
            # If only surround is known, padding is the following character
            # and lineContent is the rest
            surrLenL = len(result['surround']['left'])
            result['padding']['left'] = splittedLine[0][::-1][surrLenL]
            result['lineContent']['left'] = clean_lineContent(\
                    splittedLine[0][::-1][surrLenL+1:][::-1], result['padding']['left'])

            surrLenR = len(result['surround']['right'])
            result['padding']['right'] = splittedLine[1][surrLenR]
            result['lineContent']['right'] = clean_lineContent(\
                    splittedLine[1][surrLenR+1:], result['padding']['right'])

            OPTIONS['surround'].pop(0)
        elif result['padding']:
            # If only padding is known, surround are the preceeding characters
            # and lineContent the folowing
            idxL = re_search(result['padding']['left'], splittedLine[0][::-1]).start()
            result['surround']['left'] = splittedLine[0][::-1][:idxL][::-1]
            result['lineContent']['left'] = clean_lineContent(\
                    splittedLine[0][::-1][idxL+1:], result['padding']['left'][::-1])

            idxR = re_search(result['padding']['right'], splittedLine[1]).start()
            result['surround']['right'] = splittedLine[1][:idxR]
            result['lineContent']['right'] = clean_lineContent(\
                    splittedLine[1][idxR+1:], result['padding']['right'])

            OPTIONS['padding'].pop(0)
        else: # Let the script decides thoses values
            result['padding']['left'], result['surround']['left'], \
                result['lineContent']['left'] =\
                parse_text_line(splittedLine[0], True)


            result['padding'], result['surround']['right'], \
                result['lineContent']['right'] =\
                parse_text_line(splittedLine[1])

    else:
        result = parse_line(line)
    return result

OPTIONS = {

    'overrides' : {
        'textId' : '__txt__',
        'comCharId' : '__comchar__',
        'markerStartId' : '__marker-s__',
        'markerEndId' : '__marker-e__',
        'wrap' : None,
        'minimumPadding' : None,
    },
    'prepend' : None,
    'padding' : [None],
    'surround' : [None],
    'output' : None,
}
usage = defaultUsage.format(path.splitext(argv[0])[0])

if __name__ == '__main__':


    all_args = argv[1:]
    try:
        opts, args = getopt(all_args, 'hHp:P:s:o:O:', [ \
                'help', 'morehelp', \
                'prepend=', 'padding=', 'surround=', \
                'output=', 'override=', \
        ])
        if not args: raise GetoptError('No input file was provided')

    except GetoptError as err:
        sys_exit(f'ERROR Bad option(s) : {err}\n\n{usage}')

    try:
        def parse_ps(val,n):
            OPTIONS[n] = []
            for v in val.split(','):
                l,r = v.split(':')
                OPTIONS[n].append({
                    'left' : l,
                    'right' : r
                })

        for opt in opts:
            name = opt[0]
            value = opt[1]
            if re_search('--?h(help)?', name):
                sys_exit(usage)
            elif re_search('-(H|-morehelp)', name):
                sys_exit(morehelp)
            elif re_search('--?p(repend)?', name):
                OPTIONS['prepend'] = parse_line(value)
            elif re_search('--?[Pp](adding)?', name):
                parse_ps(value, 'padding')
            elif re_search('--?s(urround)?', name):
                parse_ps(value, 'surround')
            elif re_search('--?o(utput)?', name):
                OPTIONS['output'] = value
            elif re_search('--?[Oo](verride)?', name):
                for override in value.split(','):
                    n, v = override.split(':')
                    OPTIONS['overrides'][n] = v

    except ValueError as err:
        sys_exit(f'ERROR Bad option(s) format\n\n{usage}')

    inputFile = args[0]
    with open(inputFile, 'r') as f:
        lines = f.readlines()
    output = {
                'overrides' : OPTIONS['overrides'],
                'prepend': OPTIONS['prepend'],
                'lines': []
    }
    for line in lines:
        output['lines'].append(parse_line_wrapper(line.strip('\n')))
    if OPTIONS['output']:
        of = open(OPTIONS['output'], 'a')
        output = dump_json(output)
        of.write(f'\n\nlet g:varName = json_decode(\'{output}\')')
        of.close()
    else:
        output = dump_json(output, sort_keys=True, indent=4)
        print('Input :\n\n{0}\n\nOutput :\n\n{1}'.format(''.join(lines), output))

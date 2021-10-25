defaultUsage = '''Usage: {0} inputFile [-opt]
Options (fields in '[]' are optional, '<>' are required):

  --help -h                     This help

  --morehelp -H                 Another help message with more details on the concepts

  --prepend -p <pager>          Chars use to prepend every line

  --padding -P <s-format>       Chars that sould be used to pad text

  --surround -s <s-format>      Chars that should be used to surround text

  --ouput -o <file>             Ouput to file rather than stdout

  --override -O <opt_format>    Used to override plugin options at a template level

This command convert a block of text into a json to use with vim-blockTemplating


FORMATS AND NOTES:

  IMPORTANT There is no input sanitazation on the plugin side so make sure to
            take a look at json template you haven't made yourself
  IMPORTANT If the value provided containes space chars surround it with quotes
  * s-format : <CharLeft>;<CharRight>
                  l_n:r_n,l_n+1:r_n+1
                  For multiple lines of text comma separate values

      - If multiple lines of text and only one pair of chars are provided, they'll
      be used for every lines
      - If -p or -s options are not provided the script will try to do it's
      best to find correct values following this logic :
          * Look at char n and n+1
              * if they don't match continue to loop
              * if they match the char n is padding, and everything comming before
              is surround
      - If surround is provided but not padding. The padding chars will be the one
      directly following the surround chars
      - If padding is provided everything before will be surround

  * opt-format
      option_name:value,nthoption_name:value,

      Options names :
          - wrap            boolean: default(1)
              Do not wrap line if text is too long
          - minimumPadding  number: default(4)
              The minimum number of chars of padding in a text line
          - textId          string: default(' __txt__') :
              See -H
          - comCharId       string: default('__comchar__') :
              See -H
          - markerStartId/markerEndId   stirng: default('__marker-s/e__')'
              See -H

'''


morehelp = '''
Wtf is this format !?:


  Here's how line could be formated :

  __comchar__ ===============[ __txt__ ]===============
  \__________/\_____________/^    ^    ^\_____________/
       ^             ^      /     |     \      ^
      /           _ /      /      |      \      \_
     /           /        /       |       \       \
    p           pl       sl       ut      sl       pr

  * __varname__ : special char, used as variables :
      __comchar__ : this is the character(s) used to denote the comments
                    in the filetype of your current buffer
      __marker-s__ and __marker-e__ : The are the value of the vim options 'foldmarker'
                                      the first one being the chars before the ',' and the
                                      second the rest
  * p aka prepend: Character used to prepend every line. Usefull for comments or fold markers
                    but also completlly facultative as you could have the same result by having
                    the same value on every line. The idea is that it makes it easier to swap
                    this out

  * pl/pr aka padding (left and right): Characters on a text line used to pad the line
                    if the text is to small. They are not optional. They can only be one char

  * sl/sr aka surround (left and right):  Characters one the text line directly around the text.

  * ut aka user text : Text defined by the user.


Helping the script :


  The script will be able to fill in those values for you (not prepend) but the result
  might not be satifying. It's good practice to supply all the values as options
  and take a look to the resulting json as well... Shit might be outta wack


Json format and gotchas :


  The original block of text :

  __marker-s__=========================================
  =                [ __txt__ ]               =
  ============================================


  The command line : python3 inputFile -p '__comchar__ ' -P ' : ' -s '[ : ]' -O wrap:0


  The intended output (abit altered to make it more readable) :

  {
      "prepend": "__comchar__ ",    # Start every line with a comment and a space
      "lines": [    # Every item of this list is a line. If there is only one line
                    # the list can be ommited

          # Items are lists of dicts with every dict being a char and the
          # number of times it's repeated (no "num" key means repeated only once)
          # If there is only one dict in the list, the list can be ommited.
          [ # Line no 1
            # Gotcha number 1
              {
                  "chars": "__marker-s__",    # The first char is a vim marker oppening
                  "nmb": 1
              },
              {
                  "chars": "=", 41 times the equal char
                  "nmb": 41
              }
          ],
          { # A text line
            # Gotcha number 2
              "size": 44, # Max size of the line. Can be ignored by unsetting the 'wrap' option
              "surround": {   # Surround the text like this [ __text__ ]
                  "left": "[ ",
                  "right": " ]"
              },
              "padding": {    # Pad the text with spaces on both the left and right side
                  "left": " ",
                  "right": " "
              },
              "lineContent": { # Other character on the text line
                  "left": "=",
                  "right": "="
              }
          },
          {
              "chars": "=",
              "nmb": 44
          },
      ],
      "overrides": { # The plugin options overrides for this template,
                     # even if you've specified none they'll all be there
                     # with either null or default values. In this example wrap as
                     # been changed
          "textId": "__txt__",
          "comCharId": "__comchar__",
          "markerStartId": "__marker-s__",
          "markerEndId": "__marker-e__",
          "minimumPadding": null,
          "wrap": 0
      },
  }
  Gotchas :
  - For more 'complexe' templates you will have to make some changes on the json itself
  - This tool has a lot of flaws, bugs and edge cases, it's reason to exist it to simplify
    the process of converting big blocks into templates not completely automate it
  1: In this exemple there is no way for the script to know the length of you vim opening
    marker so you have to do it by hand. I use the default marker wich is '{{{' so
    that's 3 chars I have to remove from the line thus 41 equals rather than 44
  2: For now there can only be one text element per line. Trying to put two might result
    in both this script and the plugin shitting the bed
'''

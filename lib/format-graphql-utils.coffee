CURLY_CLOSE = undefined
CURLY_OPEN = undefined
INDENT = undefined
DOT = undefined
COMMA = undefined
NAMES = undefined
NEW_LINE = undefined
ROUND_CLOSE = undefined
ROUND_OPEN = undefined
SPACE = undefined
SQUARE_CLOSE = undefined
SQUARE_OPEN = undefined
UtilsFlattenGql = undefined
SPECIAL_WORDS = undefined
SPECIAL_CHARS = undefined
CURLY_OPEN = '{'
CURLY_CLOSE = '}'
SQUARE_OPEN = '['
SQUARE_CLOSE = ']'
ROUND_OPEN = '('
ROUND_CLOSE = ')'
SPACE = ' '
INDENT = '  '
DOT = '...'
COMMA = ','
NEW_LINE = '\n'
SPECIAL_WORDS = [
  'query'
  'mutation'
  'fragment'
  'edges'
  'node'
  'type'
  'fields'
  '...'
]
SPECIAL_CHARS = [
  '('
  ')'
  '{'
  '}'
]

module.exports = UtilsFlattenGql =
  flatten: (query)->
    i = 0
    char = undefined
    result = ''
    spaceFound = 0
    while i < query.length
      char = query[i]
      if char == NEW_LINE
        char = SPACE
      if char == SPACE or char == COMMA
        spaceFound++
      else
        spaceFound = 0
      if spaceFound > 1
        i++
        continue
      result += char
      i++
    return result
  unflatten: (query) ->
    a = undefined
    b = undefined
    c = undefined
    char = undefined
    i = undefined
    indentCount = undefined
    lastChar = undefined
    nextChar = undefined
    result = undefined
    spaces = undefined
    word = undefined
    makeIndent = undefined
    word = ''
    result = ''
    indentCount = 0
    makeIndent = true
    i = 0
    while i < query.length
      lastChar = query[i - 1]
      char = query[i]
      nextChar = query[i + 1]
      spaces = ''
      a = 0
      b = 0
      c = 0

      if char == SPACE and lastChar == CURLY_OPEN or char == SPACE and nextChar == CURLY_CLOSE
        i++
        continue

      word = if char == SPACE or char == COMMA then '' else word + char

      if SPECIAL_WORDS.indexOf(word) != -1 or SPECIAL_CHARS.indexOf(char) != -1
        makeIndent = false

      if char == CURLY_OPEN
        indentCount++

        while a < indentCount
          spaces += INDENT
          a++
        result += char + NEW_LINE + spaces
        spaces = ''
        makeIndent = true

      else if char == CURLY_CLOSE
        indentCount--

        while b < indentCount
          spaces += INDENT
          b++
        result += NEW_LINE + spaces + char
        spaces = ''
        makeIndent = true

      else if (char == SPACE or char == COMMA) and makeIndent

        while c < indentCount
          spaces += INDENT
          c++

        if char == COMMA
          result += char
        result += NEW_LINE + spaces
        spaces = ''

      else
        result += char
      i++

    return result

graphql = require 'graphql'

COMMA = undefined
NEW_LINE = undefined
SPACE = undefined
UtilsFlattenGql = undefined
SPACE = ' '
COMMA = ','
NEW_LINE = '\n'

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
    return graphql.print graphql.parse query

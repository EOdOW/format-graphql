{CompositeDisposable} = require 'atom'
UtilsFlattenGql = require './format-graphql-utils'

module.exports = FlattenGql =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a
    # CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'format-graphql:flatten': => @format('unflatten')
    @subscriptions.add atom.commands.add 'atom-workspace', 'format-graphql:unflatten': => @format('flatten')

  deactivate: ->
    @subscriptions.dispose()

  format: (mode = 'flatten')->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    text = editor.getSelectedText() or editor.getText()
    newLine = text.match('\n')
    shouldFormat = mode == 'unflatten' and !newLine or mode == 'flatten' and newLine

    if shouldFormat
      editor.setText UtilsFlattenGql[mode](text)

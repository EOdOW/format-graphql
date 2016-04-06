{CompositeDisposable} = require 'atom'
UtilsFlattenGql = require './format-graphql-utils'

module.exports = FlattenGql =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a
    # CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'format-graphql:flatten': => @format('flatten')
    @subscriptions.add atom.commands.add 'atom-workspace', 'format-graphql:unflatten': => @format('unflatten')

  deactivate: ->
    @subscriptions.dispose()

  format: (mode = 'flatten')->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    selection = editor.getSelectedText()
    text = selection or editor.getText()
    selectionRange = editor.getSelectedBufferRange()
    newLine = text.match('\n')
    shouldFormat = mode == 'unflatten' and !newLine or mode == 'flatten' and newLine

    if shouldFormat
      if selection
        editor.setTextInBufferRange editor.getSelectedBufferRange(), UtilsFlattenGql[mode](text)
      else
        editor.setText UtilsFlattenGql[mode](text)

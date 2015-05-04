do (Backbone, Marionette) ->

  class Marionette.Region.Dialog extends Marionette.Region

    constructor: ->
      _.extend @, Backbone.Events

    onShow: (view) ->
      options = @getOptions _.result(view, "dialog")

      @$el.dialog options,
        close: (e, ui) => @closeDialog()

    getOptions: (options = {}) ->
      if window.isMobile
        options = @getMobileOptions options 
      else
        options = @getWidescreenOptions options
      options = @getDefaultOptions options

    getMobileOptions: (options = {}) ->
      options.width   = '100%'
      options.height  = window.screen.height
      options.show    = {effect: 'slide', direction: 'down'}
      options.hide    = {effect: 'slide', direction: 'down'}
      return options

    getWidescreenOptions: (options = {}) ->
      options.width   = 'auto'
      options.height  = 'auto'
      options.show    = 'fade'
      options.hide    = 'fade'
      return options

    getDefaultOptions: (options = {}) ->
      _.defaults options,
        title: "default title"
        modal: true
        resizable: false
        draggable: false

    closeDialog: ->
      @stopListening()
      @close()
      @$el.dialog("destroy")


@Pokedex.module "PokemonApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends Marionette.Layout
    template: "messages/list/templates/layout.jst"
    tagName: "span"
    className: "message-app-layout"
    regions:
      footerRegion:   "#chat-footer-region"
      messagesRegion: "#chat-messages-region"

  class List.Message extends Marionette.ItemView
    template: =>
      subtype = if @model.isSystem() then "system" else @model.get('subtype')
      "messages/list/templates/_#{subtype}_message.jst"

    initialize: ->
      @model.setOwner()
      sender = @model.get('sender')
      @listenTo(sender, "change:name", @render) if sender

  class List.Messages extends Marionette.CollectionView
    tagName: "ul"
    className: "chat-messages overthrow"
    itemView: List.Message

    collectionEvents: ->
      'add' : 'scroll'

    initialize: ->
      @scroll()

    scroll: (model) ->
      _.defer =>
        @$el.animate({scrollTop: @$el[0].scrollHeight}, 350, "swing")


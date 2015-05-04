@Pokedex.module "PokemonApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    list: ->
      room = App.request "room:entity"
      room.done (room) =>
        App.currentMember = room.get('current_member')
        App.currentRoom = room
        if !App.currentMember then App.redirect()
        @layout = @getLayoutView()
        @layout.on "show", =>
          App.execute "header:app:start", room
          messages = room.get('messages')
          @messagesRegion messages
          @footerRegion messages
          App.execute "members:app:start", room
          App.execute "welcome:app:start"
          App.execute "browser:events:start", room
        App.regionContent.show @layout

    footerRegion: (messages) ->
      footerView = App.request "new:message:view", messages
      @layout.footerRegion.show footerView
      _.defer ->
        App.Helpers.FileUploaderHelper.initialize
          image: "add-image"
          dragNdropArea: "message-area"
          uploaderElement: "uploader"
          uploadProgress: "upload-progress"

    messagesRegion: (messages) ->
      messagesView = @getMessagesView messages
      @layout.messagesRegion.show messagesView

    getLayoutView: ->
      new List.Layout

    getMessagesView: (messages) ->
      new List.Messages
        collection: messages


@Pokedex.module "PokemonApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    list: ->
      pokemon = App.request "pokemon:entities"
      pokemon.done (pokemon) =>
        @layout = @getLayoutView()
        @layout.on "show", =>
          App.execute "image:app:start"
          pokemonView = @getPokemonView pokemon
          pokemonView.on 'itemview:show:pokemon:information', (model) ->
            App.execute "pokemon:app:show", model
          @layout.pokemonRegion.show pokemonView
        App.regionContent.show @layout

    #footerRegion: (messages) ->
      #footerView = App.request "new:message:view", messages
      #@layout.footerRegion.show footerView
      #_.defer ->
        #App.Helpers.FileUploaderHelper.initialize
          #image: "add-image"
          #dragNdropArea: "message-area"
          #uploaderElement: "uploader"
          #uploadProgress: "upload-progress"

    getLayoutView: ->
      new List.Layout

    getPokemonView: (pokemon) ->
      new List.Pokemons
        collection: pokemon


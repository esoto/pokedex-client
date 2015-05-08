@Pokedex.module "PokemonApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    list: ->
      pokemon = App.request "pokemon:entities"
      pokemon.done (pokemon) =>
        @layout = @getLayoutView()
        @layout.on "show", =>
          App.execute "image:app:start"
          pokemonView = @getPokemonView pokemon
          pokemonView.on 'itemview:show:pokemon:information', (pokemon_item) ->
            App.execute "pokemon:app:show", pokemon_item
          @layout.pokemonRegion.show pokemonView
        App.regionContent.show @layout

    getLayoutView: ->
      new List.Layout

    getPokemonView: (pokemon) ->
      new List.Pokemons
        collection: pokemon


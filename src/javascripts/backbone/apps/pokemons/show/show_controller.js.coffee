@Pokedex.module "PokemonApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =

    show: (id, pokemon) ->
      unless pokemon then pokemon = App.request "pokemon:entity", id
      layout = @getLayoutView()
      layout.on "show", =>
        pokemonView = @getPokemonView pokemon
        App.execute "image:app:start"
        layout.pokemonRegion.show pokemonView

      App.regionContent.show layout

    getLayoutView: ->
      new Show.Layout

    getPokemonView: (pokemon) ->
      new Show.Pokemon
        model: pokemon


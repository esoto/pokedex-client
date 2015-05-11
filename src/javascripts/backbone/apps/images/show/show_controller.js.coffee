@Pokedex.module "ImageApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =

    show: ->
      layout = @getLayoutView()
      dummyImageView = @getDummyImage()

      App.regionImage.show layout

      layout.imagesRegion.show dummyImageView

    showPokemonImage: (pokemon_url) ->
      layout = @getLayoutView()
      pokemonImageView = @getPokemonImageView(pokemon_url)

      App.regionImage.show layout

      layout.imagesRegion.show pokemonImageView

    getLayoutView: ->
      new Show.Layout

    getDummyImage: ->
      new Show.DummyImage

    getPokemonImageView: (pokemon_url) ->
      new Show.PokemonImage
        avatar_url: pokemon_url


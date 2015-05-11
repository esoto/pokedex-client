@Pokedex.module "ImageApp", (ImageApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: ()->
      ImageApp.Show.Controller.show()

    showPokemonImage: (pokemon_url) ->
      ImageApp.Show.Controller.showPokemonImage(pokemon_url)

  App.commands.setHandler "image:app:start", ->
    API.show()

  App.commands.setHandler "image:app:show:pokemon", (pokemon_url) ->
    API.showPokemonImage(pokemon_url)


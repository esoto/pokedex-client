@Pokedex.module "PokemonApp", (PokemonApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class PokemonApp.Router extends Marionette.AppRouter
    appRoutes:
      "pokemons/" : "list"
      "pokemons/:id" : "show"
      "*any" : "list"

  API =
    list: ()->
      PokemonApp.List.Controller.list()

    redirect: ->
      App.redirect()

    show: (id, model) ->
      PokemonApp.Show.Controller.show(id, model)

  App.commands.setHandler "pokemon:app:show", (pokemon_view) ->
    API.show(0, pokemon_view.model)

  App.addInitializer ->
    new PokemonApp.Router
      controller: API

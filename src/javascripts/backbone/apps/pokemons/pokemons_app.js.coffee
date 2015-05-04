@Pokedex.module "PokemonApp", (PokemonApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class PokemonApp.Router extends Marionette.AppRouter
    appRoutes:
      "pokemons" : "list"
      "pokemons/:id" : "show"
      "*any" : "redirect"

  API =
    list: ->
      PokemonApp.List.Controller.list()

    redirect: ->
      App.redirect()

    show: (id) ->
      PokemonApp.Show.Controller.show id

  App.reqres.setHandler "new:message:view", (messagesCollection) ->
    API.new messagesCollection

  App.addInitializer ->
    new PokemonApp.Router
      controller: API

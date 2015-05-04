@Pokedex.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Pokemon extends Backbone.RelationalModel
    url: "#{App.apiRoute}/#!pokemons"

    #relations: [{
      #type: "HasMany"
      #key: "messages"
      #relatedModel: Pokedex.Entities.Message
      #collectionType: Pokedex.Entities.MessagesCollection
      #reverseRelation:
        #includeInJSON: "id"
    #}]

    isFireType: ->
      @get('pokemon_type') == 'fire'

  class Entities.PokemonsCollection extends Backbone.Collection
    model: Entities.Pokemon

  API =
    getPokemon: (pokemon_id) ->
      pokemon = new Entities.Pokemon()
      pokemon.url = "#{App.apiRoute}/pokemons/#{pokemon_id}"
      pokemon.fetch({async: false})
      pokemon

    getPokemons: ->
      pokemons = new Entities.PokemonsCollection()
      pokemons.url = "#{App.apiRoute}/pokemons"
      App.Helpers.NetworkHelper.asyncRequest pokemons

  App.reqres.setHandler "pokemon:entity", (pokemon_id) ->
    API.getPokemon pokemon_id

  App.reqres.setHandler "pokemon:entities", ->
    API.getPokemons()


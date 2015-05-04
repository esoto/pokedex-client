@Pokedex.module "PokemonApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends Marionette.Layout
    template: "pokemons/list/templates/layout.jst"
    tagName: "span"
    className: "pokemon-app-layout"
    regions:
      pokemonRegion: "#pokemon-list-region"

  class List.Pokemon extends Marionette.ItemView
    template: =>
      subtype = if @model.isFireType() then 'fire' else 'normal'
      "pokemons/list/templates/_#{subtype}_pokemon.jst"

    events: ->
      'click': 'displayPokemon'

    displayPokemon: ->
      @trigger "show:pokemon:information", @model

  class List.Pokemons extends Marionette.CollectionView
    tagName: "ul"
    className: "pokemon-list"
    itemView: List.Pokemon

    collectionEvents: ->
      'add' : 'scroll'

    initialize: ->
      @scroll()

    scroll: (model) ->
      _.defer =>
        @$el.animate({scrollTop: @$el[0].scrollHeight}, 350, "swing")


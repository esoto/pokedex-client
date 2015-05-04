@Pokedex.module "PokemonApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends Marionette.Layout
    template: "pokemons/show/templates/layout.jst"
    tagName: "div"
    className: "pokemon-show-layout"
    regions:
      pokemonRegion: "#pokemon-info-region"

  class Show.Pokemon extends Marionette.ItemView
    template: "pokemons/show/templates/_pokemon.jst"


@Pokedex.module "ImageApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends Marionette.Layout
    template: "images/show/templates/layout.jst"
    tagName: "div"
    className: "image-app-layout"
    regions:
      imagesRegion: "#pokemon-image-region"

  class Show.DummyImage extends Marionette.ItemView
    template: "images/show/templates/_dummy_pokemon.jst"


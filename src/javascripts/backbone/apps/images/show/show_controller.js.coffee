@Pokedex.module "ImageApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  Show.Controller =

    show: ->
      layout = @getLayoutView()
      dummyImageView = @getDummyImage()

      App.regionImage.show layout

      layout.imagesRegion.show dummyImageView

    getLayoutView: ->
      new Show.Layout

    getDummyImage: ->
      new Show.DummyImage


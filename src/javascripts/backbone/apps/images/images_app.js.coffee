@Pokedex.module "ImageApp", (ImageApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API =
    show: ()->
      ImageApp.Show.Controller.show()

  App.commands.setHandler "image:app:start", ->
    API.show()


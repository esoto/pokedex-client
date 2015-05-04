@Pokedex.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.NetworkHelper

    @asyncRequest: (object) ->
      defer = $.Deferred()
      object.fetch
        success: ->
          defer.resolve(object)
        error: ->
          App.redirect()
      defer.promise()


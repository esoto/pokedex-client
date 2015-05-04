@Asaper.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.FormHelper

    @stopFormEvents: (event) ->
      event.preventDefault()
      event.stopPropagation()

    @enterKeyWatcher: (event, method) ->
      if event.keyCode == 13
        method event
        @stopFormEvents(event)


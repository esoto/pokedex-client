@Pokedex = do (Backbone, Marionette) ->

  App = new Marionette.Application
    apiKey: window.pokedexApiKey

  _sync = Backbone.sync
  Backbone.sync = (method, model, options) ->
    url = (if typeof(model.url) == "function" then model.url() else model.url)
    model.url = url + "?API-KEY=#{App.apiKey}" if url.indexOf('API-KEY') == -1
    _sync.call( this, method, model, options )

  App.addRegions
    regionHeader:  "#header-region"
    regionContent:  "#content-region"
    regionDrawer:   "#drawers-region"
    regionWelcome:  "#welcome-region"
    regionDialog:   Marionette.Region.Dialog.extend el: "#dialog-region"

  App.apiRoute = window.pokedexDomain

  App.bind "initialize:after", ->
    console.log "Backbone was initialized!"
    Backbone.history.start()

  App

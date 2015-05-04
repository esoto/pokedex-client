@Pokedex = do (Backbone, Marionette) ->

  App = new Marionette.Application
    apiKey: window.pokedexApiKey

  _sync = Backbone.sync
  #Backbone.sync = (method, model, options) ->
    #url = (if typeof(model.url) == "function" then model.url() else model.url)
    #model.url = url + "?API-KEY=#{App.apiKey}" if url.indexOf('API-KEY') == -1
    #_sync.call( this, method, model, options )

  App.addRegions
    regionContent:  "#info-region"
    regionImage:   "#image-region"

  App.apiRoute = window.pokedexDomain

  App.redirect = ->
    window.location.replace("http://localhost:9001/#!pokemons")

  App.bind "initialize:before", ->
    console.log "Backbone was initialized!"
    if !Backbone.history.started
      Backbone.history.start({ pushstate: true })

  App


@Asaper.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.CookieHelper

    @setCookie = (cookieName, value, exdays) ->
      ###
        console.log "Setting Cookie #{cookieName} with
        value #{value} expiring in #{exdays} days"
      ###
      exdate = new Date()
      exdate.setDate exdate.getDate() + exdays
      cookieValue = escape(value) +
                    if (not (exdays?)) then "" else "; expires=" +
                    exdate.toUTCString()
      document.cookie = cookieName + "=" + cookieValue

    @getCookie = (cookieName) ->
      #console.log "Searching for " + cookieName
      cookieValue = document.cookie
      cookieStart = cookieValue.indexOf(" " + cookieName + "=")
      cookieStart = cookieValue.indexOf(cookieName + "=")  if cookieStart is -1
      if cookieStart is -1
        cookieValue = null
      else
        cookieStart = cookieValue.indexOf("=", cookieStart) + 1
        cookieEnd = cookieValue.indexOf(";", cookieStart)
        cookieEnd = cookieValue.length  if cookieEnd is -1
        cookieValue = unescape(cookieValue.substring(cookieStart, cookieEnd))
      cookieValue

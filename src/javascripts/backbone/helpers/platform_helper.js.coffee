@Asaper.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.PlatformHelper

    @isAndroidBrowser: ->
      userAgent = navigator.userAgent.toLowerCase()
      userAgent.indexOf("android") != -1 and
      userAgent.indexOf("mobile") != -1 and
      userAgent.indexOf("crmo") == -1

    @getMobileOS: ->
      ua = navigator.userAgent
      uaindex = undefined
      mobileOS = undefined
      mobileOSver = undefined
      # determine OS
      if ua.match(/iPad/i) or ua.match(/iPhone/i)
        mobileOS = "iOS"
        uaindex = ua.indexOf("OS ")
      else if ua.match(/Android/i)
        mobileOS = "Android"
        uaindex = ua.indexOf("Android ")
      else if ua.match(/MSIE/)
        mobileOS = "Windows Mobile"
        uaindex = ua.indexOf("MSIE ")
      else
        mobileOS = "unknown"
      # determine version
      if mobileOS is "iOS" and uaindex > -1
        mobileOSver = ua.substr(uaindex + 3, 3).replace("_", ".")
      else if mobileOS is "Android" and uaindex > -1
        mobileOSver = ua.substr(uaindex + 8, 3)
      else if mobileOS is "Windows Mobile" and uaindex > -1
        mobileOSver = ua.substr(uaindex + 5, 4)
      else
        mobileOSver = "unknown"
      [mobileOS, mobileOSver]

    @isMobile: ->
      @getMobileOS()[0] != "unknown"

    @isWindowsPhone: ->
      @getMobileOS()[0] == "Windows Mobile"

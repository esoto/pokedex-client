@Asaper.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.LayoutHelper

    @orientationChangeCleanup: (mobileOS) ->
      console.log "orientation fired"
      activeElement = document.activeElement.tagName
      @keyboardCloser()
      if activeElement == "TEXTAREA" or activeElement == "INPUT"
        setTimeout =>
          @layoutRepair mobileOS
        , 500
      else
        @layoutRepair mobileOS

    @keyboardCloser: ->
      $(document.activeElement).blur()
      $('input, textarea').blur()
      $('body').focus()

    @layoutRepair: (mobileOS) ->
      if mobileOS == "iOS"
        window.scrollTo(0,0)
      $('body').css("width", window.innerWidth)
      $('body').css("height", window.innerHeight)
      $('.ui-widget-overlay').css("width", window.innerWidth)
      $(".ui-dialog-content").dialog "option", "position", "center"

    @showHide: (el, durIn, duration, durOut) ->
      $(el).fadeIn(durIn).delay(duration).fadeOut(durOut)

    @hideShow: (el, durOut, duration, durIn) ->
      $(el).fadeOut(durOut).delay(duration).fadeIn(durIn)


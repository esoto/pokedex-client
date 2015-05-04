@Asaper.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.FileUploaderHelper

    @initialize: (opts) ->
      image = document.getElementById(opts.image)
      holder = document.getElementById(opts.dragNdropArea)
      fileupload = document.getElementById(opts.uploaderElement)
      Helpers.FileUploaderHelper.progress = document.getElementById(opts.uploadProgress)

      unless @validOS
        image.remove()
        return false

      if @definer.dnd
        holder.ondragover = ->
          @className = "hover"
          false

        holder.ondragend = ->
          @className = ""
          false

        holder.ondrop = (e) =>
          @className = ""
          e.preventDefault()
          @readfiles e.dataTransfer.files

      fileupload.onchange = =>
        @readfiles fileupload.files

    @definer:
      dnd: "draggable" of document.createElement("span")
      formdata: !!window.FormData
      progress: "upload" in new XMLHttpRequest

    @acceptedTypes:
      "image/png": true
      "image/jpeg": true
      "image/gif": true

    @readfiles: (files) ->
      formData = (if @definer.formdata then new FormData() else null)
      progressReporter = $(FileUploaderHelper.progress)

      if @acceptedTypes[files[0].type] is true and @definer.formdata
        formData.append "content", files[0]
        formData.append "member_token", window.Asaper.currentMemberToken
        xhr = new XMLHttpRequest()
        xhr.onreadystatechange = ->
          if xhr.readyState == 1
            progressReporter.css("width", "135px")
            progressReporter.css("left", ($(window).width()-135)/2)
            FileUploaderHelper.progress.innerHTML = "Uploading"
            progressReporter.fadeIn("slow")
          else if xhr.readyState == 4
            if xhr.status == 200
              message = "Upload was Successful"
              progressReporter.css("width", "250px")
              progressReporter.css("left", ($(window).width()-250)/2)
            else
              message = "There was a problem try again."
              progressReporter.css("width", "300px")
              progressReporter.css("left", ($(window).width()-300)/2)
            FileUploaderHelper.progress.innerHTML = message
            setTimeout( ->
              progressReporter.fadeOut("slow")
            , 2000)
        route = window.Asaper.apiRoute + "/rooms/" + window.Asaper.currentRoomToken + "/messages?API-KEY=" + window.asaperApiKey
        xhr.open "POST", route, true
        xhr.send formData
      else
        alert "Sorry only accept images... For now"

    @validOS: ->
      systemInfo = App.Helpers.PlatformHelper.getMobileOS()
      not (systemInfo[1] is 2.3 and systemInfo[0] is "Android")


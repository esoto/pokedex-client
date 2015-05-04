@Asaper.module "Helpers", (Helpers, App, Backbone, Marionette, $, _) ->

  class Helpers.FormatHelper

    @formatPhoneNumber: (phone) ->
      phone.replace /(\d{3})(\d{3})(\d{4})/, "($1) $2-$3"

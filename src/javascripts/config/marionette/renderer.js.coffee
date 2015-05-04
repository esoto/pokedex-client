Backbone.Marionette.Renderer.render = (template, data) ->
  template_path = if typeof(template) == 'function' then template() else template
  path = JST["src/javascripts/backbone/apps/" + template_path]
  unless path
    throw "Template #{template_path} not found!"
  path(data)

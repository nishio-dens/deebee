class Dispatcher
  constructor: ->
    pageId = $('body').data('controller')

    views = new SchemaViews()

$ ->
  new Dispatcher()

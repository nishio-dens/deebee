class Dispatcher
  constructor: ->
    pageId = $('body').data('controller')

    views = new SchemaViews()
    views.setupIndexWindow()

$ ->
  new Dispatcher()

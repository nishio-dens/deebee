class Dispatcher
  constructor: ->
    pageId = $('body').data('controller')
    switch pageId
      when 'schemata'
        views = new SchemaViews()
        Dispatcher.setupSchemataBackbone()

  @setupSchemataBackbone: ->
    window.application = new Backbone.Marionette.Application()
    controller = new ProjectsController()
    window.routers = new DeebeeRouters(controller: controller)
    Backbone.history.start()
    window.application.start()

$ ->
  new Dispatcher()

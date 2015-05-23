class Dispatcher
  constructor: ->
    pageId = $('body').data('controller')

    Trans1.Application = new Backbone.Marionette.Application()

    switch pageId
      when 'translations'
        instance = new Trans1.Controllers.TranslationsController()
        Trans1.addInstance('translations', instance)
        routers = new Trans1.Routers.TranslationRouters(controller: instance)

    Backbone.history.start()
    Trans1.Application.start()

$ ->
  new Dispatcher()

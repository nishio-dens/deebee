class Dispatcher
  constructor: ->
    pageId = $('body').data('controller')

    switch pageId
      when 'dummy'

$ ->
  new Dispatcher()

#= require views/stickit_view

class Trans1.Views.TranslationItemView extends Marionette.ItemView
  @include Trans1.Views.StickitView

  tagName: 'tr'
  className: 'item'
  template: HandlebarsTemplates['translation_item']

  events:
    'click': 'onClickItem'

  bindings:
    '.item-selected': 'selected',

  initialize: ->
    @model.startTracking()

    @listenTo(@model, 'change', @render)
    @listenTo(@model, 'change', @updateStatus)
    @listenTo(@model, 'change', @renderUnsaved)
    @listenTo(@model, 'change:selected', @renderStatus)

  onClickItem: (e) ->
    @trigger('on:ClickItem', e)

  renderUnsaved: ->
    unsaved = @model.unsavedAttributes()
    if unsaved.variableName || unsaved.ja || unsaved.en
      @$el.addClass('not-saved')
    else
      @$el.removeClass('not-saved')

  renderStatus: ->
    if @model.get('selected')
      @$el.addClass('selected')
    else
      @$el.removeClass('selected')

  updateStatus: ->
    @model.updateStatus()

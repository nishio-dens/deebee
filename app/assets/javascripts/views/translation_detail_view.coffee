class Trans1.Views.TranslationDetailView extends Marionette.LayoutView
  className: 'tab-tab-custom'
  template: HandlebarsTemplates['translation_detail']

  ui:
    id: '#translation-detail-id'
    createdAt: '#translation-detail-created-at'
    updatedAt: '#translation-detail-updated-at'
    createdBy: '#translation-detail-created-by'
    updatedBy: '#translation-detail-updated-by'

  initialize: ->

  changeModel: (model) ->
    @stopListening(@model, 'change:updatedAt')
    @model = model
    @listenTo(@model, 'change:updatedAt', @updateStatus)
    @updateStatus()

  updateStatus: ->
    @ui.id.html(@model.get('id'))
    @ui.createdAt.html(@model.get('createdAt'))
    @ui.updatedAt.html(@model.get('updatedAt'))
    @ui.createdBy.html(@model.get('creatorName'))
    @ui.updatedBy.html(@model.get('updaterName'))

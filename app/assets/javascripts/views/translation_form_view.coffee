#= require views/stickit_view

class Trans1.Views.TranslationFormView extends Marionette.ItemView
  @include Trans1.Views.StickitView

  className: 'box'
  template: HandlebarsTemplates['translation_form']

  bindings:
    "#transformVariableName": 'variableName',
    "#transformJa": 'ja',
    "#transformEn": 'en',

  events:
    'submit form': 'onFormSubmit'

  initialize: ->
    @listenTo(@model, 'change', @setupNewOrExistForm)

  rebindEvent: ->
    @listenTo(@model, 'change', @setupNewOrExistForm)

  changeModel: (newModel) ->
    @stopListening(@model, 'change')
    @unstickit(@model)
    @model = newModel
    @rebindEvent()
    @setupNewOrExistForm()

  setupNewOrExistForm: ->
    if @model.isNew()
      $('#transformSubmit').text('新規作成')
    else
      $('#transformSubmit').text('更新')

  onFormSubmit: (e) ->
    e.preventDefault()

    @model.save({},
      success: (model, response) ->
        if response.status == 'success'
          model.set('id', response.translation.id)
          model.set('createdAt', response.translation.createdAt)
          model.set('updatedAt', response.translation.updatedAt)
          model.set('creatorName', response.translation.creatorName)
          model.set('updaterName', response.translation.updaterName)
        else
          alert('Validation違反(仮実装)\n\n' + response.messages)
      error: ->
        alert('不明なエラー')
    )

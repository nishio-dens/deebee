class Trans1.Models.TranslationItem extends Backbone.Model
  defaults:
    selected: false,
    variableName: ''
    ja: ''
    en: ''
    translated: false
    dummy: false
    createdAt: ''
    updatedAt: ''
    creatorName: ''
    updaterName: ''

  initialize: ->
    @updateStatus()

  getId: ->
    @get('id')

  isSelected: ->
    @get('selected')

  setSelected: (boolean) ->
    @set('selected', boolean)

  unselect: ->
    @setSelected(false)

  isJaTranslated: ->
    @get('ja').length > 0

  isEnTranslated: ->
    @get('en').length > 0

  isDummy: ->
    @get('dummy')

  updateStatus: ->
    @set('isNew', @isNew())
    @set('translated', @isJaTranslated() && @isEnTranslated())

  isMatchKeyword: (keyword) ->
    (@getId() || '_dummyNewRecord').toString() == keyword ||
      (@get('variableName') || '').contains(keyword) ||
      (@get('ja') || '').contains(keyword) ||
      (@get('en') || '').contains(keyword)

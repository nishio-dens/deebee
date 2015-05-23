class Trans1.Collections.TranslationItems extends Backbone.Collection
  model: Trans1.Models.TranslationItem

  initialize: (options) ->
    @options = options

  url: ->
    '/api/projects/' + @options.id + '/translations'

  resetSelected: ->
    @chain()
      .filter(@_isSelected)
      .each((e) -> e.unselect())

  getSelected: ->
    @filter(@_isSelected)

  getJaTranslated: ->
    @filter(@_isJaTranslated)

  getEnTranslated: ->
    @filter(@_isEnTranslated)

  getTranslated: ->
    @filter(@_isTranslated)

  getUntranslated: ->
    @reject(@_isTranslated)

  _isSelected: (item) ->
    item.isSelected()

  _isJaTranslated: (item) ->
    item.isJaTranslated()

  _isEnTranslated: (item) ->
    item.isEnTranslated()

  _isTranslated: (item) ->
    item.isJaTranslated() && item.isEnTranslated()

class Trans1.Views.TranslationItemViews extends Marionette.CompositeView
  tagName: 'table'
  className: 'table table-scriped table-hover selectable-table'
  childView: Trans1.Views.TranslationItemView
  childViewContainer: 'tbody'
  template: HandlebarsTemplates['translation_items']

  @SearchMode:
    NONE: 0
    ALL: 1
    TRANSLATED: 2
    UNTRANSLATED: 3

  initialize: (options) ->
    @listenTo(@collection, 'request', @startAsync)
    @listenTo(@collection, 'sync error', @finishAsync)
    @listenTo(@collection, 'destroy', @finishAsync)

    @currentSearchMode = Trans1.Views.TranslationItemViews.SearchMode.NONE
    @searchQuery = ''

  startAsync: ->
    $('#translation-table-loading').removeClass('hide')

  finishAsync: ->
    $('#translation-table-loading').addClass('hide')

  rebindListenTo: (model) ->
    alert(model.get('id'))

  onChildviewOnClickItem: (itemView, e) ->
    item = itemView.model

    if item
      if $(e.target).is('input')
        selected = $(e.target).val()
        item.setSelected(selected)
      else
        selected = !item.isSelected()
        item.setSelected(selected)

        @collection
          .chain()
          .filter((i) -> i.isSelected())
          .reject((i) -> i.getId() == item.getId())
          .each((i) -> i.unselect())
 
      if selected
        @selectCurrentTranslationForm(item)
      else
        @selectCurrentTranslationForm(new Trans1.Models.TranslationItem(dummy: true))

  selectCurrentTranslationForm: (item) ->
    Trans1
      .getInstance('translations')
      .setCurrentTranslationForm(item)

    Trans1.getInstance('translations').getCurrentTranslationForm().render()

  changeSearchMode: (mode) ->
    @currentSearchMode = mode
    @render()

  setSearchQuery: (query) ->
    @searchQuery = query
    @render()

  focusNewItem: () ->
    @collection.resetSelected()
    item = @collection.first()
    @selectCurrentTranslationForm(item)

    # FIXME: 別のViewに依存しているため、改善の必要あり
    $('.trans-left-main').animate({ scrollTop: 0 }, 100)

  showCollection: () ->
    self = @
    itemView = @getChildView()

    switch @currentSearchMode
      when Trans1.Views.TranslationItemViews.SearchMode.NONE
        filteredCollection = []
      when Trans1.Views.TranslationItemViews.SearchMode.ALL
        filteredCollection = @collection.toArray()
      when Trans1.Views.TranslationItemViews.SearchMode.TRANSLATED
        filteredCollection = @collection.getTranslated()
      when Trans1.Views.TranslationItemViews.SearchMode.UNTRANSLATED
        filteredCollection = @collection.getUntranslated()

    if @searchQuery.length
      q = @searchQuery
      filteredCollection = _.filter(filteredCollection, (item) -> item.isMatchKeyword(q))

    _.each(filteredCollection, (item, index) ->
      self.addChild(item, itemView, index)
    )

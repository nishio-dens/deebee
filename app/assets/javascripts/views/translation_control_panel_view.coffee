class Trans1.Views.TranslationControlPanelView extends Marionette.LayoutView
  className: 'box'
  template: HandlebarsTemplates['translation_control_panel']

  events:
    'click #controlPanelAddNewVariable': 'addNewItem'
    'click #controlPanelRemoveVariable': 'removeItem'
    'click #controlPanelHorizontalExpand': 'expandHorizontal'
    'keyup #searchQuery': 'searchQuery'
    'click #searchReset': 'searchReset'

  ui:
    allCount: '.allCount'
    finishedCount: '.finishedCount'
    unfinishedCount: '.unfinishedCount'
    jaFinishedCount: '.jaFinishedCount'
    enFinishedCount: '.enFinishedCount'
    jaTranslatedPercentage: '#jaTranslatedPercentage'
    enTranslatedPercentage: '#enTranslatedPercentage'
    searchQuery: '#searchQuery'
    searchResetButton: '#searchReset'
    searchAllButton: '#translationSearchAll'
    searchTranslatedButton: '#translationSearchTranslated'
    searchUntranslatedButton: '#translationSearchUntranslated'
    projectNameLabel: '#projectNameLabel'
    importLinkButton: '#controlPanelImportLink'
    exportJaYaml: '#controlPanelExportJaYaml'
    exportEnYaml: '#controlPanelExportEnYaml'
    exportCsv: '#controlPanelExportCsv'

  initialize: ->
    @listenTo(@collection, 'sync add remove', @updateCount)

    @verticalExpanded = false
    @horizontalExpanded = false

  setItemViews: (itemViews) ->
    @itemViews = itemViews

  addNewItem: ->
    item = new Trans1.Models.TranslationItem()
    @collection.add(item, { at: 0 })
    location.hash = "searchAll"
    @searchReset()
    @itemViews.focusNewItem()

  removeItem: ->
    selectedItems = @collection.getSelected()
    _.each(selectedItems, (item) ->
      item.destroy()
    )

  expandHorizontal: ->
    if @horizontalExpanded
      $('#trans-left').animate({ width: '60%' })
    else
      $('#trans-left').animate({ width: '90%' })

    @horizontalExpanded = !@horizontalExpanded

  updateCount: ->
    totalCount = @collection.length
    finishedJaCount = @collection.getJaTranslated().length
    finishedEnCount = @collection.getEnTranslated().length

    @ui.allCount.html(totalCount)
    @ui.finishedCount.html(@collection.getTranslated().length)
    @ui.unfinishedCount.html(@collection.getUntranslated().length)
    @ui.jaFinishedCount.html(finishedJaCount)
    @ui.enFinishedCount.html(finishedEnCount)

    if totalCount > 0
      jaPercent = Math.round((finishedJaCount / totalCount) * 100)
      @ui.jaTranslatedPercentage.css('width': "#{jaPercent}%")

      enPercent = Math.round((finishedEnCount / totalCount) * 100)
      @ui.enTranslatedPercentage.css('width': "#{enPercent}%")

  setProjectInfoAndLink: (id, title) ->
    @ui.projectNameLabel.html(title)
    @ui.importLinkButton.attr('href', '/projects/' + id + '/imports')
    @ui.exportJaYaml.attr('href', '/projects/' + id + '/exports?type=yml&language=ja')
    @ui.exportEnYaml.attr('href', '/projects/' + id + '/exports?type=yml&language=en')
    @ui.exportCsv.attr('href', '/projects/' + id + '/exports?type=csv')

  searchQuery: ->
    if @itemViews
      @itemViews.setSearchQuery(@ui.searchQuery.val())

  searchReset: ->
    @ui.searchQuery.val('')
    @itemViews.setSearchQuery(@ui.searchQuery.val())

  setSearchButtonToggle: (searchMode) ->
    @ui.searchAllButton.removeClass("active")
    @ui.searchTranslatedButton.removeClass("active")
    @ui.searchUntranslatedButton.removeClass("active")

    switch searchMode
      when 'all'
        @ui.searchAllButton.addClass("active")
      when 'translated'
        @ui.searchTranslatedButton.addClass("active")
      when 'untranslated'
        @ui.searchUntranslatedButton.addClass("active")

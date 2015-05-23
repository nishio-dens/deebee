class Trans1.Controllers.TranslationsController extends Marionette.Object
  initialize: () ->
    Trans1.Application.addRegions(
      listing: '#translation-listing',
      translationForm: '#translation-form'
      translationControlPanel: '#translation-control-panel'
      translationDetail: '#translation-detail'
    )

    @items = new Trans1.Collections.TranslationItems(id: gon.projectId)
    @itemViews = new Trans1.Views.TranslationItemViews(collection: @items)
    Trans1.Application.listing.show(@itemViews)

    currentTransItem = new Trans1.Models.TranslationItem(dummy: true)
    @setCurrentTranslationForm(currentTransItem)
    Trans1.Application.translationForm.show(@getCurrentTranslationForm())

    @controlPanel = new Trans1.Views.TranslationControlPanelView(collection: @items)
    @controlPanel.setItemViews(@itemViews)
    Trans1.Application.translationControlPanel.show(@controlPanel)
    @controlPanel.setProjectInfoAndLink(gon.projectId, gon.projectName)

    @detailPanel = new Trans1.Views.TranslationDetailView(model: currentTransItem)
    Trans1.Application.translationDetail.show(@detailPanel)

    @items.fetch(reset: true)

  index: () ->
    @itemViews.changeSearchMode(Trans1.Views.TranslationItemViews.SearchMode.ALL)
    @controlPanel.setSearchButtonToggle('all')

  searchAll: () ->
    @itemViews.changeSearchMode(Trans1.Views.TranslationItemViews.SearchMode.ALL)
    @controlPanel.setSearchButtonToggle('all')

  searchTranslated: () ->
    @itemViews.changeSearchMode(Trans1.Views.TranslationItemViews.SearchMode.TRANSLATED)
    @controlPanel.setSearchButtonToggle('translated')

  searchUntranslated: () ->
    @itemViews.changeSearchMode(Trans1.Views.TranslationItemViews.SearchMode.UNTRANSLATED)
    @controlPanel.setSearchButtonToggle('untranslated')

  setCurrentTranslationForm: (model) ->
    if @detailPanel
      @detailPanel.changeModel(model)

    if @currentTranslationForm
      @currentTranslationForm.changeModel(model)
    else
      @currentTranslationForm = new Trans1.Views.TranslationFormView(model: model)

  getCurrentTranslationForm: () ->
    @currentTranslationForm

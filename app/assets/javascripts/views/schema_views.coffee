class @SchemaViews
  pstyle:
    'border: 1px solid #dfdfdf'

  # Layouts
  applicationLayout:
    name: 'layout',
    padding: 4,
    panels: [
      { type: 'left', size: 200, resizable: true, style: @pstyle, content: 'left' },
      { type: 'main', style: @pstyle, content: 'main' },
    ]

  sidebarLayout:
    name: 'sidebarLayout'
    panels: [
      { type: 'main', size: '70%', resizable: true, style: @pstyle, content: 'main' },
      { type: 'bottom', size: '30%', resizable: true, style: @pstyle, content: 'bottom' }
    ]

  sidebarTableListing:
    name: 'sidebarTableListing',
    topHTML: $('#sidebarTop').html(),
    nodes: [
      { id: 'tables', text: 'Tables', group: true, expanded: true, nodes: []}
    ],
    onClick: (event) ->
      alert(event.target)

  sidebarDivisionListing:
    name: 'sidebarDivisionListing',
    nodes: [
      { id: 'divisions', text: 'Divisions', group: true, expanded: true, nodes: []}
    ],
    onClick: (event) ->
      alert(event.target)

  mainContentLayout:
    name: 'mainContentLayout',
    panels: [
      { type: 'top', size: 100, style: @pstyle, content: 'top' },
      { type: 'main', style: @pstyle, content: 'main' }
    ]

  schemaGrid:
    name: 'schemaGrid',
    autoLoad: true,
    limit: 200,
    url: '/',
    method: 'GET',
    show: {
      toolbar: true,
      toolbarAdd: true
    },
    columns: [
      { field: 'id', caption: 'ID', size: '50px', sortable: true }
      { field: 'asset_title', caption: 'アセット名', size: '200px', sortable: true }
      { field: 'status', caption: 'ステータス', size: '100px', sortable: true }
      { field: 'series_title', caption: 'シリーズ名', size: '200px', sortable: true }
      { field: 'season_title', caption: 'シーズン名', size: '200px', sortable: true }
      { field: 'program_type', caption: 'プログラム', size: '100px', sortable: true }
      { field: 'text_language', caption: 'テキスト', size: '70px', sortable: true }
      { field: 'assignee', caption: 'QC担当者', size: '150px', sortable: true }
      { field: 'transcoding_progress', caption: 'DI進捗', size: '100px', sortable: true }
      { field: 'created_at', caption: '作成日', size: '200px', sortable: true }
      { field: 'updated_at', caption: '更新日', size: '200px', sortable: true }
    ]

  # Functions
  constructor: ->
    @setupIndexWindow()
    @fetchSidebarData()

  setupIndexWindow: ->
    $('#main-window').w2layout(@applicationLayout)

    # on memory component
    $().w2layout(@mainContentLayout)
    $().w2grid(@assetGrid)

    @setupSidebar()

    w2ui.layout.content('main', w2ui.mainContentLayout)
    w2ui.layout.content('left', w2ui.sidebarLayout)

  setupSidebar: ->
    $().w2layout(@sidebarLayout)
    w2ui.sidebarLayout.content('main', $().w2sidebar(@sidebarTableListing))
    w2ui.sidebarLayout.content('bottom', $().w2sidebar(@sidebarDivisionListing))

  # Load Logic
  fetchSidebarData: ->
    w2ui.sidebarTableListing.insert('tables', null, [
      { id: 'grid1', text: 'certMasteries', img: 'icon-page', selected: true },
      { id: 'grid2', text: 'agtAgents', img: 'icon-page' },
      { id: 'abcd', text: 'invMarketGroups', img: 'icon-page' },
    ])
    w2ui.sidebarDivisionListing.insert('divisions', null, [
      { id: 'grid1', text: 'Gender', img: 'icon-page', selected: true },
      { id: 'grid2', text: 'Locales', img: 'icon-page' },
      { id: 'abcd', text: 'Something', img: 'icon-page' },
    ])


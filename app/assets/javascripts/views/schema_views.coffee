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
      { type: 'top', size: 60, style: @pstyle, content: 'top' },
      { type: 'main', style: @pstyle, content: 'main' }
    ]

  schemaGrid:
    name: 'schemaGrid',
    autoLoad: true,
    # url: '/',
    # method: 'GET',
    columns: [
      { field: 'column', caption: 'Column', size: '150px', sortable: true }
      { field: 'type', caption: 'Type', size: '100px', sortable: true }
      { field: 'length', caption: 'Length', size: '60px', sortable: true }
      { field: 'signed', caption: 'Signed', size: '60px', sortable: true }
      { field: 'binary', caption: 'Binary', size: '60px', sortable: true }
      { field: 'notNull', caption: 'NotNull', size: '60px', sortable: true }
      { field: 'default', caption: 'Default', size: '100px', sortable: true }
      { field: 'key', caption: 'Key', size: '50px', sortable: true }
      { field: 'example', caption: 'Example', size: '130px', sortable: true }
      { field: 'related', caption: 'Related', size: '130px', sortable: true }
      { field: 'comment', caption: 'comment', size: '200px', sortable: true }
      { field: 'note', caption: 'note', size: '200px', sortable: true }
      { field: 'version', caption: 'Version', size: '60px', sortable: true }
      { field: 'createdAt', caption: 'CreatedAt', size: '200px', sortable: true }
      { field: 'updatedAt', caption: 'UpdatedAt', size: '200px', sortable: true }
      { field: 'createdBy', caption: 'CreatedBy', size: '200px', sortable: true }
      { field: 'updatedBy', caption: 'updatedBy', size: '200px', sortable: true }
    ]

  # Functions
  constructor: ->
    @setupIndexWindow()
    @fetchSidebarData()

  setupIndexWindow: ->
    $('#main-window').w2layout(@applicationLayout)

    # on memory component
    $().w2layout(@mainContentLayout)
    $().w2grid(@schemaGrid)

    @setupSidebar()
    @setupMainWindow()

    w2ui.layout.content('main', w2ui.mainContentLayout)
    w2ui.layout.content('left', w2ui.sidebarLayout)

  setupSidebar: ->
    $().w2layout(@sidebarLayout)
    w2ui.sidebarLayout.content('main', $().w2sidebar(@sidebarTableListing))
    w2ui.sidebarLayout.content('bottom', $().w2sidebar(@sidebarDivisionListing))

  setupMainWindow: ->
    w2ui.mainContentLayout.content('top', $('#mainToolbar').html())
    w2ui.mainContentLayout.content('main', w2ui.schemaGrid)

  # Load Logic
  fetchSidebarData: ->
    w2ui.sidebarTableListing.insert('tables', null, [
      { id: 'grid1', text: 'certMasteries', img: 'icon-page' },
      { id: 'grid2', text: 'agtAgents', img: 'icon-page' },
      { id: 'abcd', text: 'invMarketGroups', img: 'icon-page' },
    ])
    w2ui.sidebarDivisionListing.insert('divisions', null, [
      { id: 'grid1', text: 'Gender', img: 'icon-page' },
      { id: 'grid2', text: 'Locales', img: 'icon-page' },
      { id: 'abcd', text: 'Something', img: 'icon-page' },
    ])


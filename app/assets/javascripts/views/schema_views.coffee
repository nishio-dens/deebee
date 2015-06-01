#= require views/schema_column_edit_view

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
      { type: 'top', size: '150', style: @pstyle, content: 'top' },
      { type: 'main', resizable: true, style: @pstyle, content: 'main' },
      { type: 'bottom', size: '30%', resizable: true, style: @pstyle, content: 'bottom' }
    ]

  sidebarTableListing:
    name: 'sidebarTableListing',
    nodes: [
      { id: 'tables', text: 'Tables', group: true, expanded: true, nodes: [], count: 30}
    ],
    onClick: (event) ->
      if w2ui.mainContentLayout.content('main').name != 'schemaGrid'
        w2ui.mainContentLayout.content('main', w2ui.schemaGrid)

        divisionSelected = w2ui.sidebarDivisionListing.selected
        if divisionSelected
          w2ui.sidebarDivisionListing.unselect(divisionSelected)

      projectId = gon.project_id
      tableId = event.target
      versionId = $('#versions').val()
      url = "/api/projects/#{projectId}/tables/#{tableId}?version=#{versionId}"

      w2ui.schemaGrid.load(url)

  sidebarDivisionListing:
    name: 'sidebarDivisionListing',
    nodes: [
      { id: 'divisions', text: 'Divisions', group: true, expanded: true, nodes: []}
    ],
    onClick: (event) ->
      if w2ui.mainContentLayout.content('main').name != 'divisionGrid'
        w2ui.mainContentLayout.content('main', w2ui.divisionGrid)

        tableSelected = w2ui.sidebarTableListing.selected
        if tableSelected
          w2ui.sidebarTableListing.unselect(tableSelected)

      projectId = gon.project_id
      divisionId = event.target

      versionId = $('#versions').val()
      url = "/api/projects/#{projectId}/divisions/#{divisionId}?version=#{versionId}"

      w2ui.schemaGrid.load(url)


  mainContentLayout:
    name: 'mainContentLayout',
    panels: [
      { type: 'top', size: 60, style: @pstyle, content: 'top' },
      { type: 'main', style: @pstyle, content: 'main' }
    ]

  schemaGrid:
    name: 'schemaGrid',
    autoLoad: true,
    method: 'GET',
    reorderColumns: true,
    columns: [
      { field: 'column', caption: 'Column', size: '150px', sortable: false }
      { field: 'column_type', caption: 'Type', size: '80px', sortable: false }
      { field: 'not_null', caption: 'Required', size: '70px', sortable: false, attr: 'align=center' }
      { field: 'length', caption: 'Length', size: '70px', sortable: false, attr: 'align=center' }
      { field: 'unsigned', caption: 'Unsigned', size: '70px', sortable: false, attr: 'align=center' }
      { field: 'default', caption: 'Default', size: '100px', sortable: false }
      { field: 'key', caption: 'Key', size: '50px', sortable: false, attr: 'align=center' }
      { field: 'relation', caption: 'Relation', size: '150px', sortable: false }
      { field: 'application_relation', caption: 'App Level Relation', size: '150px', sortable: false }
      { field: 'comment', caption: 'comment', size: '200px', sortable: false }
      { field: 'example', caption: 'Example', size: '130px', sortable: false }
      { field: 'character_set_name', caption: 'Charset', size: '100px', sortable: false }
      { field: 'collation_name', caption: 'Collation', size: '100px', sortable: false }
      { field: 'note', caption: 'Note', size: '200px', sortable: false }
      { field: 'created_at', caption: 'CreatedAt', size: '200px', sortable: false }
      { field: 'updated_at', caption: 'UpdatedAt', size: '200px', sortable: false }
      { field: 'created_by', caption: 'CreatedBy', size: '200px', sortable: false }
      { field: 'updated_by', caption: 'updatedBy', size: '200px', sortable: false }
    ]

  divisionGrid:
    name: 'divisionGrid',
    autoLoad: true,
    method: 'GET',
    reorderColumns: true,
    columns: [
      { field: 'code', caption: 'Code', size: '150px', sortable: false }
      { field: 'type_name', caption: 'Type', size: '150px', sortable: false }
      { field: 'name', caption: 'Name', size: '150px', sortable: false }
      { field: 'note', caption: 'Note', size: '200px', sortable: false }
      { field: 'created_at', caption: 'CreatedAt', size: '200px', sortable: false }
      { field: 'updated_at', caption: 'UpdatedAt', size: '200px', sortable: false }
      { field: 'created_by', caption: 'CreatedBy', size: '200px', sortable: false }
      { field: 'updated_by', caption: 'updatedBy', size: '200px', sortable: false }
    ]

  # Functions
  constructor: ->
    @setupIndexWindow()
    @fetchSidebarData()
    @setupHook()

  setupIndexWindow: ->
    $('#main-window').w2layout(@applicationLayout)

    # on memory component
    $().w2layout(@mainContentLayout)
    $().w2grid(@schemaGrid)
    $().w2grid(@divisionGrid)

    @setupSidebar()
    @setupMainWindow()

    w2ui.layout.content('main', w2ui.mainContentLayout)
    w2ui.layout.content('left', w2ui.sidebarLayout)

  setupSidebar: ->
    $().w2layout(@sidebarLayout)

    w2ui.sidebarLayout.content('top', $('#sidebarTop').render())
    w2ui.sidebarLayout.content('main', $().w2sidebar(@sidebarTableListing))
    w2ui.sidebarLayout.content('bottom', $().w2sidebar(@sidebarDivisionListing))

  setupMainWindow: ->
    w2ui.mainContentLayout.content('top', $('#mainToolbar').render())
    w2ui.mainContentLayout.content('main', w2ui.schemaGrid)

  # Load Logic
  fetchSidebarData: ->
    @loadTables(gon.project_id, gon.version_id)
    @loadDivisions(gon.project_id, gon.version_id)

  removeSidebarTableData: ->
    ids = _.map(w2ui.sidebarTableListing.nodes[0].nodes, (v) -> "#{v.id}")
    _.each(ids, (v) -> w2ui.sidebarTableListing.remove(v))

  removeSidebarDivisionData: ->
    ids = _.map(w2ui.sidebarDivisionListing.nodes[0].nodes, (v) -> "#{v.id}")
    _.each(ids, (v) -> w2ui.sidebarDivisionListing.remove(v))

  loadTables: (projectId, versionId) ->
    url = "/api/projects/#{projectId}/tables?version=#{versionId}"

    @removeSidebarTableData()

    $.get(url, (data) =>
      if data.length
        w2ui.sidebarTableListing.insert('tables', null, data)
    )

  loadDivisions: (projectId, versionId) ->
    url = "/api/projects/#{projectId}/divisions?version=#{versionId}"

    @removeSidebarDivisionData()

    $.get(url, (data) =>
      if data.length
        w2ui.sidebarDivisionListing.insert('divisions', null, data)
    )

  # Hooks
  setupHook: ->
    @setupProjectHook()
    @setupVersionHook()
    @setupRelationHook()
    @setupSchemaGridEditForm()

  setupProjectHook: ->
    $(document.body).delegate('#projects', 'change', (v) ->
      projectId = $(@).val()
      window.location.href = "/projects/#{projectId}/schemata"
    )

  setupVersionHook: ->
    projectId = gon.project_id
    $(document.body).delegate('#versions', 'change', (v) =>
      versionId = $(v.currentTarget).val()
      @loadTables(projectId, versionId)
    )

  setupRelationHook: ->
    $(document.body).delegate('.relationLink', 'click', (v) ->
      id = $(@).data('relation-id')
      $('[name=sidebarTableListing]').find('#node_' + id).click()
    )

  setupSchemaGridEditForm: ->
    schemaColumnEditForm = new SchemaColumnEditView()
    w2ui.schemaGrid.on('dblClick', (event) ->
      schemaColumnEditForm.exec(@get(event.recid))
    )

class @SchemaViews
  pstyle:
    'border: 1px solid #dfdfdf'

  sidebar:
    name: 'sidebar',
    nodes: [
      { id: 'general', text: 'Contents', group: true, expanded: true, nodes: [
        { id: 'grid1', text: 'Assets', img: 'icon-page', selected: true },
        { id: 'grid2', text: 'Files', img: 'icon-page' }
      ]}
    ],
    onClick: (event) ->
      switch event.target
         when 'grid1'
           location.href = '/dashboard'
         when 'grid2'
           location.href = '/dashboard'

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

  setupIndexWindow: ->
    $('#main-window').w2layout(
      name: 'layout',
      padding: 4,
      panels: [
        { type: 'left', size: 200, resizable: true, style: @pstyle, content: 'left' },
        { type: 'main', style: @pstyle, content: 'main' },
        { type: 'preview', size: '50%', resizable: true, hidden: true, style: @pstyle, content: 'preview' }
      ]
    )
    w2ui.layout.content('left', $().w2sidebar(@sidebar))

    # on memory component
    $().w2grid(@assetGrid)

    # default component
    w2ui.layout.content('main', w2ui.assetGrid)

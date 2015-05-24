class @SchemaColumnEditView
  columnEditForm:
    name: 'columnEditForm'
    style: 'border: 0px; background-color: transparent;'
    formHTML: $('#schemaColumnEditViewForm').render()
    fields: [
      { field: 'example', type: 'text' },
      { field: 'application_relation', type: 'text' },
      { field: 'note', type: 'text'},
    ]
    actions:
      save: ->
        if @validate().length == 0
          successCallback = ->
            w2ui['schemaGrid'].reload()
            $().w2popup('close')

          $.ajax({
            url: '/api/projects/' + gon.project_id + '/' + 'columns/' + @record.id,
            type: 'PUT',
            data: { record: @record }
          }).done(successCallback)

      reset: ->
        @clear()

  constructor: ->
    $().w2form(@columnEditForm)

  exec: (record) ->
    $().w2popup('open', {
       title   : 'Edit Column Info',
       body    : '<div id="form" style="width: 100%; height: 100%;"></div>',
       style   : 'padding: 15px 0px 0px 0px',
       width   : 700,
       height  : 450,
       showMax : true
       onToggle: (event) ->
         $(w2ui.columnEditForm.box).hide()
         event.onComplete = () ->
           $(w2ui.columnEditForm.box).show()
           w2ui.columnEditForm.resize()
       onOpen: (event) ->
         event.onComplete = ->
           w2ui['columnEditForm'].clear()
           w2ui['columnEditForm'].record = record
           $('#w2ui-popup #form').w2render('columnEditForm')
    })

class @SchemaColumnEditView
  columnEditForm:
    name: 'columnEditForm'
    style: 'border: 0px; background-color: transparent;'
    formHTML: $('#schemaColumnEditViewForm').render()
    fields: [
      { field: 'example', type: 'text', required: true },
      { field: 'application_relation', type: 'text', required: true },
      { field: 'note', type: 'text', required: true },
    ]
    actions:
      save: ->
        @validate()
      reset: ->
        @clear()

  init: ->
    $().w2form(@columnEditForm)

    $().w2popup('open', {
       title   : 'Edit Column Info',
       body    : '<div id="form" style="width: 100%; height: 100%;"></div>',
       style   : 'padding: 15px 0px 0px 0px',
       width   : 500,
       height  : 300,
       showMax : true
       onToggle: (event) ->
         $(w2ui.columnEditForm.box).hide()
         event.onComplete = () ->
           $(w2ui.foo.box).show()
           w2ui.foo.resize()
       onOpen: (event) ->
         event.onComplete = ->
           $('#w2ui-popup #form').w2render('columnEditForm')
    })

class @NewDivisionViews
  columnEditForm:
    name: 'newDivisionViewForm'
    style: 'border: 0px; background-color: transparent;'
    formHTML: $('#newDivisionViewForm').render()
    fields: [
      { field: 'name', type: 'text', required: true },
      { field: 'description', type: 'text' },
    ]
    actions:
      save: ->
        if @validate().length == 0
          successCallback = (data) ->
            w2ui.sidebarDivisionListing.insert('divisions', null, data)
            $().w2popup('close')

          $.ajax({
            url: '/api/projects/' + gon.project_id + '/' + 'divisions?version=' + @versionId
            type: 'POST',
            data: { record: @record }
          }).done(successCallback)

  constructor: ->
    $().w2form(@columnEditForm)

  exec: (versionId) ->
    $().w2popup('open', {
       title   : 'New Code Table',
       body    : '<div id="form" style="width: 100%; height: 100%;"></div>',
       style   : 'padding: 15px 0px 0px 0px',
       onOpen: (event) ->
         event.onComplete = ->
           $('#w2ui-popup #form').w2render('newDivisionViewForm')
           w2ui['newDivisionViewForm'].clear()
           w2ui['newDivisionViewForm'].versionId = versionId
    })

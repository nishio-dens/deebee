class @CodeFormView
  codeForm:
    name : 'codeForm',
    style    : 'border: 0px; background-color: transparent;'
    formHTML : $('#codeForm').render()
    fields: [
      { name: 'code_value', type: 'text', required: true },
      { name: 'name', type: 'text', required: true },
      { name: 'alias', type: 'text' },
      { name: 'comment', type: 'text' },
    ]
    actions:
      save: ->
        if @validate().length == 0
          successCallback = (data) ->
            w2ui['divisionGrid'].add(data)
            w2ui['divisionGrid'].reload()
            $().w2popup('close')

          if @recid == null
            $.ajax(
              url: '/api/projects/' + gon.project_id + '/divisions/' + @divisionId + '/codes' + '?version=' + @versionId,
              type: 'POST',
              data: { record: @record }
            ).done(successCallback)
          else
            $.ajax(
              url: '/api/projects/' + gon.project_id + '/divisions/' + @divisionId + '/codes/' + @record.recid + '?version=' + @versionId,
              type: 'PUT',
              data: { record: @record }
            ).done(successCallback)

      cancel: ->
        $().w2popup('close')
 
  constructor: ->
    unless w2ui.codeForm
      $().w2form(@codeForm)

  execAdd: (divisionId, versionId) ->
    $().w2popup('open', $.extend({
      title: 'Add Code',
      body : '<div id="code_form" style="width: 100%; height: 100%;"></div>',
      onOpen: (event) ->
        event.onComplete = ->
          $('#w2ui-popup #code_form').w2render('codeForm')
          w2ui['codeForm'].clear()
          w2ui['codeForm'].recid = null
          w2ui['codeForm'].divisionId = divisionId
          w2ui['codeForm'].versionId = versionId
    }, @codeForm))

  execEdit: (divisionId, versionId, record) ->
    $().w2popup('open', $.extend({
      title: 'Edit Code',
      body : '<div id="code_form" style="width: 100%; height: 100%;"></div>',
      onOpen: (event) ->
        event.onComplete = ->
          w2ui['codeForm'].clear()
          w2ui['codeForm'].record = record
          w2ui['codeForm'].divisionId = divisionId
          w2ui['codeForm'].versionId = versionId
          $('#w2ui-popup #code_form').w2render('codeForm')
    }, @codeForm))

  execDelete: (divisionId, versionId, recid) ->
    $.ajax(
      url: '/api/projects/' + gon.project_id + '/divisions/' + divisionId + '/codes/' + recid + '?version=' + versionId,
      type: 'DELETE',
      data: { record: @record }
    )

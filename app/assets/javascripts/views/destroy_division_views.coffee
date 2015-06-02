class @DestroyDivisionViews
  exec: (versionId, divisionId) ->
    $().w2popup('open', {
       title   : 'Destroy Code Table',
       body    : '<div class="w2ui-centered">Are you sure you want to destroy this code table?</div>',
       buttons : "<button class=\"w2ui-btn\" " +
                 "onclick=\"DestroyDivisionViews.destroy(#{versionId}, #{divisionId});\""+
                 '>Yes</button>' +
                 '<button class="w2ui-btn" onclick="w2popup.close();">No</button> ',
       modal   : true,
       showClose: true
    })

  @destroy: (versionId, divisionId) ->
    $.ajax({
      url: '/api/projects/' + gon.project_id + '/' + 'divisions/' + divisionId + '?version=' + versionId
      type: 'DELETE'
    })
    w2popup.close()
    w2ui.sidebarDivisionListing.remove(divisionId)


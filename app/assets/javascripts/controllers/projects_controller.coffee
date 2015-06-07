#= require views/schema_views

class @ProjectsController extends Marionette.Object
  moveTable: (id) ->
    SchemaViews.unfocusDivisionListing()
    versionId = $('#versions').val()
    SchemaViews.loadTableData(gon.project_id, id, versionId)
    SchemaViews.hideDivisionControl()

  moveDivision: (id) ->
    SchemaViews.unfocusTableListing()
    versionId = $('#versions').val()
    SchemaViews.loadDivisionData(gon.project_id, id, versionId)
    SchemaViews.showDivisionControl()


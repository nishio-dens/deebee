class Api::TablesController < ApplicationController
  before_action :set_version

  def index
    data = @version.tables.order(:name).map do |table|
      {
        id: table.id.to_s,
        text: table.name,
        img: 'icon-page'
      }
    end
    render json: data
  end

  def show
    table = @version.tables.find(params[:id])
    columns = table
      .columns
      .order(:ordinal_position)
      .map { |record| record.as_json.merge(recid: record.id) }
      .map { |record| set_related_links(record, @version) }
    data = {
      total: columns.count,
      records: columns
    }
    render json: data
  end

  private

  def set_version
    @version = Version.find_by(project_id: params[:project_id], id: params[:version])
  end

  def set_related_links(record, version)
    return record unless record['relation']
    related_table = version.tables.find_by(name: record['relation'])
    if related_table
      record['relation'] =
        "<a href='#' class='relationLink' data-relation-id='#{related_table.id}'>" +
        "<i class='fa fa-caret-right'></i> #{related_table.name}</a>"
    else
      record['relation'] = 'INVALID'
    end
    record
  end
end

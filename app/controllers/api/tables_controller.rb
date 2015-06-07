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
      .map { |record| set_relation_links(record, @version) }
      .map { |record| set_application_relation_links(record, @version) }
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

  def set_relation_links(record, version)
    return record unless record['relation']
    related_table = version.tables.find_by(name: record['relation'])
    if related_table
      record['relation'] = generate_table_links(related_table.id, related_table.name)
    end
    record
  end

  def set_application_relation_links(record, version)
    return record unless record['application_relation']
    related_table = version.tables.find_by(name: record['application_relation'])
    if related_table
      record['application_relation'] = generate_table_links(related_table.id, related_table.name)
    end
    related_division = version.divisions.find_by(name: record['application_relation'])
    if related_division
      record['application_relation'] = generate_division_links(related_division.id, related_division.name)
    end
    record
  end

  def generate_table_links(id, table_name)
    "<a href='#' class='relationLink' data-relation-id='#{id}'>" +
    "<i class='fa fa-caret-right'></i> #{table_name}</a>"
  end

  def generate_division_links(id, division_name)
    "<a href='#' class='divisionLink' data-relation-id='#{id}'>" +
    "<i class='fa fa-caret-right'></i> #{division_name}</a>"
  end
end

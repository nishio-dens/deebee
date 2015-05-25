class DbImportService
  def initialize(setting)
    @client = Mysql2::Client.new(
      host: setting.host,
      username: setting.username,
      password: setting.password,
      database: 'information_schema'
    )
    @database = setting.database
    @project = Project.find(setting.project_id)
  end

  def import(description = "")
    Version.transaction do
      snapshots = create_snapshot(description)
      snapshots.each(&:save)
    end
  end

  def create_snapshot(description)
    information_schema_columns = @client.query(select_mysql_columns(@database)).to_a

    version = Version.new(
      project_id: @project.id,
      name: "v#{Time.current.strftime("%y%m%d_%H%M%S")}",
      description: description
    )
    current_version = Version.where(project_id: @project.id).order(id: :desc).limit(1).first()

    columns = information_schema_columns.group_by { |v| v['TABLE_NAME'] }.map do |table_name, cc|
      current_table = current_version.tables.find_by(name: table_name)
      table = Table.new(
        version: version,
        name: table_name,
        description: current_table.try(:description)
      )

      current_columns = current_table.present? ? current_table.columns : []
      cc.map do |column|
        current_column = current_columns.find { |v| v.column == column['COLUMN_NAME'] }
        length = if ['decimal', 'real'].any? { |v| column['COLUMN_TYPE'].include? v }
                   "(#{column['NUMERIC_PRECISION']},#{column['NUMERIC_SCALE']})"
                 else
                   column['CHARACTER_MAXIMUM_LENGTH'] ||
                     column['COLUMN_TYPE'].scan(/\((\d+)\)/).flatten.first
                 end
        unsigned = if column['COLUMN_TYPE'].include? "unsigned"
                     "Y"
                   else
                     ""
                   end
        Column.new(
          table: table,
          column: column['COLUMN_NAME'],
          column_type: column['DATA_TYPE'],
          not_null: column['IS_NULLABLE'] == 'YES'? '' : 'Y',
          length: length,
          unsigned: unsigned,
          character_set_name: column['CHARACTER_SET_NAME'] || "",
          collation_name: column['COLLATION_NAME'] || "",
          default: column['COLUMN_DEFAULT'],
          key: column['COLUMN_KEY'],
          extra: column['EXTRA'],
          relation: column['REFERENCED_TABLE_NAME'],
          ordinal_position: column['ORDINAL_POSITION'],
          example: current_column.try(:example),
          note: current_column.try(:note)
        )
      end
    end
    columns.flatten
  end

  private

  def select_mysql_columns(database_name)
    <<EOS
    SELECT DISTINCT C.*, US.REFERENCED_TABLE_NAME FROM COLUMNS C
    LEFT OUTER JOIN KEY_COLUMN_USAGE US
    ON C.TABLE_SCHEMA = US.TABLE_SCHEMA
      AND C.TABLE_NAME = US.TABLE_NAME
      AND C.COLUMN_NAME = US.COLUMN_NAME

    WHERE c.TABLE_SCHEMA = '#{database_name}'
    ORDER BY C.TABLE_NAME, C.ORDINAL_POSITION
EOS
  end
end

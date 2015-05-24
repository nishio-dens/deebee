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
    information_schema_columns = @client.query(select_mysql_columns(@database)).to_a
    Version.transaction do
      create_snapshot(description)
    end
  end

  def create_snapshot(description)
    version = Version.new(
      project_id: @project.id,
      name: "v#{Time.current.strftime("%y%m%d_%H%M%S")}_#{Random.new.rand(1000)}",
      description: description
    )
    columns = information_schema_columns.group_by { |v| v['TABLE_SCHEMA'] }.map do |table_name, cc|
      table = Table.new(
        version: version,
        name: table_name,
        description: description
      )
      cc.map do |column|
        Column.new(
          table: table,
          column: column['COLUMN_NAME'],
          column_type: column['COLUMN_TYPE'],
          not_null: column['IS_NULLABLE'] == 'YES'? 'Y' : 'N',
          default: column['COLUMN_DEFAULT'],
          key: column['COLUMN_KEY'],
          extra: column['EXTRA'],
        )
      end
    end
    columns.flatten
  end

  private

  def select_mysql_columns(database_name)
    <<EOS
    SELECT * FROM COLUMNS C
    WHERE C.TABLE_SCHEMA = "#{database_name}"
    ORDER BY C.TABLE_NAME, C.ORDINAL_POSITION
EOS
  end
end

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

  def import
    columns = @client.query(select_mysql_columns(@database)).to_a
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

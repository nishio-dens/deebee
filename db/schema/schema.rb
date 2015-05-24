create_table :users, collate: :utf8_bin do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :username
  t.varchar :email, default: ""
  t.varchar :encrypted_password, default: ""
  t.int :sign_in_count, default: 0
  t.datetime :current_sign_in_at, null: true
  t.datetime :last_sign_in_at, null: true
  t.varchar :current_sign_in_ip, null: true
  t.varchar :last_sign_in_ip, null: true
  t.datetime :created_at
  t.datetime :updated_at

  t.index :email, name: "index_users_on_email", unique: true
end

create_table :projects , collate: :utf8_bin do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :name
  t.datetime :created_at
  t.datetime :updated_at
end

create_table :versions, collate: :utf8_bin do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :project_id
  t.varchar :name
  t.text :description
  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :project_id, reference: :projects, reference_column: :id
end

create_table :tables, collate: :utf8_bin do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :version_id
  t.varchar :name
  t.int :version_id
  t.text :description, null: true
  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :version_id, reference: :versions, reference_column: :id
end

create_table :columns, collate: :utf8_bin do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :table_id
  t.varchar :column
  t.varchar :column_type
  t.varchar :not_null, limit: 1, default: ''
  t.varchar :length, null: true, default: ''
  t.varchar :unsigned, limit: 1, default: ''
  t.varchar :character_set_name, limit: 30, default: ''
  t.varchar :collation_name, limit: 30, default: ''
  t.varchar :default, null: true
  t.varchar :key, null: true
  t.varchar :extra, default: ''
  t.text :example, null: true
  t.varchar :relation, null: true
  t.varchar :application_relation, null: true
  t.text :comment, null: true
  t.text :note, null: true
  t.int :ordinal_position
  t.datetime :created_at
  t.datetime :updated_at
  t.int :created_by, null: true
  t.int :updated_by, null: true

  t.foreign_key :table_id, reference: :tables, reference_column: :id
end

create_table :connection_settings, collate: :utf8_bin do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :project_id
  t.varchar :database
  t.varchar :username
  t.text :encrypted_password
  t.text :host
  t.datetime :created_at
  t.datetime :updated_at

  t.foreign_key :project_id, reference: :projects, reference_column: :id
end


create_table :schema_migrations, default_charset: "utf8mb4", collate: "utf8mb4_unicode_ci", comment: "" do |t|
  t.varchar "version", limit: 191

  t.index "version", name: "unique_schema_migrations", unique: true
end

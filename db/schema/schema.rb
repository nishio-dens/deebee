create_table :projects, collate: :utf8_bin, comment: "" do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :name
  t.varchar :key
  t.varchar :description
  t.varchar :creator_name, null: true
  t.varchar :updater_name, null: true
  t.int :created_by, null: true
  t.int :updated_by, null: true
  t.datetime :created_at
  t.datetime :updated_at
  t.datetime :deleted_at, null: true
end

create_table :schema_migrations, collate: :utf8_bin, comment: "" do |t|
  t.varchar :version

  t.index :version, name: 'unique_schema_migrations', unique: true
end

create_table :translations, collate: "utf8_bin", comment: "" do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :variable_name
  t.text :ja
  t.text :en
  t.int :project_id

  t.varchar :creator_name
  t.varchar :updater_name
  t.int :created_by
  t.int :updated_by
  t.datetime :created_at
  t.datetime :updated_at
  t.datetime :deleted_at, null: true
end

create_table :translation_histories, collate: "utf8_bin", comment: "" do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.int :translation_id
  t.varchar :variable_name
  t.text :ja
  t.text :en
  t.int :project_id

  t.varchar :creator_name
  t.varchar :updater_name
  t.varchar :changer_name
  t.int :created_by
  t.int :updated_by
  t.int :changed_by
  t.datetime :created_at
  t.datetime :updated_at
  t.datetime :changed_at
  t.datetime :deleted_at, null: true
end

create_table :users, collate: :utf8_bin, comment: "" do |t|
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

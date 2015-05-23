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

create_table :projects , collate: :utf8_bin, comment: "" do |t|
  t.int :id, primary_key: true, extra: :auto_increment
  t.varchar :name
  t.datetime :created_at
  t.datetime :updated_at
end

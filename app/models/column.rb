# == Schema Information
#
# Table name: columns
#
#  id                   :integer          not null, primary key
#  table_id             :integer          not null
#  column               :string(255)      not null
#  column_type          :string(255)      not null
#  not_null             :string(1)        default(""), not null
#  length               :string(255)      default("")
#  unsigned             :string(1)        default(""), not null
#  character_set_name   :string(30)       default(""), not null
#  collation_name       :string(30)       default(""), not null
#  default              :string(255)
#  key                  :string(255)
#  extra                :string(255)      default(""), not null
#  example              :text(65535)
#  relation             :string(255)
#  application_relation :string(255)
#  comment              :text(65535)
#  note                 :text(65535)
#  ordinal_position     :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  created_by           :integer
#  updated_by           :integer
#

class Column < ActiveRecord::Base
  belongs_to :table
end

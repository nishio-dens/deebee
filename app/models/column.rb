# == Schema Information
#
# Table name: columns
#
#  id         :integer          not null, primary key
#  table_id   :integer          not null
#  column     :string(255)      not null
#  type       :string(255)      not null
#  length     :integer
#  signed     :string(1)        default(""), not null
#  binary     :string(1)        default(""), not null
#  not_null   :string(1)        default(""), not null
#  default    :string(255)
#  key        :string(255)
#  example    :text(65535)
#  related    :string(255)
#  comment    :text(65535)
#  note       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  created_by :integer
#  updated_by :integer
#

class Column < ActiveRecord::Base
end

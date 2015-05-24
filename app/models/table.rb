# == Schema Information
#
# Table name: tables
#
#  id          :integer          not null, primary key
#  version_id  :integer          not null
#  name        :string(255)      not null
#  description :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Table < ActiveRecord::Base
  has_many :columns
end

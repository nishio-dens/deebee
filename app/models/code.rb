# == Schema Information
#
# Table name: codes
#
#  id          :integer          not null, primary key
#  division_id :integer          not null
#  code_value  :string(255)      not null
#  name        :string(255)      not null
#  alias       :string(255)
#  comment     :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Code < ActiveRecord::Base
  belongs_to :division

  validates :code_value, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :alias, length: { maximum: 255 }
  validates :comment, length: { maximum: 65_535 }
end

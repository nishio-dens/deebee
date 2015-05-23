# == Schema Information
#
# Table name: versions
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  name        :string(255)      not null
#  description :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Version < ActiveRecord::Base
  has_many :tables
end

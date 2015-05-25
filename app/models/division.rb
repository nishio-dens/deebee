# == Schema Information
#
# Table name: divisions
#
#  id          :integer          not null, primary key
#  version_id  :integer          not null
#  name        :string(255)      not null
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Division < ActiveRecord::Base
end

# == Schema Information
#
# Table name: connection_settings
#
#  id                 :integer          not null, primary key
#  project_id         :integer          not null
#  adapter            :string(255)      not null
#  database           :string(255)      not null
#  username           :string(255)      not null
#  encrypted_password :text(65535)      not null
#  host               :text(65535)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ConnectionSetting < ActiveRecord::Base
end

# == Schema Information
#
# Table name: connection_settings
#
#  id                 :integer          not null, primary key
#  project_id         :integer          not null
#  database           :string(255)      not null
#  username           :string(255)      not null
#  encrypted_password :text(65535)      not null
#  host               :text(65535)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ConnectionSetting < ActiveRecord::Base
  SECRET = 'a' * 128 # Dummy

  def password=(val)
    encryptor = ActiveSupport::MessageEncryptor.new(SECRET, cipher: 'aes-256-cbc')
    self.encrypted_password = encryptor.encrypt_and_sign(val)
    self.encrypted_password
  end

  def password
    encryptor = ActiveSupport::MessageEncryptor.new(SECRET, cipher: 'aes-256-cbc')
    encryptor.decrypt_and_verify(self.encrypted_password)
  end
end

# == Schema Information
#
# Table name: translations
#
#  id            :integer          not null, primary key
#  variable_name :string(255)      not null
#  ja            :text(65535)      not null
#  en            :text(65535)      not null
#  project_id    :integer          not null
#  creator_name  :string(255)      not null
#  updater_name  :string(255)      not null
#  created_by    :integer          not null
#  updated_by    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  deleted_at    :datetime
#

class Translation < ActiveRecord::Base
  include OperatorRecordable
  include CsvExportable

  acts_as_paranoid

  # Hooks
  after_save :create_history!

  # Validations
  validates :variable_name, presence: true, length: { maximum: 255 }
  validates :project_id, presence: true

  def create_history!
    attributes = self.attributes.except('id')
    history = TranslationHistory.new(attributes).tap do |h|
      h.translation_id = self.id
      h.changer_name = User.current.username
      h.changed_by = User.current.id
      h.changed_at = Time.current
    end
    history.save!
  end
end

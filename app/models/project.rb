# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  key          :string(255)      not null
#  description  :string(255)      not null
#  creator_name :string(255)
#  updater_name :string(255)
#  created_by   :integer
#  updated_by   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#

class Project < ActiveRecord::Base
  acts_as_paranoid

  # Relations
  has_many :translations

  # Validations
  validates :name, presence: true
  validates :key, presence: true
  validates :description, presence: true

  def translations_count
    @_translations_count ||= Translation.where(project_id: self.id).count
  end

  def untranslated_count
    t = Translation.arel_table
    @_untranslated_count ||= Translation
      .where(project_id: self.id)
      .where(t[:ja].not_eq('').and(t[:en].not_eq('')))
      .count
  end

  def translation_progress
    return 0 if translations_count <= 0
    (untranslated_count.to_f / translations_count.to_f) * 100.0
  end

  def export_translations_to_yaml(language = 'ja')
    fail if language != 'ja' && language != 'en'

    Translation
      .where(project_id: 1)
      .select(:variable_name, :ja, :en)
      .order(:variable_name)
      .map { |v| dot_text_to_hash("#{v.variable_name}.#{v.send(language)}") }
      .reduce({}) { |a, e| a.deep_merge(e) }
      .to_yaml
      .gsub("---\n", '')
  end

  private

  def dot_text_to_hash(text)
    car, cdr = text.split('.', 2)
    return car if cdr.nil?
    { car => dot_text_to_hash(cdr) }
  end
end

class Form::TranslationImportItem < Form::Base
  attr_accessor :sync_mode, :variable_name, :ja, :en, :original_translation

  validates :locale, presence: true
  validates :filetype, presence: true
  validates :file, presence: true
end

require 'yaml'

class Form::FileImportSetting
  include ActiveModel::Model
  include ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :locale, :filetype, :file, :sync_delete

  validates :locale, presence: true
  validates :filetype, presence: true
  validates :file, presence: true

  def parse_file(project)
    case filetype
    when 'yaml'
      yaml_to_import_items(project)
    else
      fail '不正なファイル形式'
    end
  end

  private

  # 色々ひどいのでFIXME
  def yaml_to_import_items(project)
    data = Hash[*flatten_hash(YAML.load(file.read))]
    data.reject! { |_, v| v.is_a? Array }

    cached_translations = Translation.where(project_id: project.id)
    items = data.map do |k, v|
      item = Form::TranslationImportItem.new(variable_name: k)

      translation = cached_translations.find { |t| t.variable_name == k }
      if translation.present?
        item.original_translation = translation
        if (self.locale == 'ja' && translation.ja == v) || (self.locale == 'en' && translation.en == v)
          item.sync_mode = :stable
        else
          item.sync_mode = :update
        end
      else
        item.sync_mode = :create
      end

      case self.locale
      when 'ja'
        item.ja = v
      when 'en'
        item.en = v
      else
        fail '不正な言語選択'
      end

      item
    end

    if sync_delete == '1'
      items.concat Translation.where(project_id: project.id).where.not(variable_name: [data.map { |k, v| k }]).map { |tran|
        Form::TranslationImportItem.new(
          sync_mode: :delete,
          variable_name: tran.variable_name,
          original_translation: tran
        )
      }.to_a
    end

    items
  end

  def flatten_hash(hash, parent=[])
    hash.flat_map do |key, value|
      case value
      when Hash then flatten_hash(value, parent + [key])
      else [(parent+[key]).join('.'), value]
      end
    end
  end
end

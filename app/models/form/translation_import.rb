class Form::TranslationImport < Form::Base
  attr_accessor :items, :locale

  def items_attributes=(attributes)
    self.items = attributes.map do |_, item_attributes|
      Form::TranslationImportItem.new(item_attributes)
    end
  end

  def import(project)
    Translation.transaction do
      create_new_items!(items, project)
      update_items!(items, project)
      delete_items!(items, project)
    end
  end

  private

  def create_new_items!(items, project)
    items.select { |v| v.sync_mode.to_sym == :create }.each do |t|
      Translation.new(
        variable_name: t.variable_name,
        ja: t.ja,
        en: t.en,
        project_id: project.id
      ).save
    end
  end

  def update_items!(items, project)
    items.select { |v| v.sync_mode.to_sym == :update }.each do |t|
      original = Translation.find_by(project_id: project.id, variable_name: t.variable_name)
      if self.locale.to_sym == :ja
        original.ja = t.ja
      elsif self.locale.to_sym == :en
        original.en = t.en
      else
        fail "Invalid Locale"
      end
      original.save
    end
  end

  def delete_items!(items, project)
    variables = items
      .select { |v| v.sync_mode.to_sym == :delete }
      .map { |v| v.variable_name }
    Translation.where(project_id: project.id, variable_name: variables).delete_all
  end
end

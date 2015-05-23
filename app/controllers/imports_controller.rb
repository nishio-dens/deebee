class ImportsController < ApplicationController
  before_action :set_project

  def index
    @form = Form::FileImportSetting.new
  end

  def confirm
    @import_setting = Form::FileImportSetting.new(file_import_setting_params)
    if @import_setting.valid?
      @parsed_items = @import_setting.parse_file(@project)
      @form = Form::TranslationImport.new(
        items: @parsed_items, locale: @import_setting.locale)
      @form.items = @parsed_items
    else
      @errors = @import_setting.errors.full_messages
      @form = Form::FileImportSetting.new
      render :index
    end
  end

  def create
    @form = Form::TranslationImport.new(import_params)
    @form.import(@project)
    redirect_to project_translations_path(project_id: @project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def file_import_setting_params
    params
      .require(:form_file_import_setting)
      .permit(:locale, :filetype, :file, :sync_delete)
  end

  def import_params
    params.require(:form_translation_import).permit(
      :locale,
      items_attributes: [:sync_mode, :variable_name, :ja, :en]
    )
  end
end

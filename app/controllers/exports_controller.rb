class ExportsController < ApplicationController
  def index
    project = Project.find(params[:project_id])
    type = params[:type]
    data = case type
           when 'yml'
             project.export_translations_to_yaml(params[:language])
           else
             project
               .translations
               .to_csv(header: ['Variable Name', 'Ja', 'En'], columns: ['variable_name', 'ja', 'en'])
           end
    send_data data, filename: "#{project.key}.#{type}"
  end
end

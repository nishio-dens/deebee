class Api::ColumnsController < ApplicationController
  def update
    column = Column.find(params[:id])
    column.update_attributes(registerable_params)
    render json: column
  end

  private

  def registerable_params
    params.require(:record).permit(
      :example, :application_relation, :note
    )
  end
end

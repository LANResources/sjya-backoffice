class ReportsController < ApplicationController
  def index
  end

  def show
    @builder = Reports::ReportBuilder.new type: params[:id]
    if @builder.valid?
      @report = @builder.build params.slice(:start_date, :end_date)
    else
      redirect_to reports_path
    end
  end
end

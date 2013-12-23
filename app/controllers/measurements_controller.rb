class MeasurementsController < ApplicationController

  def update
    @measurement = current_resource
    authorize! @measurement

    respond_to do |format|
      if @measurement.update(measurement_attributes)
        format.html { redirect_to @measurement, notice: 'Measure was successfully updated.' }
        format.json { respond_with_bip(@measurement) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@measurement) }
      end
    end
  end

  private
    def current_resource
      @current_resource ||= Measurement.find(params[:id]) if params[:id]
    end

    def measurement_attributes
      params.require(:measurement).permit *policy(@measurement || Measurement).permitted_attributes
    end
end

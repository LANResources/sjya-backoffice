class MeasurementsController < ApplicationController
  before_action :find_measure

  def new
    @measurement = @measure.measurements.build
    @measurement.year = params[:year].to_i

    respond_to do |format|
      format.js { render 'modal' }
    end
  end

  def create
    @measurement = @measure.measurements.build measurement_attributes
    authorize! @measurement

    respond_to do |format|
      if @measurement.save
        format.html { redirect_to root_url, notice: 'Measurement was successfully created.' }
        format.js
      else
        format.html { redirect_to root_url }
        format.js { render 'error' }
      end
    end
  end

  def edit
    @measurement = current_resource
    authorize! @measurement

    respond_to do |format|
      format.js { render 'modal' }
    end
  end

  def update
    @measurement = current_resource
    authorize! @measurement

    respond_to do |format|
      if @measurement.update(measurement_attributes)
        format.html { redirect_to @measurement, notice: 'Measure was successfully updated.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js { render 'error' }
      end
    end
  end

  def destroy
    @measurement = current_resource
    authorize! @measurement

    @year = @measurement.year

    @measurement.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  private
    def find_measure
      @measure ||= Measure.find(params[:measure_id]) if params[:measure_id]
    end

    def current_resource
      @current_resource ||= Measurement.find(params[:id]) if params[:id]
    end

    def measurement_attributes
      params.require(:measurement).permit *policy(@measurement || Measurement).permitted_attributes
    end
end

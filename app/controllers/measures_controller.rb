class MeasuresController < ApplicationController

  def index
    @measures = Measure.includes(:source, :measurements)
    @measurements = Measurement.includes(:measure).to_a.group_by{|m| [m.measure_id, m.year]}
  end

  def new
    @measure = Measure.new
    authorize! @measure
  end

  def edit
    @measure = current_resource
    authorize! @measure
  end

  def create
    @measure = Measure.new measure_attributes
    authorize! @measure

    respond_to do |format|
      if @measure.save
        format.html { redirect_to @measure, notice: 'Measure was successfully created.' }
        format.json { render action: 'show', status: :created, location: @measure }
      else
        format.html { render action: 'new' }
        format.json { render json: @measure.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @measure = current_resource
    authorize! @measure

    respond_to do |format|
      if @measure.update(measure_attributes)
        format.html { redirect_to @measure, notice: 'Measure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @measure.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @measure = current_resource
    authorize! @measure

    @measure.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_url }
      format.json { head :no_content }
    end
  end

  private
    def current_resource
      @current_resource ||= Measure.find(params[:id]) if params[:id]
    end

    def measure_attributes
      params.require(:measure).permit *policy(@measure || Measure).permitted_attributes
    end
end

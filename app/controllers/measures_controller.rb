class MeasuresController < ApplicationController

  def index
    @measures = Measure.includes(:source, :measurements).order(:created_at)
    @measurements = Measurement.includes(:measure).tap{|m| @years = m.pluck(:year).uniq.sort }.to_a.group_by{|m| [m.measure_id, m.year]}
  end

  def new
    @measure = Measure.new
    authorize! @measure

    respond_to do |format|
      format.js { render 'modal' }
    end
  end

  def edit
    @measure = current_resource
    authorize! @measure

    respond_to do |format|
      format.js { render 'modal' }
    end
  end

  def create
    @measure = Measure.new measure_attributes
    authorize! @measure

    respond_to do |format|
      if @measure.save
        format.html { redirect_to root_url, notice: 'Measure was successfully created.' }
        format.js {
          @years = Measurement.pluck(:year).uniq.sort
          @show_new_year_column = !@years.include?(Date.today.year) && policy(Measurement).create?
        }
      else
        format.html { redirect_to root_url }
        format.js { render 'error' }
      end
    end
  end

  def update
    @measure = current_resource
    authorize! @measure

    respond_to do |format|
      if @measure.update(measure_attributes)
        format.html { redirect_to root_url, notice: 'Measure was successfully updated.' }
        format.json { respond_with_bip(@measure) }
        format.js {
          @measurements = Measurement.includes(:measure).tap{|m| @years = m.pluck(:year).uniq.sort }.where(measure_id: @measure.id).to_a.group_by{|m| [m.measure_id, m.year]}
          @show_new_year_column = !@years.include?(Date.today.year) && policy(Measurement).create?
        }
      else
        format.html { redirect_to root_url }
        format.json { respond_with_bip(@measure) }
        format.js { render 'error' }
      end
    end
  end

  def destroy
    @measure = current_resource
    authorize! @measure

    @measure.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
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

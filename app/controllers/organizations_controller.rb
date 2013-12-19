class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.includes(:sector).order("#{sort_column} #{sort_direction}").page(params[:page]).per_page(25)
  end

  def show
    @organization = current_resource
    authorize! @organization
  end

  def new
    @organization = Organization.new
    authorize! @organization
  end

  def edit
    @organization = current_resource
    authorize! @organization
  end

  def create
    @organization = Organization.new organization_attributes
    authorize! @organization

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @organization = current_resource
    authorize! @organization

    respond_to do |format|
      if @organization.update(organization_attributes)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization = current_resource
    authorize! @organization

    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private
    def current_resource
      @current_resource ||= Organization.find(params[:id]) if params[:id]
    end

    def organization_attributes
      params.require(:organization).permit *policy(@organization || Organization).permitted_attributes
    end

    def sort_column
      super(Organization.column_names + ['sectors.name'], 'name')
    end
end

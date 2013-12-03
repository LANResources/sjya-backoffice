class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :download, :edit, :update, :destroy]

  def index
    @documents = Document.all
  end

  def show
  end

  def download
    send_data @document.item.file.download,
      type: @document.content_type,
      filename: @document.filename,
      disposition: 'attachment'
  end

  def new
    @document = current_user.documents.build
    authorize! @document
  end

  def edit
  end

  def create
    @document = Document.new document_attributes
    @document.user = current_user
    authorize! @document

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render action: 'show', status: :created, location: @document }
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @document.update document_attributes
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
    end
  end

  private
    def set_document
      @document = current_resource
      authorize! @document
    end

    def current_resource
      if params[:action] == 'create'
        @current_resource ||= params[:document] if params[:document]
      else
        @current_resource ||= Document.find(params[:id]) if params[:id]
      end
    end

    def document_attributes
      params.require(:document).permit *policy(@document || Document).permitted_attributes
    end
end

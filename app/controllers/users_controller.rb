class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_resource
    authorize! @user
  end

  def new
    @user = User.new
    authorize! @user
  end

  def edit
    @user = current_resource
    authorize! @user
  end

  def create
    @user = User.new user_attributes
    authorize! @user

    respond_to do |format|
      if @user.save
        current_user.send_invite(@user) unless @user.contact?
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_resource
    authorize! @user

    user_params = params[:user][:password].blank? ? user_attributes.except!(:password, :password_confirmation) : user_attributes
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_resource
    authorize! @user

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def current_resource
      if params[:action] == 'create'
        @current_resource ||= params[:user] if params[:user]
      else
        @current_resource ||= User.find(params[:id]) if params[:id]
      end
    end

    def user_attributes
      params.require(:user).permit *policy(@user || User).permitted_attributes
    end
end

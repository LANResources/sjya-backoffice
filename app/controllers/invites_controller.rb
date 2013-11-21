class InvitesController < ApplicationController
  skip_before_filter :verify_authentication, only: [:edit, :update]
  before_filter :verify_invitation, only: :edit
  before_filter :verify_and_authorize_registration, only: :update
  layout 'registration', only: [:edit, :update]

  def create
    @user = current_resource
    authorize_invite

    respond_to do |format|
      if current_user.send_invite @user
        format.html { redirect_to @user, notice: "Successfully sent an invitation to #{@user.full_name}." }
        format.json { head :no_content }
      else
        format.html { redirect_to @user, error: 'Unable to invite user.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = current_resource
    authorize_invite
  end

  def update
    authorize_invite

    respond_to do |format|
      if @user.register(@token, params[:user])
        format.html { redirect_to root_url, notice: 'Success! You are now a registered user of the Youth Alliance BackOffice.' }
        format.json { head :no_content }
      else
        sign_out
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  rescue
    sign_out
  end

  def destroy
    @user = current_resource
    authorize_invite

    current_user.uninvite @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  private

  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end

  def verify_invitation
    deny_access if signed_in?
    unless User.where(id: params[:id], invite_token: params[:invite_code]).exists?
      redirect_to login_path, error: "The invitation link you're attempting to use is not valid."
    end
  end

  def verify_and_authorize_registration
    sign_in current_resource if current_resource
    @user = current_user
    @token = params[:user][:invite_token]
    verify_authentication
  end

  def authorize_invite
    raise Pundit::NotAuthorizedError unless InvitePolicy.new(current_user, @user).send("#{params[:action]}?")
  end
end

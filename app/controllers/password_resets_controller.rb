class PasswordResetsController < ApplicationController
  skip_before_filter :verify_authenticated
  before_filter :find_user, only: [:edit, :update]
  layout 'registration'

  def new
  end
  
  def create
    user = User.find_by_email params[:email]
    user.send_password_reset if user
    flash[:success] = "Email sent with password reset instructions."
    redirect_to login_url
  end

  def edit
  end

  def update
    case @user.reset_password user_attributes
    when :expired
      flash[:error] = "Password reset has expired."
      redirect_to new_password_reset_path
    when true
      sign_in @user
      flash[:success] = "Password has been reset!"
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by_password_reset_token! params[:id]
  rescue
    flash[:error] = 'The password reset token is invalid. Please request a new one.'
    redirect_to login_url
  end

  def user_attributes
    params.require(:user).permit [:password, :password_confirmation]
  end
end

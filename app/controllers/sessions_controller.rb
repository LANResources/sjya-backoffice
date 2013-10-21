class SessionsController < ApplicationController
  layout 'external', only: [:new, :create]
  # skip_before_filter :authorize, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end

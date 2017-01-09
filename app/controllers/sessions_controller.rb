class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      flash[:success] = 'Successfully Logged In'
      session[:user_id] = user.id
      redirect_to :root
    else
      flash[:danger] = 'Email And/ Or Password Were Incorrect'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :login
  end
end

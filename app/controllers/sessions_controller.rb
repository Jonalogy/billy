class SessionsController < ApplicationController
  def create
    user = User.authenticate(user_params)

    if user
      session[:user_id] = user.id
      flash[:success] = "User logged in!!"
      redirect_to dashboard_path
    else
      flash[:danger] = "Credentials Invalid!!"
      redirect_to root_path
    end
  end #END create

  def destroy
    session[:user_id] = nil
    flash[:success] = "User logged out!!"
    redirect_to root_path
  end # destroy

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

class SessionsController < ApplicationController
  def create
    @user = User.find_by_name(params[:session][:name])
    if @user
      flash[:notice] = "Login success"
      sign_in_and_redirect :user, current_user
    else
      redirect_to new_user_session_path, :alert => "Login fail"
    end  
  end

  def failure
    redirect_to new_user_session_path, :alert => params[:message]
  end

end

class RegistrationController < ApplicationController
   def new
       @user= User.new
   end

   def create
       @user = User.new
       @user.name = params[:user][:name]
       @user.email = params[:user][:email]
       @user.password = params[:user][:password]
       @user.password_confirmation =params[:user][:password_confirmation]
       @user.valid?
       if @user.errors.blank?
          @user.save
          redirect_to new_user_session_path, :alert => "User was successfully created ."
       else
          render :action => "new"
       end
   end

end

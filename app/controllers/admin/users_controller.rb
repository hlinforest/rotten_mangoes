class Admin::UsersController < ApplicationController
  before_action :require_admin

  def require_admin
    if !current_user.try(:admin)
      flash[:error] ="Unauthorized Access"
      redirect_to movies_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :admin, :password, :password_confirmation)
  end

end

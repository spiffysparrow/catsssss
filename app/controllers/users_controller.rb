class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    p "--------------------Create"
    @user = User.new(user_params)
    if @user.save!
      redirect_to user_url(@user)
    else
      p "--------------------Not svaed"
      # render :new
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

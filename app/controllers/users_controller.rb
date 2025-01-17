class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      @user.send_confirmation_instructions
      redirect_to confirmation_sent_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      # ユーザーを保存後に認証メールを送信
      @user.send_confirmation_instructions
      redirect_to confirmation_sent_path
    else
      render :new
    end
  end
  
  private
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password)
  end
end

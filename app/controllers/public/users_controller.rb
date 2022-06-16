class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find(params[:id])
    @drinks = @user.drinks
  end
  
  def edit
    @user = current_user
  end
  
  def update
    if @user.update(user_params)
      redirect_to public_user_path(@user)
    else
      render "edit"
    end
  end
  
  def quit
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
  
end

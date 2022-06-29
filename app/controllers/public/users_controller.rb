class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]#ゲストユーザー
  before_action :set_q, only: [:index, :search, :show]#検索機能

  def show
    @user = User.find(params[:id])
    @drinks = @user.drinks
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
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

  def search
    @results = @q.result
  end



  private

  #検索機能
  def set_q
    @q = Drink.ransack(params[:q])
  end

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  #ゲストユーザーがユーザー編集に飛べないようにする
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to public_user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to public_user_path(current_user)
    end
  end

end

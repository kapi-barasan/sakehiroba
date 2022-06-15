class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @drinks = @user.drinks
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to public_user_path(@user)
    else
      render "edit"
    end
  end
  
end

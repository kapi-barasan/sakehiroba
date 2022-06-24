class Public::DrinkCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

   def create
    @drink = Drink.find(params[:drink_id])
    @comment = current_user.drink_comments.new(drink_comment_params)
    @comment.drink_id = @drink.id
    @comment.save
    render :create
   end

   def destroy
    @comment = DrinkComment.find_by(id: params[:id], drink_id: params[:drink_id])
    @drink = Drink.find(params[:drink_id])
    @comment.destroy
    render :destroy
   end

  private

  def drink_comment_params
    params.require(:drink_comment).permit(:comment)
  end
  
  def ensure_correct_user
    @drink = Drink.find(params[:id])
    unless @drink.user == current_user
      redirect_to public_drinks_path
    end
  end

end

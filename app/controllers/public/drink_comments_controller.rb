class Public::DrinkCommentsController < ApplicationController

   def create
    @drink = Drink.find(params[:drink_id])
    @comment = current_user.drink_comments.new(drink_comment_params)
    @comment.drink_id = drink.id
    @comment.save
    redirect_to public_drink_path(@drink)
   end

   def destroy
    @comment = DrinkComment.find_by(id: params[:id], drink_id: params[:drink_id])
    @comment.destroy
   end

  private

  def drink_comment_params
    params.require(:drink_comment).permit(:comment)
  end

end

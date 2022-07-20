class Public::FavoritesController < ApplicationController
  
  def create
    drink = Drink.find(params[:drink_id])
    @favorite = current_user.favorites.new(drink_id: drink.id)
    @favorite.save
    redirect_to drink_path(drink)
  end

  def destroy
    drink = Drink.find(params[:drink_id])
    @favorite = current_user.favorites.find_by(drink_id: drink.id)
    @favorite.destroy
    redirect_to drink_path(drink)
  end
  
end

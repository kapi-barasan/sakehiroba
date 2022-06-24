class Admin::DrinksController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @drinks = Drink.page(params[:page])
  end

  def show
    @drink = Drink.find(params[:id])
  end
  
  def destroy
    @drink = Drink.find(params[:id])
    @drink.destroy
    redirect_to admin_drinks_path
  end


end

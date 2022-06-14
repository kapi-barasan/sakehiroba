class Public::DrinksController < ApplicationController
  
  def new
    @drink = Drink.new
  end
  
  def show
    @drink = Drink.find(params[:id])
  end
  
  def index
    @drinks = Drink.all
  end
  
  def create
    @drink = Drink.new(drink_params)
    @drink.user_id = current_user.id
    if @drink.save
      redirect_to public_drink_path(@drink)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @drink.update(drink_params)
      redirect_to public_drink_path(@drink)
    else
      render "edit"
    end
  end
  
  def destroy
    @drink.destroy
    redirect_to public_drinks_path
  end
  
  
  private
  
  def drink_params
    params.require(:drink).permit(:name, :body, :rate, :image)
  end
  
end

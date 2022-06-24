class Public::DrinksController < ApplicationController
  before_action :set_q, only: [:index, :search, :show]


  def new
    @drink = Drink.new
  end

  def show
    @drink = Drink.find(params[:id])
    @drink_comment = DrinkComment.new
  end

  def index
    @drinks = Drink.all
    @drinks_all = Drink.page(params[:page]).per(5)
  end

  def create
    @drink = Drink.new(drink_params)
    @drink.user_id = current_user.id
    tag_list = params[:drink][:tag_ids].split(',')
    if @drink.save
      @drink.save_tags(tag_list)
      redirect_to public_drink_path(@drink)
    else
      render 'new'
    end
  end

  def edit
    @drink = Drink.find(params[:id])
    @tag_list = @drink.tags.pluck(:name).join(",")
  end

  def update
    @drink = Drink.find(params[:id])
    tag_list = params[:drink][:tag_ids].split(',')
    if @drink.update(drink_params)
      @drink.save_tags(tag_list)
      redirect_to public_drink_path(@drink)
    else
      render "edit"
    end
  end

  def destroy
    @drink = Drink.find(params[:id])
    @drink.destroy
    redirect_to public_drinks_path
  end

  def search
    @results = @q.result
  end


  private

  def set_q
    @q = Drink.ransack(params[:q])
  end

  def drink_params
    params.require(:drink).permit(:name, :body, :rate, :image)
  end

end

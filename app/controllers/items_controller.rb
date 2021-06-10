class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
      render json: items
    else
      items = Item.all
      render json: items, include: :user 
    end
  rescue ActiveRecord::RecordNotFound
    render json: {"errors": "User not found"}, status: :not_found
  end

  def show
    user = User.find(params[:user_id])
    item = Item.find(params[:id])
    render json: item
  rescue ActiveRecord::RecordNotFound
    render json: {"errors": "Item not found"}, status: :not_found
  end

  def create
    # byebug
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end

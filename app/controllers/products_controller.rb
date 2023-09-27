class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

  def add_item_cart_path
    @product = Product.find params[:id]
    
    if @product.quantity > 0
      @product.quantity -= 1
      @product.save
      # Add the item to the cart here if needed.
    end

    redirect_back fallback_location: root_path
  end

end

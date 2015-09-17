class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #requiring user to be authenticated
  before_action :authenticate_user!

  respond_to :html

  def sales 
    @orders = Order.all.where(seller: current_user.id).order("created_at DESC")
  end

  def purchases 
    @orders = Order.all.where(buyer: current_user.id).order("created_at DESC")
  end

  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
    respond_with(@order)
  end

  def create
    @order = Order.new(order_params)
    #Find id listing want to buy in the URL
    @listing = Listing.find(params[:listing_id])
    @seller = @listing.user #seller is the same who creates the relative listing
    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    #@order.seller_id = @listing.user_id # was: @order.seller_id = @seller.id
    @order.seller_id = @seller.id
    flash[:notice] = 'Order was sucessfully created.' if @order.save
    respond_with(@listing)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :city, :state, :zipcode)
    end
end

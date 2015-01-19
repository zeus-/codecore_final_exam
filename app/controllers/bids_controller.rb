class BidsController < ApplicationController

  before_action :authenticate_user!
  def create
    @auction = Auction.find(params[:auction_id]) 
    @bid = @auction.bids.new(bids_params)
   
    if @bid.price != nil && current_user != @auction.user && @bid.price > @auction.current_price 
      @bid.user = current_user
      @bid.save
      @auction.update_attributes(current_price: @bid.price + 1)
      redirect_to @auction 
    else
      redirect_to @auction 
      if current_user == @auction.user 
        flash[:alert] = "You cant bid on you own auction, fool"
      else
        flash[:alert]= "Please enter a valid number that is higher than the current bid!"
      end
    end
  end

  def destroy
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.bids.find(params[:id])
    if current_user == @bid.user && @bid.destroy 
      if @auction.bids.present?
        @auction.update_attributes(current_price: @auction.bids.first.price + 1)
      end
      redirect_to @auction, alert: "Bid deleted!"
    else
      flash.now[:alert] = "Delete failed"
      redirect_to @auction  
    end
  end
  
  private
    def bids_params
      params.require(:bid).permit([:price])
    end
end

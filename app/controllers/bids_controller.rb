class BidsController < ApplicationController

  before_action :authenticate_user!
  def create
    @auction = Auction.find(params[:auction_id]) 
    @bid = @auction.bids.new(bids_params)
    @bid.user = current_user
    respond_to do |format| 
      if valid_bid     
        @auction.update_attributes(current_price: @bid.price + 1)
        format.html { redirect_to @auction, notice: "Bid created happilly!" }
        format.js { render } 
      else
        if current_user == @auction.user 
          format.html { redirect_to @auction, alert:  "You cant bid on you own auction, fool" }
          format.js { render js: "alert('You cant bid on you own auction, fool');" } 
        else
          format.html { render "auctions/show", alert: "Please enter a valid number that is higher than the current bid!" }
          format.js { render js: "alert('Please enter a valid number that is higher than the current bid!');" }
        end
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
      render "auctions/show"  
    end
  end
  
  private
    def valid_bid 
       @bid.price.present? && current_user != @auction.user && @bid.price > @auction.current_price && @bid.save  
    end
    def bids_params
      params.require(:bid).permit([:price])
    end
end

class WelcomeController < ApplicationController
  def index
   @auctions = Auction.published.paginate(:page => params[:page], :per_page => 3).order("created_at DESC")
   # @auctions = Auction.published.all
  end
end

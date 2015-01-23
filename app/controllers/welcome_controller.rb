class WelcomeController < ApplicationController
  def index
   @auctions = Auction.published.paginate(:page => params[:page], :per_page => 1).order("created_at DESC")
   # @auctions = Auction.published.all
  end
end

class AuctionsController < ApplicationController
    
  before_action :authenticate_user!, except: [:show]
  before_action :find_auction, only: [:edit, :update, :destroy]
  
  def index    
    @auctions = current_user.auctions.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
  end
  
  def new   
    @auction = Auction.new
  end

  def create    
    @auction = current_user.auctions.new(auction_params)
    if @auction.save
      redirect_to auctions_path 
      flash[:success] = "Your auction is ready to be published"
    else
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end

  def show
    @auction = Auction.find(params[:id])
    @bid =  Bid.new
    @bids = @auction.bids.paginate(:page => params[:page], :per_page => 5) 
    #@price = @auction.bids.last || Bid.new
  end

  def edit
    # renders the edit page for the question passed
    #redirect_to root_path unless can? :edit, @question
  end

  def update
    if @auction.update_attributes(auction_params) 
      redirect_to @auction, notice: "Updated successfully"
    else
      flash.now[:alert] = "Update failed"
      render :edit
    end
  end
  
  def destroy
    if current_user == @auction.user && @auction.destroy 
      redirect_to auctions_path, alert: "Auction deleted!"
    else
      flash.now[:alert] = "Delete failed"
      render @auction  
    end
  end
  
  def publish 
    @auction = Auction.find(params[:id])
    if @auction.publish
      redirect_to root_path, success: "Your auction is now published for all the world to see!"
    else
      redirect_to auctions_path, alert: "Your auction cannot be published!"
    end
  
  end
  def reserve
    @auction = Auction.find(params[:id])
    if @auction.reserve
      redirect_to @auction
      flash[:success] = "You have reserved this item!" 
    else
      redirect_to @auction, alert:  "You already reserved this item!"
    end
  end
  
  #def reserve
   # @auction = Auction.find(params[:id])
   # @bid = @auction.bids.find(params[:bid_id])
    #if @bid.price == @auction.reserve_price || @bid.price > @auction.reserve_price
     #if @auction.reserve
      #redirect_to @auction, notice: "Campaign published successfully."
      #else
      #render :text => "cant reserve due to error"

      #redirect_to campaigns_path, alter: "Campaign publishing failed: #{@campaign.errors.full_messages}"
    #end
    #end
  #end

   private
    def auction_params
      auction_params = params.require(:auction).permit([:title, :details, :ends_on, :reserve_price, :current_price])
    end
    def find_auction
     # @auction = Auction.find(params[:id] || params[:auction_id])
      @auction = current_user.auctions.find_by_id(params[:id])
      redirect_to root_path, alert: "Access denied, foo" unless @auction
    end
end

class AuctionsController < ApplicationController
    
  before_action :authenticate_user!, except: [:show]
  before_action :find_auction, only: [:edit, :update, :destroy]
  
  def index    
    @auctions = current_user.auctions.order("created_at DESC")
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
    @auction = Auction.find(params[:id] || params[:question_id])
    @bid =  Bid.new
    @bids = @auction.bids.all
    #@price = @auction.bids.last || Bid.new
   # @answers = @question.answers.ordered_by_creation
    #changed jan 6
   # @comments = @answer.comments.recent_ten
   # if user_signed_in? 
    #  @vote = current_user.vote_for(@question) || Vote.new 
    #  @favorite = current_user.favorite_for(@question) || Favorite.new
   # else
    #  @vote = Vote.new
    #  @favorite = Favorite.new
    #end
  end

  def edit
    # renders the edit page for the question passed
    #redirect_to root_path unless can? :edit, @question
  end

  def update
    # handles the update action when sumbitted in the edit page
    if @auction.update_attributes(auction_params) 
      redirect_to @auction, notice: "Updated successfully"
    else
      flash.now[:alert] = "Update failed"
      #render :edit
    end
  end
  
  def destroy
   # if @question.destroy 
    #  redirect_to questions_path, notice: "Q deleted through '@question, method: :delete'"
   # else
   #   flash.now[:alert] = "Cant delete this Q"
    #  render @question  
   # end
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
      redirect_to @auction, alert:  "Sorry foo, already reserved!"
    end
  end
  #def vote_up
   # @question.increment!(:vote_count)
   # session[:has_voted] = true
   # redirect_to @question
  #end

  #def vote_down
   # @question.decrement!(:vote_count)
   # session[:has_voted] = true
   # redirect_to @question
  # end
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

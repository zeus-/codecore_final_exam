class ProfilesController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @bids = @user.bids.paginate(:page => params[:page], :per_page => 10)
  end
end

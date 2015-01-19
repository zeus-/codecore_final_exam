require 'rails_helper'

describe BidsController, :type => :controller do
  let(:user) { create(:user) }
  let(:auction) { create(:auction) }
  before { sign_in user } 

  describe "#create" do 
    context "user tries to post a bid thats lower than the current higest bid" do
      def first_bid
        post :create, auction_id: auction.id, bid: { price: 200 }
      end
      def low_bid
        post :create, auction_id: auction.id, bid: { price: 1 }
      end
      it "doesnt create a bid in db with low bid" do
        first_bid
        expect { low_bid }.to_not change { Bid.count }
      end
      it "sets a flash alert" do
        first_bid
        low_bid
        expect(flash[:alert]).to be
      end
    end
    
    context "with a valid bid" do
      def valid_bid
        post :create, auction_id: auction.id, bid: { price: 100 } 
      end
      it "creates a bid in the db with valid params" do
        expect do
          valid_bid
        end.to change { Bid.count }.by(1)
      end
      it "associates the bid with the auction" do
        expect { 
          valid_bid
        }.to change { auction.bids.count }.by(1)
      end
      it "sets current price to the bid price + 1" do
        valid_bid
        auction.reload
        expect(auction.current_price).to eq 101
      end
      it "redirects to auction after successful save to db" do
        valid_bid
        expect(response).to redirect_to(auction)
      end
    end
    # context "the auction creator bids on his/her own auction" do
    #   def own_bid
    #     post :create, auction_id: auction.id, user_id: auction.user, bid: { price: 100 }
    #   end
    #   it "doesnt create a bid in db" do
    #     expect { own_bid }.to_not change { Bid.count }
    #   end
    #   it "shows a flash alert message" do
    #     own_bid
    #     redirect_to auction
    #     expect(flash[:alert]).to be 
    #   end
    # end
  end
  
  describe "#destroy" do
    let!(:bid) { create(:bid, auction: auction, user: user, price: 200) } 
    def delete_request
      delete :destroy, id: bid.id, auction_id: bid.auction.id, user_id: bid.user.id 
    end
    it "should destroy the appropriate auction from the db " do
      expect { delete_request }.to change { Bid.count }.by(-1)
    end
    it "should redirect to auction show page" do
      delete_request
      response.should redirect_to(auction)
    end
    it "should set a flash notice msg upon deletion" do
      delete_request
      expect(flash[:alert]).to be
    end
  end
  
end

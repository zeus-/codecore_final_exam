require "spec_helper"

describe Bid do
  
  context "with failed validations" do  
    before do
      @bid = Bid.create
    end
    it "doesnt create a bid w/o a price" do
      expect(@bid).to_not be_valid
    end
    it "shows the bid price presence and numericality error after a failed save" do
      @bid.errors.messages.should have_key(:price)
    end
  end

  context "valid bids" do
    it "belongs to an auction" do
     auction = create(:auction)
     bid = auction.bids.create(price: 5)
     expect(bid.auction_id).to be(auction.id)
    end
  
    it "returns in the scope of recent records first" do
      6.times { create(:bid) }
      expect(Bid.all.limit(5)).to_not include(Bid.last)
    end
  end
end


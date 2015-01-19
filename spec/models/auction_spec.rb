require "spec_helper"

describe Auction do
  context "with failed validations" do
    before do
      @auction = Auction.create
    end
    it "doesnt create an auction w/o a title and a reserve price" do
      expect(@auction).to_not be_valid
    end

    it "shows the title presence error after a failed save" do
      @auction.errors.messages.should have_key(:title)
    end

    it "shows the reserve_price presence and numericality error after a failed save" do
      @auction.errors.messages.should have_key(:reserve_price)
    end
  end
  context "valid auctions" do
    before do
      6.times { create(:auction) } 
    end
    it "set their default current price to 0" do
      expect(Auction.first.current_price).to be 0 
    end  
    
    it "returns in the scope of recent records first" do
      expect(Auction.all.limit(5)).to_not include(Auction.last)
    end
  end
end


require 'spec_helper'
require 'rails_helper'
feature "Creating an auction" do
  let(:user) { create(:user) }
  let(:auction) { create(:auction, user: user) }

  before { login_as(user, scope: :user) }

  it "creates an auction in the db" do
    visit auctions_path
    click_on "New Auction"
    fill_in "Title", with: "Macbook 232323"
    fill_in "Reserve price", with: "100" 
    click_on "Save"
    expect(current_path).to eq auctions_path
    expect(page).to have_text /Macbook 232323/i
  end

  it "doesn't save an auction with empty title", remote: true do
    visit new_auction_path
    fill_in "Title", with: ""
    fill_in "Reserve price", with: "200"
    click_on "Save"
    #screenshot_and_open_image
    expect(page).to have_text /Please correct the form/i
    expect(Auction.count).to eq 0
  end
end

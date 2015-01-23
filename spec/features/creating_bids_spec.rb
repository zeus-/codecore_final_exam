feature "Creating a bid for an auction" do
  
  let(:user1) { create(:user) }
  let(:auction) { create(:auction, user: user1) }
  let(:user2) { create(:user) }

  it "creates a bid in the db", remote: true do
    login_as(user2, scope: :user) 
    visit auction_path(auction)
    fill_in "bid_price", with: "200"
    click_on "bid"
    expect(page).to have_text /200/
  end 
  it "doesnt let a user bid on his/her own auction" do
    login_as(user1, scope: :user)
    visit auction_path(auction)
    fill_in "bid_price", with: "200"
    click_on "bid"
    #save_and_open_page
    expect(page).to have_text /You cant bid on you own auction, fool/i
    expect(Bid.count).to eq(0)
  end
end
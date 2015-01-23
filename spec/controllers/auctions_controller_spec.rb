require 'rails_helper'

describe AuctionsController, :type => :controller do
  
  let(:user) { create(:user) }
  before { sign_in user } 
  
  describe "#index" do
    it "fetches the user's auctions" do
      get :index
      expect(user.auctions).to be
    end
    it "includes all auctions's in the db" do
      auction =  user.auctions.create(title: "hola", reserve_price: 200) 
      get :index
      expect(user.auctions).to include(auction)
    end
    it "renders the index template" do
      get(:index)
      expect(response).to render_template(:index)
    end
    it "gets the recent auctions first" do
      6.times { create(:auction) }
      get :index
      expect((user.auctions).limit(5)).to_not include((user.auctions).last)
    end
  end

  describe "#new" do
    it "assigns a new auction variable" do
      get :new
      expect(assigns(:auction)).to be_a_new(Auction)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
 
  describe "#create" do
    context "with a valid request" do
      def valid_request 
        post :create, auction: { title: "Macbook", reserve_price: 200 }
      end  
      it "creates an auction in the db" do
        expect { valid_request }.to change { Auction.count }.by(1)
      end
      it "should redirect to the auctions#index" do
        valid_request
        expect(response).to redirect_to(auctions_path)
      end
      it "sets a flash msg" do
        valid_request
        expect(flash[:success]).to be 
      end
    end
    context "with an invalid request" do
      def invalid_request 
        post :create, auction: { title: "Hola" }
      end
      it "doesnt create an auction in the db" do
        expect { invalid_request }.to_not change { Auction.count }
      end
      it "should render the new auction page" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    let(:auction) { create(:auction) } 
    it "assigns the auction variable to that of the auction id that's passed" do
        get :show, id: auction.id
        expect(assigns(:auction)).to eq auction
    end
    it "assigns a new bid variable" do
      get :show, id: auction.id
      expect(assigns(:bid)).to be_a_new(Bid)
    end
  end

  describe "#edit" do
     let(:auction) { create(:auction, user: user) } 
     it "assigns the auction variable to that of the auction id that's passed" do
       get :edit, id: auction.id, user_id: user
       expect(assigns(:auction)).to eq auction
     end
  end

  describe "#update" do
    let(:auction) { create(:auction, user: user) }
    def update_request
      patch :update, id: auction.id, auction: { title: "New title" }
    end
    it "updates the appropriate auction with the id that is passed" do
      update_request
      auction.reload
      expect(auction.title).to match /New title/i
    end
    it "redirects to the auction show page after a successful update" do
      update_request
      expect(response).to redirect_to(auction)
    end
    it "sets a flash msg after successful update" do
      update_request
      expect(flash[:notice]).to be
    end
    it "renders the edit template after a failed update" do
      patch :update, id: auction.id, auction: { title: "" }
      expect(response).to render_template(:edit)
    end
  end

  describe "#destroy" do
    let!(:auction) { create(:auction, user: user) } 
    def delete_request
      delete :destroy, id: auction.id
    end
    it "should destroy the appropriate auction from the db " do
      expect { delete_request }.to change { Auction.count }.by(-1)
    end
    it "should redirect to the auctions index after a successful delete" do
      delete_request
      expect(response).to redirect_to(auctions_path)
    end
    it "sets a flash msg after successful deletion" do
      delete_request
      expect(flash[:alert]).to be
    end
  end
  
end

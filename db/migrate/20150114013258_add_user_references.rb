class AddUserReferences < ActiveRecord::Migration
  def change
    add_reference :auctions, :user, index: true
    add_reference :bids, :user, index: true
  end
end

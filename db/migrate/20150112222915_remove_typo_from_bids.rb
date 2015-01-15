class RemoveTypoFromBids < ActiveRecord::Migration
  def change
      remove_reference :bids, index: true
  end
end

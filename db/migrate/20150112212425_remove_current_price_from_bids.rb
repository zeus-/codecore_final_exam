class RemoveCurrentPriceFromBids < ActiveRecord::Migration
  def change
    remove_column :bids, :current_price, :integer
  end
end

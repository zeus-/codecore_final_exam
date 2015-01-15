class RemoveCurrentPriceFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :current_price, :integer
  end
end

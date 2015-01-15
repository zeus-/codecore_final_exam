class AddCurrentPriceToBids < ActiveRecord::Migration
  def change
    add_column :bids, :current_price, :integer
  end
end

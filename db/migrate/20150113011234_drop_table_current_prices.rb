class DropTableCurrentPrices < ActiveRecord::Migration
  def change
   drop_table :current_prices
  end
end

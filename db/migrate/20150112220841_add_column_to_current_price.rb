class AddColumnToCurrentPrice < ActiveRecord::Migration
  def change
    add_column :current_prices, :current_price, :integer
  end
end

class AddReferenceTo < ActiveRecord::Migration
  def change
    add_reference :current_prices, :bid, index: true
  end
end

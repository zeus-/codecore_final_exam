class AddReferencesToCurrentPrices < ActiveRecord::Migration
  def change
      add_reference :bids, index: true
  end
end

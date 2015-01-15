class AddStateToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :state, :string
    add_index :auctions, :state
  end
end

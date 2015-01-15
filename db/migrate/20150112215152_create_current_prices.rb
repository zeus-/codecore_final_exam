class CreateCurrentPrices < ActiveRecord::Migration
  def change
    create_table :current_prices do |t|

      t.timestamps
    end
  end
end

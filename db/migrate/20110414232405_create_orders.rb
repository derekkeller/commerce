class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer       :order
      t.date          :date
      t.boolean       :shipping, :default => false
      t.integer       :revenue
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

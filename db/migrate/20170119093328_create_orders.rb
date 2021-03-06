class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :shipping_address
      t.string :status
      t.decimal :sub_total
      t.decimal :total
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

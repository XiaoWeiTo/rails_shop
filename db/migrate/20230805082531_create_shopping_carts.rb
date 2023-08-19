class CreateShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_carts do |t|
      t.integer :user_id
      t.string :user_uuid
      t.integer :product_id
      t.integer :amount,default: 0
      t.timestamps
    end

    add_index :shopping_carts, [:user_uuid]
    add_index :shopping_carts, [:user_id]
    add_index :shopping_carts, [:product_id]
    #Ex:- add_index("admin_users", "username")
  end
end

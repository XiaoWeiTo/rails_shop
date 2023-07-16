class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :title,comments:"分类名称"
      t.integer :weight,default: 0,comments: "权重"
      t.integer :products_counter,default: 0,comments: "商品数量"
      t.timestamps
    end

    add_index :categories, :title
    #Ex:- add_index("admin_users", "username")
  end
end

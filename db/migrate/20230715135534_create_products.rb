class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :category_id,comments:"分类外键"
      t.string :title,comments:"商品名称"
      t.integer :amount,default: 0,comments:"商品数量"
      t.string :status,default: 'off',comments: "商品状态,未上架，上架"
      t.decimal :msrp, precision: 10, scale: 2,comments: "原价"
      t.decimal :price, precision: 10, scale: 2,comments: "现价"
      t.string :uuid,comments:"商品唯一编号"
      t.string :description,comments: "商品描述"
      t.timestamps
    end

    add_index :products, [:status,:category_id]
    add_index :products, :category_id
    add_index :products, :title
    add_index :products, :uuid
    #Ex:- add_index("admin_users", "username")
  end
end

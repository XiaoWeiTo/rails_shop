class AddAncestryToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
  end
end

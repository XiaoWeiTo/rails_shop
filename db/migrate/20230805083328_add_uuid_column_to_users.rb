class AddUuidColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uuid, :string,:limit =>50
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")

    add_index :users,[:uuid],unique: true

    User.find_each do |user|
      unless user.uuid
        user.uuid = SnowFlake::ID.new(0,0).next_id
        user.save
      end
    end
  end
end

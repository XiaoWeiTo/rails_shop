class Product < ApplicationRecord
    belongs_to :category

    before_create :set_default_uuid

    private
    def set_default_uuid
        self.uuid = SnowFlake::ID.new(0,0).next_id
    end
end

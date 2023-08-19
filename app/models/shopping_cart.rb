class ShoppingCart < ApplicationRecord
    belongs_to :product
    validates :product_id,presence: true
    validates :user_uuid,presence: true
    validates :amount,presence: true
    validates :amount,numericality: { greater_than_or_equal_to: 0, message: "数量必须大于等于0" }


    scope :find_by_user_uuid,->(uuid) { where(user_uuid: uuid) }

    def self.create_or_update! options = {}
        cond = {
            user_uuid: options[:user_uuid],
            product_id: options[:product_id]
        }

        record = where(cond).first
        if record
            
            record.update(options.merge(amount: record.amount + options[:amount]))
        else
            record = create(options)
        end
        record
    end
end

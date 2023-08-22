class Address < ApplicationRecord
    validates :user_id, presence: true, message: "用户不能为空"
    validates :contact_name, presence: true, message: "联系人不能为空",
    validates :cellphone, presence:true, message: "手机号不能为空"
    validates :address, presence:true, message: "详细地址不能为空"
    belongs_to :user

    module AddressType
        User = "user"
        Order = "order"
    end
end

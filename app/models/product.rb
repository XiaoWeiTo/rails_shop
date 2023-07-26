class Product < ApplicationRecord
    belongs_to :category
    before_create :set_default_uuid
    has_many :product_images

    validates :category_id, presence: { message: "分类不能为空" }
    validates :title, presence: { message: "产品名称不能为空"}
    validates :status, inclusion: {in: %w(off on), message: "%{value} is not a valid status"}
    validates :msrp,presence: { message: "市场价不能为空" }
    validates :msrp,numericality: { message: "市场价只能是数值" },if: Proc.new { |product| !product.msrp.blank? }
    validates :price,presence: { message: "价格不能为空" }
    validates :price,numericality: { message: "价格只能是数值" },if: Proc.new { |product| !product.price.blank? }
    validates :amount,presence: { message: "数量不能为空" }
    validates :amount,numericality: { only_integer: true, message: "数量只能是整数" },if: Proc.new { |product| !product.amount.blank? }
    validates :amount,numericality: { greater_than_or_equal_to: 0, message: "数量必须大于等于0" },if: Proc.new { |product| !product.amount.blank? }

    module Status
        On = :on
        Off = :off
    end

    private
    def set_default_uuid
        self.uuid = SnowFlake::ID.new(0,0).next_id
    end
end

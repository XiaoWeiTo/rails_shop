class Category < ApplicationRecord
    has_ancestry
    has_many :products,dependent: :destroy

    validates_presence_of :title,message:"分类名称不能为空"

    before_validation :correct_ancestry

    private

    def correct_ancestry
        self.ancestry = nil if self.ancestry.blank?
    end
end

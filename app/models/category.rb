class Category < ApplicationRecord
    has_ancestry orphan_strategy: :destroy
    has_many :products,dependent: :destroy

    validates_presence_of :title,message:"分类名称不能为空"

    before_validation :correct_ancestry

    def self.group_data
        self.roots.order(weight: :desc).inject([]) do |result,parent|
            row = []
            row << parent
            row << parent.children.order(weight: :desc)
            result << row
        end
    end

    private

    def correct_ancestry
        self.ancestry = nil if self.ancestry.blank?
    end
end

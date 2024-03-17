class Tag < ApplicationRecord
    has_many :taggables, dependent: :destroy
    has_many :photos, through: :taggables

    def distinct_tags
        Tag.where.associated(:taggables)
    end
end

class Tag < ApplicationRecord
    has_many :taggables, dependent: :destroy
    has_many :photos, through: :taggables
end

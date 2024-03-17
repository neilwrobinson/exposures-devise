class Photo < ApplicationRecord
    has_one_attached :image # Using Active Storage
    has_many :taggables, dependent: :destroy
    has_many :tags, through: :taggables
end

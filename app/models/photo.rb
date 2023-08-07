class Photo < ApplicationRecord
    has_one_attached :image
    has_many :taggables, dependent: :destroy
    has_many :tags, through: :taggables
end

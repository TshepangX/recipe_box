class Tag < ApplicationRecord
  has_and_belongs_to_many :recipes, dependent: :destroy
end

class Recipe < ApplicationRecord
  has_and_belongs_to_many :ingredients, dependent: :destroy
  has_and_belongs_to_many :tags, dependent: :destroy
  has_many :ratings, dependent: :destroy

  def average
    ratings.average(:score)
  end

  def self.search_by(search_term)
    self.joins(:ingredients).where(name: search_term)
  end

end 


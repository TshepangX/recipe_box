module AverageCalculator
  extend self
  
   def average(recipe)
       recipe.ratings.average(:score)
   end 
end 
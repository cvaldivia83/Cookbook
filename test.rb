require_relative 'recipe'
require_relative 'cookbook'
require_relative 'view'
require_relative 'controller'

#first tests - before controller was created
# rice = Recipe.new('rice', 'chinese gluey white rice')
# risotto = Recipe.new('risotto', 'italian parmesan risotto')
# repo.add_recipe(risotto)

view = View.new
repo = Cookbook.new('cookbook.csv')
controller = Controller.new(repo, view)

#Test scenarios

#Add 1 recipes
#controller.create_recipe

#Print all recipes
controller.all

# add one more recipe
# controller.create_recipe

#print again
#controller.all

#delete a recipe
controller.destroy_recipe

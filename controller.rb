require_relative 'cookbook'
require_relative 'recipe'

class Controller

  def initialize(cookbook, view)
    @cookbook = cookbook
    @view = View.new
  end

  def all
    recipes = @cookbook.all
    @view.list_all_recipes(recipes)
  end

  def create_recipe
    #ask the user title and description of a recipe
    title = @view.ask_user_for_recipe_title
    description = @view.ask_user_for_recipe_description
    #create a new instance of recipe
    recipe = Recipe.new(title, description)
    #add recipe to the repository (cookbook)
    @cookbook.add_recipe(recipe)
  end

  def destroy_recipe
    #show a list of all recipes
    all
    #ask user for recipe's index
    index = @view.ask_user_for_index
    # delete index - 1 from instance of cookbook
    @cookbook.remove_recipe(index)
  end
end

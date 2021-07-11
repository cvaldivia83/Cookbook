require 'open-uri'
require 'nokogiri'

require_relative 'cookbook'
require_relative 'recipe'
require_relative 'view'

class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def all
    recipes = @cookbook.all
    x = @done ? 'X' : ' '
    @view.list_all_recipes(recipes, x)
  end

  def create_recipe
    # ask the user title and description of a recipe
    title = @view.ask_user_for_recipe_title
    description = @view.ask_user_for_recipe_description
    # Ask user for a recipe rating
    rating = @view.ask_user_for_rating
    # create a new instance of recipe
    recipe = Recipe.new(title, description, rating)
    # add recipe to the repository (cookbook)
    @cookbook.add_recipe(recipe)
  end

  def destroy_recipe
    # show a list of all recipes
    all
    # ask user for recipe's index
    index = @view.ask_user_for_index
    # delete index - 1 from instance of cookbook
    @cookbook.remove_recipe(index)
  end

  def search_recipe
    titles = []
    descriptions = []
    ratings = []
    ingredient = @view.ask_user_for_ingredient
    @view.search_for_ingredient(ingredient)

    url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.card__title').each do |title|
      titles << title.text.strip
    end

    @view.list_ingredient_recipes(titles)

    html_doc.search('.card__summary').each do |description|
      descriptions << description.text.strip
    end

    html_doc.search('.review-star-text').each do |rating|
      ratings << rating.text.strip.slice(/(\d.?\d*)/)
    end

    index = @view.import_recipe
    recipe = Recipe.new(titles[index], descriptions[index], ratings[index])
    @cookbook.add_recipe(recipe)
  end

  def mark_recipe_as_done(index)
    index = @view.ask_user_for_index

  end
end

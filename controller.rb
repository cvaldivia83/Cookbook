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
    @view.list_all_recipes(recipes)
  end

  def create_recipe
    # ask the user title and description of a recipe
    title = @view.ask_user_for_recipe_title
    description = @view.ask_user_for_recipe_description
    # Ask user for a recipe rating
    rating = @view.ask_user_for_rating
    # Ask user for prep time
    prep_time = @view.ask_user_for_prep_time
    # create a new instance of recipe
    recipe = Recipe.new(title, description, rating, prep_time)
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
    title = []
    description = []
    ratings = []
    href = []
    prep_time = ''
    ingredient = @view.ask_user_for_ingredient
    @view.search_for_ingredient(ingredient)

    url = "https://www.allrecipes.com/search/results/?search=#{ingredient}"
    html_file = URI.open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.card__detailsContainer').each do |element|
      title << element.search('.card__title').first.text.strip
      description << element.search('.card__summary').first.text.strip
      ratings << element.search('.review-star-text').text.strip.slice(/(\d.?\d*)/)
      href << element.search('.card__titleLink').first.attribute('href').value
    end

    @view.list_ingredient_recipes(title)

    index = @view.import_recipe

    new_url = href[index]
    html = URI.open(new_url).read
    new_doc = Nokogiri::HTML(html)

    new_doc.search('.recipe-meta-item').each do |element|
      if element.search('.recipe-meta-item-header').first.text.strip == 'total:'
        prep_time = element.search('.recipe-meta-item-body').first.text.strip
      end
    end

    recipe = Recipe.new(title[index], description[index], ratings[index], prep_time)
    @cookbook.add_recipe(recipe)
  end

  def mark_recipe_as_done
    recipe_index = @view.ask_user_for_recipe_index
    recipe = @cookbook.find_recipe(recipe_index)
    recipe.mark_as_done
  end
end

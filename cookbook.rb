require 'csv'
require_relative 'recipe'

class Cookbook
  attr_accessor :recipes
  def initialize(csv_file_path)
    @file_path = csv_file_path
    @recipes = []
    @csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
    load_csv(@file_path)
  end

  def load_csv(filepath)
    CSV.foreach(filepath) do |row|
      # Here, row is an array of columns
      @recipes << Recipe.new(row[0], row[1])
    end
  end

  def save_recipe
    CSV.open(@file_path, 'wb', @csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_recipe
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_recipe
  end

end

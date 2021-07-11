require_relative 'cookbook'

class View

  def ask_user_for_recipe_title
    puts 'What is the title of your recipe?'
    print '> '
    gets.chomp
  end

  def ask_user_for_recipe_description
    puts 'What is the description of your recipe?'
    print '> '
    gets.chomp
  end

  def ask_user_for_rating
    puts 'What is the rating of this recipe? (From 1 to 5)'
    print '> '
    gets.chomp
  end

  def ask_user_for_index
    puts 'Which recipe would you like to delete?'
    print '> '
    gets.chomp.to_i - 1
  end

  def list_all_recipes(recipes, x)
    puts '-- Here are all your recipes --'
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. [x] #{recipe.name} - #{recipe.description} - #{recipe.rating}"
    end
  end

  def ask_user_for_ingredient
    puts 'What is the ingredient of this new recipe?'
    print '> '
    gets.chomp
  end

  def search_for_ingredient(ingredient)
    puts "Looking for #{ingredient} recipes in the Internet..."
    print '> '
  end

  def list_ingredient_recipes(titles)
    titles.each_with_index do |title, index|
      puts "#{index + 1} - #{title}"
    end
  end

  def import_recipe
    puts 'Which recipe would you like to import? (Type the index)'
    print '> '
    gets.chomp.to_i - 1
  end
end

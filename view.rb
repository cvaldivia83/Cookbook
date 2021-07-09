require_relative 'cookbook'

class View

  def ask_user_for_recipe_title
    puts "What is the title of your recipe?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_recipe_description
    puts "What is the description of your recipe?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_index
    puts "Which recipe would you like to delete?"
    print "> "
    return gets.chomp.to_i - 1
  end

  def list_all_recipes(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name} - #{recipe.description}"
    end
  end
end

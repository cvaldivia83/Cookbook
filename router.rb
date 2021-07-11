class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    puts "Welcome to Carla's Cookbook!"
    puts '           --           '
    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

    private

    def route_action(action)
      case action
      when 1 then @controller.all
      when 2 then @controller.create_recipe
      when 3 then @controller.destroy_recipe
      when 4 then @controller.search_recipe
      when 5 then @controller.mark_recipe_as_done
      when 6 then stop
      else
        puts 'Please, press 1, 2, 3, 4, 5 or 6'
      end
    end

    def stop
      @running = false
    end

    def display_tasks
      puts '--                    --'
      puts 'What do you want to do next?'
      puts '1 - List all recipes'
      puts '2 - Add a new recipe'
      puts '3 - Delete a recipe'
      puts '4 - Import recipes from the Internet'
      puts '5 - Mark a recipe as done'
      puts '6 - Exit the program'
    end
end

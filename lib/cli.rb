class CLI

    def initialize
        @users = []
    end

    def welcome
        puts "*--*--*--*--*-*-*--*--*--*--*"
        puts "Welcome to the Dream Journal."
        puts "*--*--*--*--*-*-*--*--*--*--*"
    end

    def log_in
        welcome
        puts "Please enter your name:"
        name = gets.chomp
        curr_user = find_or_create_by_name(name)
        @users << curr_user
    end

    def user
        @users[0]
    end

    def find_or_create_by_name(name)
        Person.find_by(name: name) || Person.create(name: name)
    end

    def action
        loop do
            main_menu
            choice = gets.chomp
            case choice
            when "new"
                create_entry
            when "list"
                select_list
            when "update"

            when "delete"

            when "exit"
                puts "Get a good night's sleep :)"
                exit
            end
        end
    end

    def main_menu
    
    puts "What would you like to do?"
    puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
    puts "[new] Make a new dream entry"
    puts "[list] List past entries"
    puts "[update] Update a dream entry"
    puts "[delete] Delete dream entry"
    puts "[exit] Exit program"
    puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"

    end

    def category_menu
        puts "*-*-*-*-*-*-*-*-*-*-*"
        puts "[1] Normal Dream"
        puts "[2] Nightmare"
        puts "[3] Lucid Dream"
        puts "[4] False Awakening"
        puts "*-*-*-*-*-*-*-*-*-*-*"
    end

    def select_category
        puts "Select a category"
        loop do
            category_menu
            choice = gets.chomp
            case choice
            when "1"
                return "Normal Dream"
            when "2"
                return "Nightmare"
            when "3"
                return "Lucid Dream"
            when "4"
                return "False Awakening"
            else
                puts "Please select a valid category"
            end
        end
    end

    def get_remembrance
        loop do
            puts "How much do you remember? (Out of 100)"
            remembrance = gets.chomp
            return remembrance if /\A\d+\z/.match(remembrance) && remembrance.to_i <= 100
        end
    end

    def get_description
        puts "Tell me all about your dream!"
        story = gets.chomp
        story
    end

    def hours_slept?
        loop do
            puts "How many hours did you sleep?"
            hours = gets.chomp
            return hours if /\A\d+\z/.match(hours)
        end
    end

    def recurring?
        loop do
            puts "Is this a recurring dream?"
            answer = gets.chomp
            case answer
            when 'yes', 'y'
                return true
            when 'no', 'n'
                return false
            else
                puts "yes/y : no/n"
            end
        end
    end

    def create_entry
        dream_params = {}
        dream_params[:category] = select_category
        dream_params[:remembrance] = get_remembrance.to_i
        dream_params[:person_id] = self.user.id
        new_dream = Dream.create(dream_params)

        entry_params = {}
        entry_params[:date] = Date.today
        entry_params[:description] = get_description
        entry_params[:hours_slept] = hours_slept?
        entry_params[:recurring] = recurring?
        entry_params[:dream_id] = new_dream.id
        new_entry = Entry.create(entry_params)
        puts "Thank you! Your entry has been successfully saved."
    end

    def list_menu
        puts "List which entries?"
        puts "*-*-*-*-*-*-*-*-*-*-*"
        puts "[a] All dreams"
        puts "[1] Normal dreams"
        puts "[2] Nightmares"
        puts "[3] Lucid dreams"
        puts "[4] False awakenings"
        puts "[5] Recurring dreams"
        puts "[6] Dreams from minimal sleep"
        puts "*-*-*-*-*-*-*-*-*-*-*"
    end

    def select_list
        loop do
            list_menu
            choice = gets.chomp
            case choice
            when "a"
                puts self.user.entries
            end
        end
    end
end
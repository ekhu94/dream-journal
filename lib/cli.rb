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
        puts
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
                puts
                puts "Get a good night's sleep :)"
                exit
            end
        end
    end

    def main_menu
    
        puts
        puts "What would you like to do?"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "[new] Make a new dream entry"
        puts "[list] List past entries"
        puts "[update] Update a dream entry"
        puts "[delete] Delete dream entry"
        puts "[exit] Exit program"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts

    end

    def category_menu
        puts
        puts "*-*-*-*-*-*-*-*-*-*-*"
        puts "[1] Normal Dream"
        puts "[2] Nightmare"
        puts "[3] Lucid Dream"
        puts "[4] False Awakening"
        puts "*-*-*-*-*-*-*-*-*-*-*"
        puts
    end

    def select_category
        puts "Select a category"
        puts
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
            return remembrance.to_i if /\A\d+\z/.match(remembrance) && remembrance.to_i <= 100
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
            return hours.to_i
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

    def num_entries
        loop do
            puts "How many separate instances do you remember in this dream?"
            num = gets.chomp
            return num.to_i if /\A\d+\z/.match(num)
        end
    end

    def create_entry
        dream_params = {}
        dream_params[:hours_slept] = hours_slept?
        dream_params[:person_id] = self.user.id
        new_dream = Dream.create(dream_params)

        num = num_entries

        num.times do
            entry_params = {}
            entry_params[:date] = DateTime.now
            entry_params[:category] = select_category
            entry_params[:remembrance] = get_remembrance
            entry_params[:description] = get_description
            entry_params[:recurring] = recurring?
            entry_params[:dream_id] = new_dream.id
            new_entry = Entry.create(entry_params)
            new_dream.save
        end
        puts "Thank you! Your entry has been successfully saved."
        puts
    end

    def list_menu
        puts
        puts "List which entries?"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts "[a] All dreams"
        puts "[1] By category"
        puts "[2] Recurring"
        puts "[3] By date"
        puts "[4] Had minimal sleep"
        puts "[5] Had sufficient sleep"
        puts "[q] Back to main menu"
        puts "*-*-*-*-*-*-*-*-*-*-*-*-*"
        puts
    end

    def print_entries(entries)
        entries.each do |entry|
            puts
            puts "ID: #{entry[:id]}"
            puts "Date: #{entry[:date].strftime('%H:%M %B %e, %Y')}"
            puts "Type: #{entry[:category]}"
            puts "Dream: #{entry[:description]}"
            puts "Recurring: #{entry[:recurring] ? "Yes" : "No"}"
            puts "Hours slept: #{entry.dream[:hours_slept]}"
            puts
        end
    end

    def select_list
        loop do
            if self.user.entries.length == 0
                puts
                puts "You have no entries yet!"
                puts
                break
            end
            list_menu
            choice = gets.chomp
            case choice
            when "a"
                print_entries(self.user.entries)
                break
            when "1"
                picked_category = select_category
                print_entries(self.user.entries.where(category: picked_category))
                break
            when "2"
                print_entries(self.user.entries.where(recurring: true))
                break
            end
        end
    end
end
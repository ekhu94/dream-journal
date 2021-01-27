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
        puts
        puts "Welcome #{self.user.name}."
    end

    def user
        @users[0]
    end

    def find_or_create_by_name(name)
        User.find_by(name: name) || User.create(name: name)
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
                puts "Goodbye! Have a good night's sleep :)"
                puts
                exit
            end
        end
    end

    def main_menu
    
        puts "What would you like to do?"
        puts
        puts "*--*--*--*--*--*--*--*--*--*--*"
        puts "[new] Make a new dream entry"
        puts "[list] List past entries"
        puts "[update] Update a dream entry"
        puts "[delete] Delete dream entry"
        puts "[exit] Exit program"
        puts "*--*--*--*--*--*--*--*--*--*--*"
        puts

    end

    def category_menu
        puts
        puts "*--*--*--*--*--*--*--*"
        puts "[1] Normal Dream"
        puts "[2] Nightmare"
        puts "[3] Lucid Dream"
        puts "[4] False Awakening"
        puts "*--*--*--*--*--*--*--*"
        puts
    end

    def select_category(i)
        num = ""
        case i
        when 1
            num = "1st"
        when 2
            num = "2nd"
        when 3
            num = "3rd"
        else
            num = i.to_s + "th"
        end
        puts
        puts "Select a category for the #{num} entry:"
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
                puts
                puts "Please select a valid category"
            end
        end
    end

    def get_remembrance
        loop do
            puts "How much do you remember? (% out of 100)"
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
        dream_params[:user_id] = self.user.id
        new_dream = Dream.create(dream_params)

        num = num_entries
        i = 0
        while i < num do
            entry_params = {}
            entry_params[:date] = DateTime.now
            entry_params[:category] = select_category(i + 1)
            entry_params[:remembrance] = get_remembrance
            entry_params[:description] = get_description
            entry_params[:recurring] = recurring?
            entry_params[:dream_id] = new_dream.id
            new_entry = Entry.create(entry_params)
            new_dream.save
            i += 1
        end
        self.user.save
        puts
        puts "Thank you! Your entry has been successfully saved."
        puts
    end

    def list_menu
        puts
        puts "List which entries?"
        puts "*--*--*--*--*--*--*--*--*"
        puts "[a] All dreams"
        puts "[1] By category"
        puts "[2] Recurring" 
        puts "[3] By date" #todo
        puts "[4] Had minimal sleep"
        puts "[5] Had sufficient sleep" #todo
        puts "[q] Back to main menu" #todo
        puts "*--*--*--*--*--*--*--*--*"
        puts
    end

    def print_entries(entries)
        puts
        puts "*--*--* ENTRIES LIST *--*--*"
        entries.each do |entry|
            puts
            puts "ID: #{entry[:id]}"
            puts "Date: #{entry[:date].strftime('%H:%M %B %e, %Y')}"
            puts "Type: #{entry[:category]}"
            puts "Discription: #{entry[:description]}"
            puts "Recurring: #{entry[:recurring] ? "Yes" : "No"}"
            puts "Hours slept: #{entry.dream[:hours_slept]}"
            puts "I remembered #{entry[:remembrance]}% of this dream."
            puts
        end
        puts "*--*--*--*--*--*--*--*--*--*"
        puts
    end

    def get_entries_by_hours_slept(min, max=100)
        dreams_arr = Dream.where("hours_slept < ? AND hours_slept >= ?", max, min)
        dreams_arr.map { |dream| dream.entries }.flatten
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
            when "4"
                print_entries(get_entries_by_hours_slept(0, 4))
                break
            end
        end
    end
end
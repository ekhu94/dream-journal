class CLI

    def initialize
        @users = []
    end

    def user
        @users[0]
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
                update_entry
            when "delete"
                delete_entry
            when "exit"
                puts
                puts "Goodbye. Hope you sleep well!"
                puts
                exit
            end
        end
    end

    # NEW ENTRY METHODS AND PARAM-SETTERS

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
            i += 1
        end
        self.user.save
        puts
        puts "Thank you! Your entry has been successfully saved."
        puts
    end

    def hours_slept?
        loop do
            puts "How many hours did you sleep?"
            hours = gets.chomp
            return hours.to_i
        end
    end

    def num_entries
        loop do
            puts "How many separate instances do you remember in this dream?"
            num = gets.chomp
            return num.to_i if /\A\d+\z/.match(num)
        end
    end

    def select_category(i=nil)
        if i.nil?
            puts
            puts "Select a category"
        else
            print_entry_num(i)
        end
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

    # END OF NEW ENTRY METHODS AND PARAM-SETTERS

    # LIST AND READER METHODS

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
                print_dreams(self.user.dreams)
                break
            when "1"
                picked_category = select_category
                entries = self.user.entries.where(category: picked_category)
                print_dreams(self.user.dreams, entries)
                break
            when "2"
                entries = self.user.entries.where(recurring: true)
                print_dreams(self.user.dreams, entries)
                break
            when "3"
                
            when "4"
                dreams_arr = self.user.dreams.where("hours_slept < ? AND hours_slept >= ?", 5, 0)
                print_dreams(dreams_arr)
                break
            when "5"
                dreams_arr = self.user.dreams.where("hours_slept < ? AND hours_slept >= ?", 20, 5)
                print_dreams(dreams_arr)
                break
            when "q"
                break
            end
        end
    end

    # def get_entries_by_hours_slept(min, max=100)
    #     dreams_arr = self.user.dreams.where("hours_slept < ? AND hours_slept >= ?", max, min)
    #     dreams_arr.map { |dream| dream.entries }.flatten
    # end


    # def get_entries_by_id
    #     puts "Please enter an ID Entry number: "
    #     ans = gets.chomp 
    #     Entry.find(id = ans)
    #     # dream.entries.find_by(id: )
    #     #if entry.date is equal to answer. return entry 
    #     # User.first.entries.where("date = ") = gives user id
    #     #Entry.first.date = gives first date
    #     #Entry.first = gives instance of entry 
    #     #find by id (ans) - return list of dreams with entries that match id 
    #  end

    # END OF LIST AND READER METHODS

    # UPDATE METHODS

    def update_entry
        update_menu
        choice = gets.chomp
        loop do
            case choice
            when "id"
                update_by_id
                break
            when "all"
                update_by_all
                break
            when "q"
                break
            else
                puts "Please choose a valid command."
                choice = gets.chomp
            end
        end
    end

    def update_by_id
        print_dreams(self.user.dreams)
        puts
        puts "Type in the ID of the Dream you would like to update."
        selected_id = gets.chomp
        while !/\A\d+\z/.match(selected_id) || !self.user.dreams.find_by(id: selected_id.to_i)
            puts "Please enter a valid dream ID"
            selected_id = gets.chomp
        end
        dream = self.user.dreams.find_by(id: selected_id.to_i)
        attr_menu
        loop do
            selected_attr = gets.chomp
            case selected_attr
            when "1"
                entry = find_by_entry(dream)
                entry[:category] = select_category
                entry.save
                puts
                puts "You have successfully updated the category!"
                break
            when "2"
                entry = find_by_entry(dream)
                entry[:remembrance] = get_remembrance
                entry.save
                puts
                puts "You have successfuly updated the remembrance!"
                break
            when "3"
                entry = find_by_entry(dream)
                entry[:description] = get_description
                entry.save
                puts
                puts "You have successfuly updated the description!"
                break
            when "4"
                entry = find_by_entry(dream)
                entry[:recurring] = recurring?
                entry.save
                puts
                puts "You have successfuly updated the recurrance!"
                break
            when "5"
                dream[:hours_slept] = hours_slept?
                dream.save
                puts
                puts "You have successfully update the hours slept!"
                break
            when "q"
                break
            else
                puts "Please choose a valid command."
                selected_attr = gets.chomp
            end
        end 
    end

    def update_by_all
        attr_menu
        loop do
            selected_attr = gets.chomp
            case selected_attr
            when "1"
                new_category = select_category
                self.user.dreams.each do |dream|
                    dream.entries.each do |entry| 
                        entry[:category] = new_category
                        entry.save
                    end
                end
                puts
                puts "You have successfully updated all categories!"
                break
            when "2"
                new_remembrance = get_remembrance
                self.user.dreams.each do |dream|
                    dream.entries.each do |entry| 
                        entry[:remembrance] = new_remembrance
                        entry.save
                    end
                end
                puts
                puts "You have successfuly updated all remembrances!"
                break
            when "3"
                new_description = get_description
                self.user.dreams.each do |dream|
                    dream.entries.each do |entry| 
                        entry[:description] = new_description
                        entry.save
                    end
                end
                puts
                puts "You have successfuly updated all descriptions!"
                break
            when "4"
                new_recurrance = recurring?
                self.user.dreams.each do |dream|
                    dream.entries.each do |entry| 
                        entry[:recurring] = new_recurrance
                        entry.save
                    end
                end
                puts
                puts "You have successfuly updated the recurrance!"
                break
            when "5"
                new_hours_slept = hours_slept?
                self.user.dreams.each do |dream|
                    dream[:hours_slept] = new_hours_slept
                    dream.save
                end
                puts
                puts "You have successfully update all hours slept!"
                break
            when "q"
                break
            else
                puts "Please choose a valid command."
                selected_attr = gets.chomp
            end
        end   
    end

    def find_by_entry(dream)
        print_entries(dream.entries)
        puts
        puts "Type in the ID of the Entry you would like to update"
        selected_id = gets.chomp
        while !/\A\d+\z/.match(selected_id) || !dream.entries.find_by(id: selected_id.to_i)
            puts "Please enter a valid Entry ID"
            selected_id = gets.chomp
        end
        dream.entries.find_by(id: selected_id.to_i)
    end

    # END OF UPDATE METHODS

    # DELETE METHODS

    def delete_entry
        delete_menu
        choice = gets.chomp
        loop do
            case choice
            when "id"
                delete_by_id
                break
            when "all"
                delete_by_all
                break
            when "q"
                break
            end
        end
    end

    def delete_by_id
        print_dreams(self.user.dreams)
        puts
        puts "Type in the ID of the dream you would like to delete."
        selected_id = gets.chomp
        while !/\A\d+\z/.match(selected_id) || !self.user.dreams.find_by(id: selected_id.to_i)
            puts "Please enter a valid dream ID"
            selected_id = gets.chomp
        end
        puts
        puts "Are you sure you want to delete this dream and all its entries?"
        loop do
            confirm = gets.chomp
            case confirm
            when "yes", "y"
                self.user.dreams.destroy_by(id: selected_id.to_i)
                puts
                puts "Dream ##{selected_id.to_i} has been deleted!"
                self.user.save
                break
            when "no", "n"
                break
            end
        end
    end

    def delete_by_all
        puts
        puts "Are you sure you want to delete all entries? THIS CANNOT BE UNDONE!"
        loop do
            confirm = gets.chomp
            case confirm
            when "yes", "y"
                Entry.destroy_by(user_id: self.user.id)
                puts
                puts "All of #{self.user.name}'s entries have been deleted!"
                self.user.save
                break
            when "no", "n"
                break
            end
        end
    end

    # END OF DELETE METHODS

    # PRINT METHODS

    def print_dreams(dreams, entries=nil)
        puts
        puts "*--*--*--* DREAMS LIST *--*--*--*"
        puts
        dreams.each do |dream|
            if entries.nil?
                puts
                puts "*--*--*--* Dream ID #{dream.id} *--*--*--*"
                print_entries(dream.entries)
                puts
            else
                if entries.length != 0
                    puts
                    puts "*--*--*--* Dream ID #{dream.id} *--*--*--*"
                    print_entries(entries)
                    puts
                else
                    puts "No dreams were found \nmatching that description."
                    puts
                end
            end
        end
        puts "*--*--*--*--*--*--*--*--*--*--*--*"
    end

    def print_entries(entries)
        entries.each do |entry|
            puts
            puts "Entry ID ##{entry[:id]}"
            puts "Date: #{entry[:date].strftime('%H:%M %B %e, %Y')}"
            puts "Type: #{entry[:category]}"
            puts "Discription: #{entry[:description]}"
            puts "Recurring: #{entry[:recurring] ? "Yes" : "No"}"
            puts "Hours slept: #{entry.dream[:hours_slept]}"
            puts "I remembered #{entry[:remembrance]}% of this dream."
            puts
        end
    end

    def print_entry_num(i)
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
    end

     # END OF PRINT METHODS

     # PRINT MENUS

    def welcome
        puts "*--*--*--*--*-*-*--*--*--*--*"
        puts "Welcome to the Dream Journal."
        puts "*--*--*--*--*-*-*--*--*--*--*"
    end

    def main_menu
        puts
        puts "What would you like to do?"
        puts "*--*--*--*--*--*--*--*--*--*--*"
        puts "[new] Make a new dream entry"
        puts "[list] List past entries"
        puts "[update] Update a dream entry"
        puts "[delete] Delete dream entry"
        puts "[exit] Exit program"
        puts "*--*--*--*--*--*--*--*--*--*--*"
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
        puts "[5] Had sufficient sleep"
        puts "[q] Back to main menu"
        puts "*--*--*--*--*--*--*--*--*"
        puts
    end

    def update_menu
        puts
        puts "Select a method for updating"
        puts "*--*--*--*--*--*--*--*--*"
        puts "[id] By ID number"
        puts "[all] All entries"
        puts "[q] Back to main menu"
        puts "*--*--*--*--*--*--*--*--*"
        puts
    end

    def delete_menu
        puts
        puts "Select a method for deleting"
        puts "*--*--*--*--*--*--*--*--*--*"
        puts "[id] By dream ID"
        puts "[all] All dreams"
        puts "[q] Back to main menu"
        puts "*--*--*--*--*--*--*--*--*--*"
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

    def attr_menu
        puts
        puts "What attribute would \nyou like to change?"
        puts "*--*--*--*--*--*--*--*--*"
        puts "[1] Category"
        puts "[2] Remembrance"
        puts "[3] Description"
        puts "[4] Recurring"
        puts "[5] Hours slept"
        puts "[q] Back to main menu"
        puts "*--*--*--*--*--*--*--*--*"
        puts
    end

    # END OF PRINT MENUS

end
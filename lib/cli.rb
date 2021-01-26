class CLI
    def welcome
        puts "*--*--*--*--*-*-*--*--*--*--*"
        puts "Welcome to the Dream Journal."
        puts "*--*--*--*--*-*-*--*--*--*--*"
    end

    def log_in
        welcome
        puts "Please enter your name:"
        name = gets.chomp
        find_or_create_by_name(name)
    end

    def find_or_create_by_name(name)
        Person.find_by(name: name) || Person.create(name: name)
    end
end
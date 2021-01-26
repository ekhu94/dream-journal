require_relative '../config/environment'
require_all '../app/models'

class CLI
    def welcome
        puts "Welcome to your Dream Journal."
    end

    def log_in
        welcome
        puts "Please enter your name:"
        name = gets.chomp
        "Hello #{name}"
    end
end
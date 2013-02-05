require 'rainbow'
require 'csv'
require_relative 'queue'
require_relative 'help'

class CommandPrompt
  def initialize
    @queue = Queue.new
  end

  def run
    loop do 
      puts "Enter your command:".color(:blue)
      command = gets.chomp.downcase.split(" ")
      case command[0]
      when "load" then load_file(command[1].to_s)
      when "help" then help(command)
      when "queue" then run_queue(command)
      when "find" then find(command)
      when "esc" then break ##For some reason it takes two esc to break the loop.
      else puts "Please enter a valid command. Enter 'help' for help or esc to exit."
      end
    end  
  end
  
  def run_queue(input)
      command = input.split(" ")
      case command[1]
      when "count"  
        #output how many records are in the current queue
      when "clear"
        #clear the current queue
      when "print"
        #print out a tab-deliminated data table with a headerrow following this format:
        #LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE
      when "print" #"by <attribute>"
        #print the data sorted by the specified atribute like zipcode
      when "save" #"to <filename.csv>"
        #Export the current queue to the specified filename as a CSV. The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number.
        #also make sure that the filename ends in csv
        #saves as output.csv if nothing is selected
      else
        #do nothing
      end
      puts "The input to run_queue was #{input}. The command was #{command}."
  end

end

manager = CommandPrompt.new()
manager.run
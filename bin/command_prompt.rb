require 'rainbow'
require 'csv'
require_relative '../lib/queue'
require_relative '../lib/help'

class CommandPrompt
  def initialize
    @queue = EventQueue.new
    @help = Help.new
  end

  def run
    loop do 
      puts "Enter your command:".color(:blue)
      command = gets.chomp.downcase.split(" ")
      case command[0]
      when "load" then @queue.load_file(command[1].to_s)
      when "help" then @help.help(command)
      when "queue" then run_queue(command)
      when "find" then @queue.find(command[1..-1])
      when "esc" then break 
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
        #Export the current queue to the specified filename as a CSV. The file should should include data 
        #and headers for last name, first name, email, zipcode, city, state, address, and phone number.
        #also make sure that the filename ends in csv
        #saves as output.csv if nothing is selected
      else
        #do nothing
      end
  end
end

if __FILE__ == $0
  manager = CommandPrompt.new()
  manager.run
end










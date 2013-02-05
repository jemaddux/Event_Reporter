require 'rainbow'
require 'csv'
#require_relative 'queue'
#equire_relative 'help'

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
  end

end

class Queue
  def initialize
    @the_queue = []
  end

  def new_queue
    contents = manager.load_file()
    puts contents
  end

  def find(input)
    puts "find" # <attribute> <criteria>"
      #Load the queue with all records matching the criteria for the given attribute. Example usages:
      #examples
      #find zipcode 20011
      #find last_name Johnson
      #find state VA
      #The comparison should:
      #Be insensitive to case, so "Mary" and "mary" would be found in the same search
      #Be insensitive to internal whitespace, but not external:
      #  "John" and "John " are considered matches
      #  "John Paul" and "Johnpaul" are not matches
      #Not do substring matches, so a find first_name Mary does not find a record with first name "marybeth"
  end
  

  def load_file(filename="event_attendees.csv")
    begin
      contents = CSV.open ("static/"+filename.to_s), headers: true, header_converters: :symbol
      puts contents  
    rescue
      puts "Could not find a file named #{filename.to_s}."
    end
    return contents    #erase any loaded data and parse the specified file.
  end
  
end

class Help
  def help(input)
    #puts the input for some reason???
    if ("" == input[1..-1].join(" "))
      puts "The possible commands are: ".color(:red)
      puts "load <filename> -- help -- queue count -- queue clear -- queue print -- queue print by <attribute> -- queue save to <filename.csv> -- find <attribute> <criteria>"  
    else
      long_help
    end
    puts ""
  end

  def long_help(input)
    puts input
    puts ""
    ##needs and explanation of all the commands
  end
end  

manager = CommandPrompt.new()
manager.run
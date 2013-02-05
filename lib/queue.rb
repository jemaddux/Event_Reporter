require_relative '../bin/command_prompt'
require 'csv'

class EventQueue
  def initialize
    @the_queue = new_queue
  end

  def new_queue
  	@the_queue = []
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

  def load_file(filename="event_attendees.csv")
    begin
      @the_file = CSV.open("event_attendees.csv"), headers: true, header_converters: :symbol
      puts @the_file
    rescue
      puts "Could not find a file named #{filename.to_s}."
    end
  end
end

if __FILE__ == $0
	quely = EventQueue.new()
  quely.load_file
end
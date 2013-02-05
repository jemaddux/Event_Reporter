require_relative '../bin/command_prompt'
require 'csv'
require 'rainbow'

class EventQueue
  def initialize
    @the_queue = new_queue
  end

  def new_queue
  	@the_queue = []
  end

  def find(input)
  	new_queue
  	puts @the_queue
  	puts ""
  	####check to make sure that input[0] is actually a header and if not then provide header options
  	@the_file.each do |line|
      if line[input[0].to_sym].downcase == input[1] 
      	puts "#{line}"
      end
  	end
    #puts "find" # <attribute> <criteria>"
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
      puts input
      puts @the_queue = @the_file
  end

  def load_file(filename="event_attendees.csv")
    begin
      @the_file = CSV.open "lib/"+filename, headers: true, header_converters: :symbol
      #@the_file.each do |line|
      #  puts line
      #end
    rescue
      #puts "Could not find a file named #{filename.to_s}."
    end
  end
end

if __FILE__ == $0
	quely = EventQueue.new()
  quely.load_file
  command = "find first_name john".downcase.split(" ")
  quely.find(command[1..-1])
end

#puts Dir.pwd   - shows your current directory
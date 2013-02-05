require_relative 'command_prompt'

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

quely = Queue.new()
quely.new_queue
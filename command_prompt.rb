require 'rainbow'

class CommandPrompt
  def run
    loop do 
      puts "This is the command prompt."
      puts "Please enter your command:"
      command = gets.chomp.downcase
      case command
      #when #load <filename>
    	  #erase any loaded data and parse the specified file. if no filename is given the default to event_attendees.csv
      when "help"
    	  help
      when "queue count"
    	  #output how many records are in the current queue
      when "queue clear"
    	  #clear the current queue
      when "queue print"
    	  #print out a tab-deliminated data table with a headerrow following this format:
    	  #LAST NAME  FIRST NAME  EMAIL  ZIPCODE  CITY  STATE  ADDRESS  PHONE
      #when #queue print by <attribute>
    	  #print the data sorted by the specified atribute like zipcode
      #when ""
        #----queue save to <filename.csv>
    	  #Export the current queue to the specified filename as a CSV. The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number.
    	  #also make sure that the filename ends in csv
    	  #saves as output.csv if nothing is selected
      #when #find <attribute> <criteria>
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
      when "quit", "exit", "esc"
    	  break
      else
    	  puts "Please enter a valid command. Enter 'help' for help or esc to exit."
      end
      puts ""
    end  
  end

  def help
    puts "The possible commands are: ".color(:red)
    puts "load <filename> ".color(:red) + "- which will load the selected filename into the program"
    puts "help ".color(:red) + "- which shows this help screen"
    puts "queue count ".color(:red)
    puts "   - which will show how many records are in the current queue"
    puts "queue clear ".color(:red) 
    puts "   - which will clear the current queue"
    puts "queue print ".color(:red)
    puts "   - which will display the current queue"
    puts "queue print by <attribute> ".color(:red) 
    puts "   - which will display the queue by the selected attribute"
    puts "queue save to <filename.csv> ".color(:red) 
    puts "   - will save the queue to output.csv by default or as the filename given"
    puts "find <attribute> <criteria> ".color(:red) 
    puts "   - will find all attributes that match the critera, eg all last_name attributes that are Johnson"
    puts ""
  end
end

manager = CommandPrompt.new()
manager.run
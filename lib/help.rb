require_relative '../bin/event_reporter'


class Help
  def initialize
    @helpHash = {
      load: "load - Loads the <filename> specified into memory for searching.",
      find: 'find - Finds items with <criteria> and <attribute>.',
      save: "save <filename.csv> - Saves the queue to <filename.csv>."
    }
  end

  def help(input)
    if ("" == input[1..-1].join(" "))
      puts "The possible commands are: "
      puts "load <filename> -- help -- queue count -- queue clear"
      puts "queue print -- queue print by <attribute>" 
      puts "queue save to <filename.csv> -- find <attribute> <criteria>"  
    else
      long_help(input)
    end
    puts ""
  end

  def long_help(input)
    case input[1]
    when 'load' then puts @helpHash[:load] 
    when 'help' then puts 'help - Displays the possible help items.'
    when 'queue' then queue_help(input)
    when 'find' then puts @helpHash[:find]
    else 
      print "Type 'help' to see a list of possible commands "   
      puts "and find out about them by typing 'find <command>'."
    end
  end

  def queue_help(input)
    case input[2]
    when "count" then puts "count - Displays the # of items in the queue."
    when "clear" then puts "clear - This command clears the current queue."
    when "print"
      if input[3] == "by"
        puts "print by <attribute> - Print the queue sorted by <attribute>."
      else
        puts "print - This command will print the queue."
      end
    when "save" then puts @helpHash[:save]
    else 
      puts "Type 'help' to see possible commands."
    end
  end
  
end  
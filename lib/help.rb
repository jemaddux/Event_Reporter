require_relative '../bin/event_reporter'


class Help
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
    when 'load' then puts "load - This command loads the <filename> specified into memory so that it can be searched."
    when 'help' then puts 'help - This command displays the possible help items.'
    when 'queue' then queue_help(input)
    when 'find' then puts 'find - This command will find items in the loaded file that equal the <criteria> specified in the specified <attribute> and then put them into the queue.'
    else puts "Type 'help' to see a list of possible commands and find out about them by typing 'find <command>'."
    end
  end

  def queue_help(input)
    case input[2]
    when "count" then puts "count - This command displays the number of items in the current queue."
    when "clear" then puts "clear - This command clears the current queue."
    when "print"
      if input[3] == "by"
        puts "print by <attribute> - This command will print the queue sorted by the <attribute> selected."
      else
        puts "print - This command will print the queue."
      end
    when "save" then puts "save <filename.csv> - This command will save the queue to the specified <filename.csv>."
    else puts "Type 'help' to see a list of possible commands and find out about them by typing 'find <command>'."
    end
  end
end  
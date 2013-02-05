require_relative '../bin/command_prompt'


class Help
  def help(input)
    if ("" == input[1..-1].join(" "))
      puts "The possible commands are: ".color(:red)
      puts "load <filename> -- help -- queue count -- queue clear -- queue print -- queue print by <attribute> -- queue save to <filename.csv> -- find <attribute> <criteria>"  
    else
      long_help(input)
    end
    puts ""
  end

  def long_help(input)
    case input[1]
    when 'load' then puts 'load'
    when 'help' then puts 'help'
    when 'queue' then queue_help(input)
    when 'find' then puts 'find'
      #<attribute> <criteria>
    else puts "You gotta put something else."
    end
    ##### not finished
  end

  def queue_help(input)
    case input[2]
    when "count" then puts "Count help"
    when "clear" then puts "Clear help"
    when "print"
      if input[3] == "by"
        #print by <attribute>
      else
        #print
      end
    when "save" then puts "save to <filename.csv>"
    else puts "something else please"
    end
    ###not finished
  end
end  
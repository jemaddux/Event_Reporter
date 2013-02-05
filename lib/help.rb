require_relative 'command_prompt'

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
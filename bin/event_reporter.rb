require 'csv'
require_relative '../lib/queue'
require_relative '../lib/help'

class EventReporter
  def initialize
    @event_queue = EventQueue.new
    @help = Help.new
  end

  def run
    loop do 
      puts "Enter your command:"
      command = gets.chomp.downcase.split(" ")
      case command[0]
      when "load" then @event_queue.load(command[1].to_s)
      when "help" then @help.help(command)
      when "queue" then run_queue(command)
      when "find" then @event_queue.find(command[1..-1])
      when "esc" then break 
      else puts "Please enter a valid command. Enter 'help' for help or esc to exit."
      end
    end  
  end

  def run_queue(input)
      command = input.split(" ")
      case command[1]
      when "count"  
        @event_queue.count_q
      when "clear"
        @event_queue.clear_q
      when "print"
        @event_queue.print_q
      when "print" #"by <attribute>"
        #print the data sorted by the specified atribute like zipcode
      when "save" 
        @event_queue.save_to_file(command[2])
      else
        #do nothing
      end
  end
end

if __FILE__ == $0
  reporter = EventReporter.new()
  reporter.run
end









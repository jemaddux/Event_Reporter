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
      when "load" then @event_queue.load(command[1])
      when "help" then @help.help(command)
      when "queue" then run_queue(command)
      when "find" then @event_queue.find(command[1..-1])
      when "esc","quit" then break 
      else puts "Enter a valid command. Enter 'help' for help or esc to exit."
      end
    end  
  end

  def run_queue(input)
    command = input
    case command[1]
    when "count" then @event_queue.count_q
    when "clear" then @event_queue.clear_q
    when "print"
      case_print(command)
    when "save" 
      @event_queue.save_to_file(command)
    else
      puts "Enter a valid command. Enter 'help' for help or esc to exit."
    end
  end

  def case_print(command)
    if command[2] == "by" 
      @event_queue.print_by(command[3].to_s)
    else
      @event_queue.print_q
    end
  end
end

if __FILE__ == $0
  reporter = EventReporter.new()
  reporter.run
end










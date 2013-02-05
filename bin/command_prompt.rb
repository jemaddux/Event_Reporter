require 'rainbow'
require 'csv'
require_relative '../lib/queue'
require_relative '../lib/help'

class CommandPrompt
  def initialize
    @queue = EventQueue.new
    @help = Help.new
  end

  def run
    loop do 
      puts "Enter your command:".color(:blue)
      command = gets.chomp.downcase.split(" ")
      case command[0]
      when "load" then @queue.load_file(command[1].to_s)
      when "help" then @help.help(command)
      when "queue" then @queue.run_queue(command)
      when "find" then @queue.find(command)
      when "esc" then break 
      else puts "Please enter a valid command. Enter 'help' for help or esc to exit."
      end
    end  
  end
end

if __FILE__ == $0
  manager = CommandPrompt.new()
  manager.run
end










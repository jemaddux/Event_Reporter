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
  	@the_file = load_file ###might have a problem with multiple queues if the filename isn't the default
  	####check to make sure that input[0] is actually a header and if not then provide header options
  	@the_file.each do |line|
      if line[input[0].to_sym].downcase == input[1]
      	@the_queue.push(line)
      end
  	end
    puts "Find done. #{@the_queue.count} results found. Use 'queue print' to view them."
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
  10.times do
    quely.find(command[1..-1])
  end
end

#puts Dir.pwd   - shows your current directory
require_relative '../bin/command_prompt'
require 'csv'
require 'rainbow'

class EventQueue
  def initialize
    @the_queue = new_queue
    @the_file = []
    @keys = {id: 0, regdate: 1, first_name: 2, last_name: 3, email_address: 4, homephone: 5, street: 6, city: 7, state: 8, zipcode: 9}
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
    	puts Dir.pwd
      temp_var = CSV.open filename, headers: false#, header_converters: :symbol
      temp_var.each do |line|
        @the_file.push(line)  
      end
    rescue
    	#fail silently
    end
  end

  def print
  	puts ""
  	puts "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
  	5.times do |x|
      items2 = @the_queue[x].to_s.split(',')
      items2.each {|x| puts x}
      puts ""
      # items2 = items.join(" ")
      
      #puts "#{items[:last_name]}\t#{items[:first_name]}\t#{items[:email_address]}\t#{items[:zipcode]}\t#{items[:city]}\t#{items[:state]}\t#{items[:street]}\t#{items[:homephone]}"
      
      # ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode
  	end

  	#  <--- tab delimited
  end

end

if __FILE__ == $0
	quely = EventQueue.new()
  quely.load_file
end

#puts Dir.pwd   - shows your current directory
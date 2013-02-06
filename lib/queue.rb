require_relative '../bin/command_prompt'
require 'csv'
require 'rainbow'


class EventQueue
  include Enumerable 

  def initialize #int 1
    @the_queue = [] #int 1
    @the_file = [] #int 1
    @keys = {id: 0, regdate: 1, first_name: 2, last_name: 3, email_address: 4, homephone: 5, street: 6, city: 7, state: 8, zipcode: 9} #int 1
    @queue = []
    @file = []
  end

  def clear_q
    @queue = []
  end

  def find(input) 
    @queue = []
    key, query = input[0], input[1]
    @file.each do |y|
      if y[key.to_sym] == query
        @queue.push(y)
      end
    end
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

  def load(filename="event_attendees.csv")
    @file = []
    tempfile = CSV.open (Dir.pwd+"/"+filename), headers: true, header_converters: :symbol
    tempfile.each do |row|
      entry = {}
      entry[:first_name] = row[:first_name]
      entry[:last_name] = row[:last_name]
      entry[:email] = row[:email_address]
      entry[:phone] = row[:homephone]
      entry[:address] = row[:street]
      entry[:city] = row[:city]
      entry[:state] = row[:state]
      entry[:zipcode] = row[:zipcode]
      @file.push(entry)
    end 
    #puts @file
  end

  def print_q  #not done still need to really be @queue
  	puts ""
  	puts "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
    #@queue = @file
    @queue.each do |x|
      print "#{x[:last_name].ljust(15,".")}    "
      print "#{x[:first_name].ljust(15,".")}    "
      print "#{x[:email].ljust(45,".")}    "
      print "#{x[:zipcode]}         \t"
      print "#{x[:city]}\t"
      print "#{x[:state]}\t"
      print "#{x[:address]}\t"
      puts "#{x[:phone]}\t"
    end
  end

  def count_q
    puts ""
    puts "There are #{@queue.count} items in your queue."
  end
end

if __FILE__ == $0
	quely = EventQueue.new()
  quely.load
  command = "find first_name John".split(" ")
  quely.find(command[1..-1])
  quely.print_q
  quely.count_q
end

#puts Dir.pwd   - shows your current directory















require_relative '../bin/event_reporter'
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

  def load(filename="event_attendees.csv")
    @file = []
    contents = CSV.open ("lib/"+filename), headers: true, header_converters: :symbol
    CSV.foreach("lib/event_attendees.csv") do |row|
      entry = {}
      entry[:first_name] = row[2]
      entry[:last_name] = row[1]
      entry[:email] = row[3]
      entry[:phone] = row[4]
      entry[:address] = row[5]
      entry[:city] = row[6]
      entry[:state] = row[7]
      entry[:zipcode] = row[8]
      @file.push(entry)
    end 
    @file = @file[1..-1]
    puts "File loaded. #{@file.length} records loaded."
    #,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode
  end

  def print_q
  	puts ""
  	puts "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
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

  def queue_print_by(input)
    ##input is the attribute
    @queue = @queue.sort_by{|item| item[input.downcase.to_sym].downcase}
    print_q
  end

  def save_to_file(filename="output.csv")
    CSV.open(filename, "w") do |csv|
      csv << ["last_name","first_name","email","zipcode","city","state","address","phone"]
      @queue.each do |q|
        csv << [q[:last_name],q[:first_name],q[:email],q[:zipcode],q[:city],q[:state],q[:address],q[:phone]]
      end
    end   
  end
  #last name, first name, email, zipcode, city, state, address, and phone number.

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
  quely.queue_print_by("zipcode")
  quely.save_to_file()
end

#puts Dir.pwd   - shows your current directory















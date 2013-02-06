require_relative '../bin/event_reporter'
require 'csv'
require 'rainbow'


class EventQueue
  include Enumerable 

  def initialize 
    @queue = []
    @file = []
  end

  def clear_q
    @queue = []
    puts "The queue is now empty."
    puts count_q
  end

  def find(input) 
    @queue = []
    key, query = input[0], input[1]
    @file.each do |y|
      if y[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
        @queue.push(y)
      end
    end
    count_q
    puts "All items added to queue for <attribute> #{key} and <criteria> #{query}."
    puts "Enter 'queue print' to see your queue."
  end

  def load(filename="event_attendees.csv")
    @file = []
    if filename == nil
      filename = "event_attendees.csv"
    end
    contents = CSV.open ("output/"+filename), headers: true, header_converters: :symbol
    CSV.foreach("output/"+filename) do |row|
      entry = {}
      entry[:id] = row[0]
      entry[:regdate] = row[1]
      entry[:first_name] = row[2]
      entry[:last_name] = row[3]
      entry[:email] = row[4]
      entry[:phone] = row[5]
      entry[:address] = row[6]
      entry[:city] = row[7]
      entry[:state] = row[8]
      entry[:zipcode] = row[9]
      @file.push(entry)
    end 
    @file = @file[1..-1]
    puts "File loaded. #{@file.length} records loaded."
    #0,1-RegDate,2-first_Name,3-last_Name,4-Email_Address,5-HomePhone,6-Street,7-City,8-State,9-Zipcode
  end

  def print_q
  	puts ""
  	puts "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
    @queue.each do |x|
      print "#{x[:last_name]}\t"
      print "#{x[:first_name]}\t"
      print "#{x[:email]}\t"
      print "#{x[:zipcode]}\t"
      print "#{x[:city]}\t"
      print "#{x[:state]}\t"
      print "#{x[:address]}\t"
      puts "#{x[:phone]}\t"
    end
  end

  def print_by(input)
    ##input is the attribute
    @queue = @queue.sort_by{|item| item[input.downcase.to_sym].downcase}
    print_q
  end

  def save_to_file(input="output.csv")
    if input[3] == nil
      filename = "output/output.csv"
    else
      filename = "output/#{input[3]}"
    end
    CSV.open(filename, "w") do |csv|
      csv << ["id","regdate","first_name","last_name","email","phone","address","city","state","zipcode"]
      @queue.each do |q|
        csv << [q[:id],q[:regdate],q[:first_name],q[:last_name],q[:email],q[:phone],q[:address],q[:city],q[:state],q[:zipcode]]
      end
    end   
    puts "Your queue has been saved to file #{filename[6..-1]} in the output folder."
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
#  quely.save_to_file()
end

#puts Dir.pwd   - shows your current directory















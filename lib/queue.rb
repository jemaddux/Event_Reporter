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

  def queue_print_by(input)
    ##input is the attribute
    @queue = @queue.sort_by{|item| item[input.downcase.to_sym].downcase}
    print_q
  end

  def save_to_file(filename="output.csv")
        

    # def make_letter(name,zipcode,phone_number)
    #   form_letter ||= File.read "form_letter.erb.html"
    #   legislators = legislators_for_zipcode(zipcode)
    #   legislators.each do |x|
    #     x.phone = formated_phone_number(x.phone)
    #   end
    #   template = ERB.new form_letter
    #   results = template.result(binding)
    # end

    # def save_letter(name,id,zipcode,phone_number) 
    #   Dir.mkdir("output") unless Dir.exists? "output"
    #   filename = "output/thanks_#{id}.html"
    #   File.open(filename,'w') do |file|
    #     file.puts make_letter(name,zipcode,phone_number)
    #   end
    #   puts "Made letter for #{name}."
    # end
    #last name, first name, email, zipcode, city, state, address, and phone number.   
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
  #quely.print_q
  #quely.count_q
  quely.queue_print_by("zipcode")
end

#puts Dir.pwd   - shows your current directory















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
    count_q
  end

  def find(input) 
    @queue = []

    if ((input.length > 2) && (input[0].downcase == "city"))
      key, query = input[0], input[1..-1].join(" ")
    else
      key, query = input[0], input[1]
    end


    @file.each do |y|
      if y[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
        @queue.push(y)
      end
    end

    if (input[2]=="and")
      if ((input.length > 2) && (input[2].downcase == "city"))
        key, query = input[2], input[3..-1].join(" ")
      else
        key, query = input[3], input[4]
      end

      temp_queue = @queue
      @queue = []
      temp_queue.each do |o|
        if o[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
          @queue.push(o)
        end
      end
    end
    print_find(key,query)
  end

  def print_find(key,query)
    count_q
    puts "Items added to queue for <attribute> #{key} and <criteria> #{query}."
    puts "Enter 'queue print' to see your queue."   
  end

  def load(filename="event_attendees.csv")
    @file = []
    if filename == nil
      filename = "event_attendees.csv"
    end
    csv_open(filename)
    @file = @file[1..-1]
    puts "File loaded. #{@file.length} records loaded."
  end

  def csv_open(filename)
    CSV.foreach("output/"+filename) do |row|
      entry = {}
      entry[:id], entry[:regdate] = row[0], row[1]
      entry[:first_name], entry[:last_name] = row[2], row[3]
      entry[:email], entry[:phone] = row[4], row[5]
      entry[:address], entry[:city] = row[6], row[7]
      entry[:state], entry[:zipcode] = row[8], row[9]
      @file.push(entry)
    end 
  end

  def find_q_longest_size(attribute)
    longest_size = 0
    @queue.each do |x|
      if ((x[attribute.to_sym]).to_s.length > longest_size)
        longest_size = x[attribute.to_sym].length
      end
    end
    return longest_size
  end

  def print_q
  	puts ""
    last_name_size = find_q_longest_size(:last_name)
    r = find_q_longest_size(:first_name)
    if r > 10
      first_name_size = r
    else
      first_name_size = 11
    end
    email_size = find_q_longest_size(:email)
    z = find_q_longest_size(:zipcode)
    if z > 7
      zipcode_size = z
    else
      zipcode_size = 7
    end
    city_size = find_q_longest_size(:city)
    s = find_q_longest_size(:state)
    if s > 5
      state_size = s
    else
      state_size = 5
    end
    address_size = find_q_longest_size(:address)
    phone_size = find_q_longest_size(:phone)

  	print "Last Name".ljust(last_name_size+2," ")
    print "First Name".ljust(first_name_size+2," ")
    print "Email".ljust(email_size+2," ")+"Zipcode".ljust(zipcode_size+2," ")
    print "City".ljust(city_size+2," ")+"State".ljust(state_size+2," ")
    puts "Address".ljust(address_size+2," ")+"Phone".ljust(phone_size+2," ")
    
    @queue.each_with_index do |x, i|
      pause_me(i)
      print "#{x[:last_name].to_s.ljust(last_name_size+2," ")}"
      print "#{x[:first_name].to_s.ljust(first_name_size+2," ")}"
      print "#{x[:email].to_s.ljust(email_size+2," ")}"
      print "#{x[:zipcode].to_s.ljust(zipcode_size+2," ")}"
      print "#{x[:city].to_s.ljust(city_size+2," ")}"
      print "#{x[:state].to_s.ljust(state_size+2," ")}"
      print "#{x[:address].to_s.ljust(address_size+2," ")}"
      puts "#{x[:phone].to_s.ljust(phone_size+2," ")}"
    end
  end

  def pause_me(index)
    if ((index%10 == 0) && (index != 0))
      puts ""
      puts "Showing Matches #{index-10} through #{index} of #{@queue.count}."
      puts "Press Enter to Contine:"
      x = gets
    end
  end

  def print_by(input)
    @queue = @queue.sort_by{|item| item[input.downcase.to_sym].downcase}
    print_q
  end

  def save_to_file(input="output.csv")
    if input[3] == nil
      filename = "output/output.csv"
    else
      filename = "output/#{input[3]}"
    end
    save_CSV(filename)
    puts "File #{filename[6..-1]} saved in the output folder."
  end

  def save_CSV(filename)
    CSV.open(filename, "w") do |csv|
      csv << ["id","regdate","first_name","last_name",
        "email","phone","address","city","state","zipcode"]
      @queue.each do |q|
        csv << [q[:id],q[:regdate],q[:first_name],q[:last_name],
        q[:email],q[:phone],q[:address],q[:city],q[:state],q[:zipcode]]
      end
    end 
  end

  def return_queue
    return @queue
  end

  def count_q
    puts ""
    puts "There are #{@queue.count} items in your queue."
    return @queue.count
  end
end

if __FILE__ == $0
	quely = EventQueue.new()
  quely.load
  command = "find first_name John and city williamsburg".split(" ")
  quely.find(command[1..-1])
  quely.print_q
  command2 = 'queue save to empty.csv'.split(" ")
  quely.save_to_file(command2)
end
















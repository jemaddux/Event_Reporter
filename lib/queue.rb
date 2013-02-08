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

  def get_key_query(input,number)
    if ((input.length > 2) && (input[0].downcase == "city"))
      key, query = input[0], input[1..-1].join(" ")
    else
      key, query = input[0], input[1]
    end
    if number == 1
      return key
    else
      return query
    end
  end

  def little_find(key,query)
    @file.each do |y|
      if y[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
        @queue.push(y)
      end
    end
  end

  def second_key_query(input,number)
    if ((input.length > 2) && (input[2].downcase == "city"))
      key, query = input[2], input[3..-1].join(" ")
    else
      key, query = input[3], input[4]
    end
    if number == 1
      return key
    else
      return query
    end
  end

  def temp_queue_find(key,query)
    temp_queue = @queue
      @queue = []
      temp_queue.each do |o|
        if o[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
          @queue.push(o)
        end
      end
  end

  def find(input) 
    @queue = []
    key = get_key_query(input,1)
    query = get_key_query(input,2)
    little_find(key,query)

    if (input[2]=="and")
      key = second_key_query(input,1)
      query = second_key_query(input,2)
      temp_queue_find(key,query)
    end
    print_find(key,query)
    puts ""
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

  def get_all_long_sizes(attr_array)
    size_hash = {}
    attr_array.each do |attr|
      size_hash[attr] = find_q_longest_size(attr)
    end
    return size_hash
  end

  def size_hash_mins(size_hash,attr_array)
    min_sizes = {:first_name=>10, :last_name=>9, :email=>5, :zipcode=>7,
     :city=>4, :state=>5, :address=>7, :phone=>5}
    attr_array.each do |attr|
      if min_sizes[attr] > size_hash[attr]
        size_hash[attr] = min_sizes[attr]
      end
    end
    return size_hash
  end

  def print_header(attr_array,size_hash)
    attr_array.each do |attr|
      print "#{attr.to_s.split("_").join(" ").capitalize}".ljust(size_hash[attr]+3," ")
    end
    puts ""
  end

  def print_q_body(attr_array,size_hash)
    @queue.each_with_index do |x, i|
      pause_me(i)
      attr_array.each do |attr|
        print "#{x[attr]}".ljust(size_hash[attr]+3," ")
      end
      puts ""
    end
  end

  def print_q
    attr_array = [:first_name, :last_name, :email, :zipcode, :city, :state, :address, :phone]
  	size_hash = get_all_long_sizes(attr_array)
    size_hash = size_hash_mins(size_hash,attr_array)
    print_header(attr_array,size_hash)
    print_q_body(attr_array,size_hash)
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
  command = "find first_name John and state GA".split(" ")
  quely.find(command[1..-1])
  quely.print_q
  #command2 = 'queue save to empty.csv'.split(" ")
  #quely.save_to_file(command2)
end
















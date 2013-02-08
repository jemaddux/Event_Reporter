require_relative '../bin/event_reporter'
require_relative '../lib/load'
require_relative '../lib/savequeue'
require_relative '../lib/findqueue'
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
    finder = FindQueue.new(@file)
    finder.find(input)
    @queue = finder.return_q
  end

  def load(filename="event_attendees.csv")
    loader = LoadQueue.new
    loader.load(filename)
    @file = loader.return_file
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
    savior = SaveQueue.new
    savior.write_q(@queue)
    savior.save_to_file(input)
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
  command2 = 'queue save to empty.csv'.split(" ")
  quely.save_to_file(command2)
end


require_relative '../lib/queue'

class FindQueue
  def initialize(file)
  	@queue = []
  	@file = file
  end

  def count_q
    puts ""
    puts "There are #{@queue.count} items in your queue."
    return @queue.count
  end

  def little_find(key,query)
    @file.each do |y|
      if y[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
        @queue.push(y)
      end
    end
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

  def find(input) 
    print "INPUT: #{input}"
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

  def temp_queue_find(key,query)
    temp_queue = @queue
      @queue = []
      temp_queue.each do |o|
        if o[key.to_sym].to_s.downcase.chomp(" ") == query.to_s.downcase
          @queue.push(o)
        end
      end
  end

  def print_find(key,query)
    count_q
    puts "Items added to queue for <attribute> #{key} and <criteria> #{query}."
    puts "Enter 'queue print' to see your queue."   
  end

  def return_q
  	return @queue
  end
end
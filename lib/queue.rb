require_relative '../bin/command_prompt'
require 'csv'
require 'rainbow'

class EventQueue
  def initialize
    @the_queue = new_queue
    @the_file = []
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
      temp_var = CSV.open "lib/"+filename, headers: true, header_converters: :symbol
      temp_var.each do |line|
        @the_file.push(line)
      end
      puts @the_file
      a = {x: "12d", y: 12}
      x = []
      10.times do |r|
      	x.push(a)
      end
      puts x
    rescue
    end
  end
#  ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode
# 1,11/12/08 10:47,Allison,Nguyen,arannon@jumpstartlab.com,6154385000,3155 19th St NW,Washington,DC,20010
# 2,11/12/08 13:23,SArah,Hankins,pinalevitsky@jumpstartlab.com,414-520-5000,2022 15th Street NW,Washington,DC,20009
# 3,11/12/08 13:30,Sarah,Xx,lqrm4462@jumpstartlab.com,(941)979-2000,4175 3rd Street North,Saint Petersburg,FL,33703
# 4,11/12/08 14:04,Jennifer,Cope,bjgielskil@jumpstartlab.com,704-813-3000,1133 Shelton Ave,Nashville,TN,37216
# 5,11/12/08 14:46,Douglas,Zimmerman,vjeller.79@jumpstartlab.com,425-274-5000,1818 Woodland Ave #101,Des Moines,IA,50309

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
  #command = "find first_name john".downcase.split(" ")
end

#puts Dir.pwd   - shows your current directory
require_relative "../lib/queue"

class LoadQueue
	def initialize
		@file = []
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
    headers = [:id, :regdate, :first_name, :last_name, :email,
      :phone, :address, :city, :state, :zipcode]
    keys = {id: 0, regdate: 1, first_name: 2, last_name: 3, email: 4, 
      phone: 5, address: 6, city: 7, state: 8, zipcode: 9}
    CSV.foreach("output/"+filename) do |row|
      entry = {}
      headers.each do |head|
        entry[head] = row[keys[head]]
      end
      @file.push(entry)
    end 
  end

  def return_file
  	return @file
  end
end
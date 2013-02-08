require_relative '../lib/queue'

class SaveQueue
  def initialize
  	@queue = []
  end

  def write_q(input)
  	@queue = input
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
end
require_relative 'command_prompt'

class Queue
  def initialize
  	@the_queue = []
  end

  def new_queue
  	contents = manager.load_file()
  	puts contents
  end

  
end

quely = Queue.new()
quely.new_queue
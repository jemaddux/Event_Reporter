require "spec_helper"

describe EventQueue do
	before :each do
    @queue = EventQueue.new
	end

	describe "#new" do
    it "takes zero parameters and returns a Help object" do
    	@queue.should be_an_instance_of EventQueue
    end
  end

  

end
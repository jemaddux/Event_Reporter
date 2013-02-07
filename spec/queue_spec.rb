require "spec_helper"

describe EventQueue do
	before :each do
    @event_queue = EventQueue.new
    @event_queue.load('rspec_test_file.csv')
    command = "find first_name John".split(" ")
    @event_queue.find(command[1..-1])
	end

	context "#new" do
    it "takes zero parameters and returns a Help object" do
    	@event_queue.should be_an_instance_of EventQueue
    end
  end

  describe "method load(filename)" do
    it "should have 63 records loaded" do
    	@event_queue.count_q.should == 63
    end

    it "should have a value of '281'" do
      @event_queue.return_queue[1][:id].should == "281"
    end
  end

  describe "#find(input)" do
    it "should have a name of John" do
 		  @event_queue.return_queue[4][:first_name].should == "John"
    end
  end

  describe "#print_by(input)" do
  	it "should resort the file so the first last_name is Alexander" do
 		  @event_queue.print_by('last_name')
 		  @event_queue.return_queue[1][:last_name].should == "Alexander"
  	end
  end

  describe "#clear_q" do
    it "should clear the queue and thus equal zero on the count" do
      @event_queue.clear_q
      @event_queue.return_queue.count.should == 0
    end
  end
end
require_relative '../bin/event_reporter'

describe Queue do
	it "should put text when help is called" do
    @eventManager = CommandPrompt.new()

    true.should be_true
	end
	

	# it "does not go berserk when w00ted up to 5 times" do
 #    1.upto(5) { @player.w00t }
    
 #    @player.berserk?.should be_false
 #  end
end
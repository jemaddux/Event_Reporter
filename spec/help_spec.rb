require "spec_helper"

describe Help do
	before :each do
    @help = Help.new
	end

	describe "#new" do
    it "takes zero parameters and returns a Help object" do
    	@help.should be_an_instance_of Help
    end
  end
end
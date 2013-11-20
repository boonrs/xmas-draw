require "rspec/autorun"
require_relative "main"

module XmasDraw
  describe Matcher do
    it "matches people" do
      people = %w{bob joe sue sally}
      matches = Matcher.new(people).match
      people.each do |person|
        giver_count = matches.count { |g, r| g == person }
        receiver_count = matches.count { |g, r| r == person }
        giver_count.should == 1
        receiver_count.should == 1
      end
    end

    it "does not match people to themselves" do
      people = %w{bob joe sue sally}
      matches = Matcher.new(people).match
      matches.each do |giver, receiver|
        giver.should_not == receiver
      end
    end

    it "honors a blacklist" do
      people = %w{bob joe sue sally}
      blacklist = {"bob"=>%w{joe sue}}
      matches = Matcher.new(people, blacklist).match
      matches.find { |g, r| g=="bob"}[1].should == "sally"
    end
  end
end

  require 'spec_helper'

  RSpec::Matchers.define :be_recurring do 
    match do |event|
      # some sort of recurrence to be defined
      not event.recurring_type_id.nil?
    end
  end

  describe EventsController do

      before do 
        ev = Event.new
        ev.id = 1
        ev.description = 'tester12'
        ev.save

        ev = Event.new
        ev.id = 2
        ev.description = 'recurring'
        ev.recurring_type_id = 1
        ev.save
      end
      
      it "should create valid event" do
        ev = Event.find(1)
        ev.description.should eql('tester12')
        ev.description.should be_a(String)
      end

      it "should mail a user" do
        
      end
      
      it "should create recurring event" do
        ev = Event.where('recurring_type_id is not NULL')
        ev[0].should be_recurring
      end
  end

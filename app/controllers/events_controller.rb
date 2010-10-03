class EventsController < ApplicationController
  
  def year
    now = Time.now
    @events = Event.where([
                  "first > ? and first < ?",
                  now.at_beginning_of_year.to_formatted_s(:db),
                  now.at_end_of_year.to_formatted_s(:db)
                ])
    
    @months = {}
    
    # sort into each month
    @mlist = Time::RFC2822_MONTH_NAME
    @events.each do |e|
      m = e.first.month
      @months[m] = e
    end
    
  end
  
  def month
    @now = Time.now
    @now = Time.local(@now.year, params[:id].to_i, @now.day,@now.hour,@now.min,@now.sec)
    
    @events = Event.time_range( 
                          @now.at_beginning_of_month.to_formatted_s(:db), 
                          @now.at_end_of_month.to_formatted_s(:db)
                        )

  end
  
  def day
    @now = Time.now
    @now = Time.local(@now.year, params[:month].to_i, params[:day],@now.hour,@now.min,@now.sec)

    @events = Event.time_range(@now.beginning_of_day.to_formatted_s(:db), @now.end_of_day.to_formatted_s(:db))
  end
  
  make_resourceful do
    actions :all
  end
  
end

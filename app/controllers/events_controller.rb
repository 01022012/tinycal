class EventsController < ApplicationController

  def year
    # SlyLynx::Checker.validate_links(['a','b','c'])
    now = Time.now
    

    @events = Event.where([
                  "first > ? and first < ?",
                  now.at_beginning_of_year.to_formatted_s(:db),
                  now.at_end_of_year.to_formatted_s(:db)
                ])
    
    # sort into each month
    @mlist = Time::RFC2822_MONTH_NAME
    @months = []
    
    @events.each do |e|
      
      m = e.first.month
      if @months[m-1].nil?
        @months[m-1] = []
      end

      @months[m-1] << e
    end
    logger.warn "COUNT"
    logger.warn @events.count
    logger.warn @months.inspect
  end
  
  def month
    @now = Time.now
    @now = Time.local(@now.year, params[:month].to_i, @now.day,@now.hour,@now.min,@now.sec)
    
    @events = Event.time_range( 
                          @now.at_beginning_of_month.to_formatted_s(:db), 
                          @now.at_end_of_month.to_formatted_s(:db)
                        )
    @days = []
    # Collate events into a list so we can sum show them or do whatever.
    @events.each do |e|
      day = e.first.day - 1
      if @days[day].nil?
          @days[day] = []
      end
      @days[day] << e
    end

  end

  def day
    @now = Time.now
    @now = Time.local(@now.year, params[:month].to_i, params[:day],@now.hour,@now.min,@now.sec)

    @events = Event.time_range(@now.beginning_of_day.to_formatted_s(:db), @now.end_of_day.to_formatted_s(:db))
    @event_map = []

    @events.each do |e|
      index = e.first.hour * 2 + e.first.min / 30 
      unless @event_map[index]
        @event_map[index] = []
      end
      @event_map[index] << e
    end
  end
  
  make_resourceful do
    actions :all
    before :new do
      @now = Time.now
      @now = Time.local(
                @now.year, 
                ( params[:month].nil? ? @now.month : params[:month].to_i ),
                ( params[:day].nil? ? @now.day : params[:day].to_i), 
                @now.hour,
                @now.min,
                @now.sec
                )
      @event.first = @now
    end
  end
  
end

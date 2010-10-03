class Event < ActiveRecord::Base

  def self.time_range ( from, to )
    return Event.where([
                  "first > ? and first < ?",
                  from,
                  to
              ])
  end
end

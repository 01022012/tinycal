module SlyLynx
  # Various Validations for link based rources
  
  module Checker
    extend self
    
    def self.validate_links(links)
      links.each do |l|
        RAILS_DEFAULT_LOGGER.warn "processing "+l.to_s
      end
    end
  end
end


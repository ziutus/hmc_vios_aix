
require 'HMC/lssvcenevents_entry'

class Lssvcevents

  attr_reader :events
  attr_reader :errors

  def initialize(string = nil, hmc_name = nil)
    @events = []
    @errors = []

    parse(string, hmc_name) unless string.nil?
  end

  def parse(string, hmc_name)

    return true if   /^No results were found./.match(string)

    if /An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative/.match(string)
      hash_data = { :hmc => hmc_name, :error => 'An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative' }
      @errors.push(hash_data)
      return true
    end

    string.split("\n").each do |line|
      entry = Lssvcenevents_entry.new(line, hmc_name)

      if @events.count.zero?
        @events.push(entry)
        next
      end

      exist_in_events = false
      event_id = 0
      @events.each_with_index  { |event, id|
        if event.compare(entry)
          event_id = id
          exist_in_events = true
          break
        end
      }

      if exist_in_events
        @events[event_id].hmc_add(hmc_name)
      else
        @events.push(entry)
      end

    end

    true
  end

  def count
    @events.count
  end

end
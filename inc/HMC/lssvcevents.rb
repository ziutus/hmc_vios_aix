require 'HMC/lssvcenevents_entry'

# Fantastic class to analyze events from HMCs
class Lssvcevents
  attr_reader :events
  attr_reader :errors

  def initialize(string = nil, hmc_name = nil)
    @events = []
    @errors = []

    parse(string, hmc_name) unless string.nil?
  end

  def parse(string, hmc_name)
    return true if string =~ /^No results were found./

    if string =~ /An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative/
      @errors.push(hmc: hmc_name, error: 'An unknown error occurred while trying to perform this command. Retry the command. If the error persists, contact your software support representative')
      return true
    end

    string.split("\n").each do |line|
      entry = Lssvcenevents_entry.new(line, hmc_name)

      if @events.count.zero?
        @events.push(entry)
        next
      end

      event_id = 0
      @events.each_with_index do |event, id|
        if event.compare(entry)
          event_id = id
          break
        end
      end

      if event_id > 0
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

  def parse_csv(string)
    return true if string.nil?

    headers = ''
    line_nr = 0
    lines = string.split("\n")
    lines.each do |line|
      if line_nr.zero?
        headers = line
        line_nr += 1
        next
      end

      entry = Lssvcenevents_entry.new
      entry.parse_from_csv(headers, line)

      event_id = -1
      @events.each_with_index do |event, id|
        if event.compare(entry, %w[hmcs_name problem_num last_time refcode sys_name failing_mtms machine_type machine_model status text phm_num])
          event_id = id
          puts "Event ID #{id} found"
          next
        end
      end

      @events[event_id].parse_from_csv(headers, line) if event_id >= 0
      line_nr += 1
    end

    true
  end

end
require 'AIX/fcstat'

class Adapter_fc

  attr_reader  :fcstats

  attr_accessor :serial_number

  def initialize

    @fcstats = Hash.new
    @serial_number = nil
  end

  def fcstat_add(timestamp, string)

    @fcstats[timestamp] = Fcstat.new(string)
    self.validate_new_fcstat_data(timestamp)

  end

  def validate_new_fcstat_data(timestamp)

    if @fcstats.count == 1
      @serial_number = @fcstats[timestamp].data['Serial Number']
    else
      pp @serial_number
      pp @fcstats[timestamp].data['Serial Number']
      raise 'wrong serial number' if @fcstats[timestamp].data['Serial Number'] != @serial_number

    end
  end

  def analyze

    verbose = 1

    if @fcstats.count == 2
      puts 'Will analyze data'

      keys = @fcstats.keys

      fcs_1 = @fcstats[keys[0]]
      fcs_2 = @fcstats[keys[1]]

      if keys[0] < keys[1]
        puts "Test of timestamps -  [passed] " if verbose > 0
      else
        raise 'Wrong timestamps order in object, this version can work in this case (wrong data file?)'
      end

      if  fcs_1.data["Seconds Since Last Reset"] < fcs_2.data["Seconds Since Last Reset"]
        puts "Seconds from liast Reset are increasing, it means adapter stats weren't reset and we can compare both states [passed]"
      else
        raise 'data statistics were reset, cannot compare data'
      end


    else
      puts 'I cannot find 2 fcstats entries'
    end
  end

  def diffs

    diffs = Hash.new

    timestamps = @fcstats.keys
    fcs_1 = @fcstats[timestamps[0]]
    fcs_2 = @fcstats[timestamps[1]]

    fcs_1.data.each_pair { |key, value|

      diff = Hash.new

      if value.class == Hash
          value.each_pair { |key2, value2|
              puts "key: #{key}, key2: #{key2}, value2 type: #{value2.class}"

              if fcs_1.data[key][key2] != fcs_2.data[key][key2]
                diff[timestamps[0]] = fcs_1.data[key][key2]
                diff[timestamps[1]] = fcs_2.data[key][key2]
                diffs["#{key}-#{key2}"] = diff
              end

          }
      elsif   value.class == String or value.class == Integer
        #puts "key: #{key}, value type: #{value.class}"

        if fcs_1.data[key] != fcs_2.data[key]
          diff[timestamps[0]] = fcs_1.data[key]
          diff[timestamps[1]] = fcs_2.data[key]
          diffs[key] = diff
        end

      else
        puts "Unknown type: #{value.class}"
      end
    }

    diffs
  end

end
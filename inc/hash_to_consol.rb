require 'pp'

class HashToConsol
  attr_reader :hash

  def initialize
    @rows = Array.new
    @row_size = Array.new
    @row_max  = Array.new
  end

  def add_row(row)
      row.each_index {|index |
        @row_size[index] = row[index].size if @row_size[index].to_i < row[index].size
      }
      @rows.push(row)


  end

  def to_s

    result = ''

    @rows.each {|row |
      row.each_index {|col_id|
          size = @row_size[col_id]
          result += sprintf("%#{size}.#{size}s;", row[col_id])
        }

      result += "\n"
    }

    result
  end

end
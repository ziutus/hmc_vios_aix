require 'pp'

class HashToConsol
  attr_reader :hash

  def initialize
    @rows = Array.new
    @col_size = Array.new
    @col_size_max  = Array.new
  end

  def col_size_set(row_id, size)
    @col_size_max[row_id] = size
  end

  def add_row(row)
      row.each_index {|index |
        @col_size[index] = row[index].size if @col_size[index].to_i < row[index].size
      }
      @rows.push(row)


  end

  def to_s

    result = ''

    @rows.each {|row |
      row.each_index {|col_id|

          unless @col_size_max[col_id].nil?
            size = @col_size_max[col_id]
          else
            size = @col_size[col_id]
          end
          result += sprintf("%#{size}.#{size}s;", row[col_id])
        }

      result += "\n"
    }

    result
  end

end
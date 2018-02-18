require 'pp'

class HashToConsole
  attr_reader :hash

  def initialize
    @rows = Array.new
    @col_size = Array.new
    @col_size_max  = Array.new
    @col_names = nil
    @cols_visible = Array.new
  end

  def col_size_set(row_id, size)
    @col_size_max[row_id] = size
  end

  def add_row(row)
    row.each_index { |index|
      @col_size[index] = row[index].size if @col_size[index].to_i < row[index].size
    }
    @rows.push(row)
  end

  def add_col_names(row)
    row.each_index { |index|
      @col_size[index] = row[index].size if @col_size[index].to_i < row[index].size
      @cols_visible[index] = true
    }
    @col_names = row
  end

  def col_visibility(col_id, status)

    raise "wrong status #{status}" unless status == true or status == false

    if col_id.is_a?(String)
      col_id.split(',').each { |id|
        id = self.get_col_id(id)
        @cols_visible[id] = status
      }
    elsif col_id.is_a?(Integer)
      @cols_visible[col_id -1] = status
    else
      raise 'col_id is not Interger' unless col_id.is_a?(Integer)
    end

  end


  def col_disable(col_id)
    self.col_visibility(col_id, false)
  end

  def col_enable(col_id)
    self.col_visibility(col_id, true)
  end



  def add_hash(data)

    if (data.kind_of?(Array))
      data.each { |line|
        if line.kind_of?(Hash)

          self.add_col_names( line.keys)  if @col_names.nil? #first row, let's setup col names

          line.each_key { |key|
            raise "unknown column #{key}" unless @col_names.include?(key)
          }
          self.add_row(line.values)

        else
          raise "unsupported line #{line.class}"
        end
      }
    else
      raise "unsupported case #{data.class}"
    end
  end

  def to_s_F(columns = '', separator = ';')
    result = ''

    columns == '' ? columns = @col_names : columns = columns.split(separator)

    columns.each { |column_name|
      raise "unknown column #{column_name}" unless @col_names.include?(column_name)
    }

    columns.each { |column_name|
      result += self.get_colname_nice(column_name) + separator
    }
    result += "\n"

    @rows.each_index { |row_id|
      columns.each { |column_name|
        result += self.get_value_nice(row_id, column_name) + separator
      }
      result += "\n"
    }

    result
  end

  def to_s

    result = ''

    unless @col_names.nil?

      @col_names.each_index { |col_id|
        unless @col_size_max[col_id].nil?
          size = @col_size_max[col_id]
        else
          size = @col_size[col_id]
        end

        result += sprintf("%#{size}.#{size}s;", @col_names[col_id]) unless @cols_visible[col_id] == false
      }
      result += "\n"
    end



    @rows.each {|row |
      row.each_index {|col_id|

        unless @col_size_max[col_id].nil?
          size = @col_size_max[col_id]
        else
          size = @col_size[col_id]
        end
        result += sprintf("%#{size}.#{size}s;", row[col_id]) unless @cols_visible[col_id] == false
      }

      result += "\n"
    }

    result
  end

  def get_value(row_id, col_id)

    if col_id.is_a?(String)
      raise "unknown col_name: '#{col_id}'" if @col_names.index(col_id).nil?
      col_id = @col_names.index(col_id)
    elsif col_id.is_a?(Integer)
      col_id = col_id -1
    else
      raise 'col_id is strange'
    end

    row_data = @rows[row_id -1]
    unless row_data.nil?
      return row_data[col_id]
    end

    nil
  end

  def get_value_nice(row_id, col_id)
    size = self.get_col_size(col_id)
    col_id = self.get_col_id(col_id) + 1
    sprintf("%#{size}.#{size}s", self.get_value(row_id, col_id)) unless @cols_visible[col_id] == false
  end

  def get_colname_nice(col_name)
    size = self.get_col_size(col_name)
    sprintf("%#{size}.#{size}s", col_name)
  end


  def get_col_size(id_or_name)

    col_id = self.get_col_id(id_or_name)

    unless @col_size_max[col_id].nil?
      size = @col_size_max[col_id]
    else
      size = @col_size[col_id]
    end
    size
  end

  def get_col_id (col_id)
    if col_id.is_a?(String)
      raise "unknown col_name: '#{col_id}'" if @col_names.index(col_id).nil?
      col_id = @col_names.index(col_id)
    elsif col_id.is_a?(Integer)
      col_id = col_id
    else
      raise 'col_id is strange'
    end

  end

end
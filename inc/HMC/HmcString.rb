module HmcString

  def parse(string)

    myResult = Hash.new()
    key = ''
    value = ''
    insideIndex = 1
    insiteQuotationMark = 0
	
	i=0	
	while i < string.length

	  if string[i] == '"' and string[i+1] == '"' 
		i=i+2
		value << '""'
		next
      end
	
      if string[i] == '"' and string[i+1] != '"' 
        insiteQuotationMark ==0 ? insiteQuotationMark =1 : insiteQuotationMark = 0
		i=i+1
        next
      end

      if string[i] == "="
        if insideIndex == 1
          insideIndex = 0
        else
          insideIndex = 1
        end
		i=i+1
        next
      end

      if string[i] == ',' and insiteQuotationMark == 0
        myResult[key]= value
        key = ''
        value = ''
        insideIndex = 1
		i=i+1
        next
      end

      if insideIndex == 1
         key << string[i]
      else
        value << string[i]
      end
  
	  i=i+1
	end
	
    myResult[key]= value #last key and value (loop is ended as we haven't last ",")

    myResult

  end
  
  def parse_value string 
  
	i=0	
    insiteQuotationMark = 0
	key=''
	value=''
	array = Array.new()

	while i < string.length

		if string[i] == '"' and string[i+1] == '"'
			
			if insiteQuotationMark == 0
				insiteQuotationMark = 1
			else 
				insiteQuotationMark = 0
			end
			
			i=i+2
			next
		end
		
		if string[i] == ',' and insiteQuotationMark == 0
			array.push(value)
			value = ''
			i=i+1
			next
		end

		value << string[i]
		i=i+1
	end

	array.push(value)
	
	array
  end

end
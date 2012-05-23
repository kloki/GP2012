function inlist(item,list)
   answer=false
   for _,i in pairs(list) do
      if i==item then answer=true break end
   end

return answer
end

function printtable(table)

   for i,v in pairs(table) do
      row=" "
      for u,j in pairs(v) do
	 if j==0 then row=row.."|__"
	 elseif j>9 then row=row.."|" .. tostring(j)
	    else row=row.."|_" ..tostring(j) end
      end
      print(row)
   end
   print("  ")
end


function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end
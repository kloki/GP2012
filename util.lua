function inlist(item,list)
   answer=false
   for _,i in pairs(list) do
      if i==item then answer=true break end
   end

return answer
end
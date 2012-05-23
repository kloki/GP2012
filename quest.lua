function quest()

   addkeys()
   adddoors()

end

function addkeys()
   
   for key=56,59 do
      v=math.random(1,numberofworlds)
      v=1
      worlds=placekey(v,key)
   end
end

function placekey(v,key)
   x=math.random(2,horizontaltiles-1)
   y=math.random(2,verticaltiles-1)
   if worlds[v][y][x]>10 or worlds[v][y][x]<1 then placekey(worlds,v,key)--only place keys on grass
   else 
      if key==56 then table.insert(Objects[v],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Key56'})
      elseif key==57 then table.insert(Objects[v],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Key57'})
      elseif key==58 then table.insert(Objects[v],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Key58'})
      elseif key==59 then table.insert(Objects[v],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Key59'})
      end
   end

end

function adddoors()
  
   table.insert(Objects[1],{336,0,143,32,'Gate','Key56'})
   table.insert(Objects[1],{336,576,143,32,'Gate','Key57'})
   table.insert(Objects[1],{0,272,32,100,'Gate','Key58'})
   table.insert(Objects[1],{768,272,32,100,'Gate','Key59'})
end

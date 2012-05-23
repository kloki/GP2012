require('util')

function quest(worlds)

   blank=blankmap(overworld)
   printtable(overworld)
   printtable(blank)
      --breakingpoint
   coor=findbreakingpoint()
   blank[coor[1]][coor[2]]=71
   printtable(blank)
   blank=creep(blank,coor,2)
   printtable(blank)
   addkeys(worlds)
   adddoors(worlds)
end


function creep(blank,coor,mark)
   if blank[coor[1]][coor[2]+1]~=0 then blank=grow(blank,coor[1],coor[2]+1)
   elseif blank[coor[1]][coor[2]-1]~=0 then blank=grow(blank,coor[1],coor[2]-1)
   elseif blank[coor[1]+1][coor[2]]~=0 then blank=grow(blank,coor[1]+1,coor[2])
   elseif blank[coor[1]-1][coor[2]]~=0 then blank=grow(blank,coor[1]-1,coor[2]) end
return blank
end

function grow(blank,x,y)
   blank[x][y]=2
   if blank[x][y+1]==1 then blank=grow(blank,x,y+1) end
   if blank[x][y-1]==1 then blank=grow(blank,x,y-1) end
   if blank[x+1][y]==1 then blank=grow(blank,x+1,y) end
   if blank[x-1][y]==1 then blank=grow(blank,x-1,y) end
  
return blank
end

function findbreakingpoint()
   breakingpoint=math.random(1,numberofworlds)
   coor=getcoor(breakingpoint)
   x=0
   if overworld[coor[1]][coor[2]+1]~=0 then x=x+1 end
   if overworld[coor[1]][coor[2]-1]~=0 then x=x+1 end
   if overworld[coor[1]+1][coor[2]]~=0 then x=x+1 end
   if overworld[coor[1]-1][coor[2]]~=0 then x=x+1 end
   if x>2 then coor=findbreakingpoint() end
return coor
end

function getcoor(number) 
   for i=1,12 do
      for n=1,6 do
	 if overworld[n][i]==number then coor={n,i} break end
      end
   end
return coor
end

function blankmap(map)
   blank=deepcopy(map)
   for i=1,12 do
      for n=1,6 do
	 if blank[n][i]~=0 then blank[n][i]=1 end
      end
   end
   
   return blank
end

function addkeys(worlds)
   
   for key=56,59 do
      v=math.random(1,numberofworlds)
      v=1
      placekey(worlds,v,key)
   end
end

function placekey(worlds,v,key)
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

function adddoors(worlds)
   table.insert(Objects[1],{336,0,143,32,'Gate','Key56'})
   table.insert(Objects[1],{336,576,143,32,'Gate','Key57'})
   table.insert(Objects[1],{0,272,32,100,'Gate','Key58'})
   table.insert(Objects[1],{768,272,32,100,'Gate','Key59'})
end

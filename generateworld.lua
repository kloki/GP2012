require('util')
require('quest')

function loadtiles()
   images = {}
   for i=0,9 do
      images[i+1] = love.graphics.newImage("tiles/grass/grass" .. tostring(i) .. ".png")
   end
   --images[11]=love.graphics.newImage("sprites/wall.gif")
   images[12]=love.graphics.newImage("tiles/bushes/bush.png")
   images[13]=love.graphics.newImage("tiles/bushes/redberrybush.png")
   images[14]=love.graphics.newImage("tiles/bushes/purpleberrybush.png")
   images[15]=love.graphics.newImage("tiles/bushes/yellowberrybush.png")
   images[16]=love.graphics.newImage("tiles/cliff/cliff-base.png")
   images[17]=love.graphics.newImage("tiles/cliff/cliff-top.png")
   images[18]=love.graphics.newImage("tiles/sea/sea1.png")
   images[19]=love.graphics.newImage("tiles/sea/sea2.png")
   images[20]=love.graphics.newImage("tiles/sea/sea3.png")
   images[21]=love.graphics.newImage("tiles/sea/sea-grass-bottom.png")
   images[22]=love.graphics.newImage("tiles/sea/sea-grass-top.png")
   images[23]=love.graphics.newImage("tiles/sea/sea-grass-left.png")
   images[24]=love.graphics.newImage("tiles/sea/sea-grass-right.png")
   images[25]=love.graphics.newImage("tiles/sea/sea-grass-corner-tl.png")
   images[26]=love.graphics.newImage("tiles/sea/sea-grass-corner-tr.png")
   images[27]=love.graphics.newImage("tiles/sea/sea-grass-corner-bl.png")
   images[28]=love.graphics.newImage("tiles/sea/sea-grass-corner-br.png")
   images[29]=love.graphics.newImage("tiles/misc/tree.png")
   images[30]=love.graphics.newImage("tiles/edges/trees-bottom.png")
   images[31]=love.graphics.newImage("tiles/edges/trees-top.png")
   images[32]=love.graphics.newImage("tiles/edges/trees-left.png")
   images[33]=love.graphics.newImage("tiles/edges/trees-right.png")
   images[34]=love.graphics.newImage("tiles/edges/trees-bottom-gate.png")
   images[35]=love.graphics.newImage("tiles/edges/trees-top-gate.png")
   images[36]=love.graphics.newImage("tiles/edges/trees-left-gate.png")
   images[37]=love.graphics.newImage("tiles/edges/trees-right-gate.png") 
   images[38]=love.graphics.newImage("tiles/objects/swordground.png")
   images[39]=love.graphics.newImage("tiles/house/house1.png")
   images[40]=love.graphics.newImage("tiles/house/house2.png")
   images[41]=love.graphics.newImage("tiles/house/house3.png")
   images[42]=love.graphics.newImage("tiles/house/tree-house.png")
   images[43]=love.graphics.newImage("tiles/house/house4.png")
   images[44]=love.graphics.newImage("tiles/house/house5.png")
   images[45]=love.graphics.newImage("tiles/bushes/small_bush.png")
   images[46]=love.graphics.newImage("tiles/bushes/mushroom.png")
   images[47]=love.graphics.newImage("tiles/objects/pot.png")
   images[48]=love.graphics.newImage("tiles/objects/treasure-chest.png")
   images[49]=love.graphics.newImage("tiles/objects/treasure-chest-opened.png")
   images[50]=love.graphics.newImage("tiles/path/path1.png")
   images[51]=love.graphics.newImage("tiles/path/path2.png")
   images[52]=love.graphics.newImage("tiles/path/path3.png")
   images[53]=love.graphics.newImage("tiles/path/path4.png")
   images[54]=love.graphics.newImage("tiles/path/path5.png")
   images[55]=love.graphics.newImage("sprites/heart.png")
   images[56]=love.graphics.newImage("tiles/objects/key1.png")
   images[57]=love.graphics.newImage("tiles/objects/key2.png")
   images[58]=love.graphics.newImage("tiles/objects/key3.png")
   images[59]=love.graphics.newImage("tiles/objects/key4.png")
   images[60]=love.graphics.newImage("tiles/objects/sword.png")
   images[61]=love.graphics.newImage("tiles/scenery/lumber.png")
   images[62]=love.graphics.newImage("tiles/scenery/oneye.png")
   images[63]=love.graphics.newImage("tiles/scenery/schommel.png")
   images[64]=love.graphics.newImage("tiles/scenery/stool.png")
   images[65]=love.graphics.newImage("tiles/scenery/well.png")
   images[66]=love.graphics.newImage("tiles/house/insidehouse1.png")
   images[67]=love.graphics.newImage("tiles/house/insidehouse2.png")
   images[68]=love.graphics.newImage("tiles/house/insidehouse3.png")
   images[69]=love.graphics.newImage("tiles/house/insidehouse4.png")
   images[70]=love.graphics.newImage("tiles/objects/rupee.png")
   images[71]=love.graphics.newImage("tiles/objects/sword2.png")
   images[72]=love.graphics.newImage("tiles/objects/boemobj.png")
   images[73]=love.graphics.newImage("tiles/cliff/stairs.png")
   images[74]=love.graphics.newImage("tiles/gates/door-bottom.png")
   images[75]=love.graphics.newImage("tiles/gates/door-bottom57.png")
   images[76]=love.graphics.newImage("tiles/gates/door-bottom58.png")
   images[77]=love.graphics.newImage("tiles/gates/door-bottom59.png")
   images[78]=love.graphics.newImage("tiles/gates/door-top.png")
   images[79]=love.graphics.newImage("tiles/gates/door-top57.png")
   images[80]=love.graphics.newImage("tiles/gates/door-top58.png")
   images[81]=love.graphics.newImage("tiles/gates/door-top59.png")
   images[82]=love.graphics.newImage("tiles/gates/door-left.png")
   images[83]=love.graphics.newImage("tiles/gates/door-left57.png")
   images[84]=love.graphics.newImage("tiles/gates/door-left58.png")
   images[85]=love.graphics.newImage("tiles/gates/door-left59.png")
   images[86]=love.graphics.newImage("tiles/gates/door-right.png")
   images[87]=love.graphics.newImage("tiles/gates/door-right57.png")
   images[88]=love.graphics.newImage("tiles/gates/door-right58.png")
   images[89]=love.graphics.newImage("tiles/gates/door-right59.png")
   images[90]=love.graphics.newImage("tiles/gates/gate-bottom.png")
   images[91]=love.graphics.newImage("tiles/gates/gate-top.png")
   images[92]=love.graphics.newImage("tiles/gates/gate-left.png")
   images[93]=love.graphics.newImage("tiles/gates/gate-right.png")
   images[94]=love.graphics.newImage("tiles/house/insidedungeon.png")
   images[95]=love.graphics.newImage("tiles/house/dungeon.png")
   images[96]=love.graphics.newImage("tiles/house/zeldahouseinside.png")
   images[97]=love.graphics.newImage("tiles/house/castle.png")
    

   
   --here the list of tiles which cannot be drawnover
   forbiddentiles={-1,16,17,18,19,20,21,22,23,24,25,26,27,28,29,39,40,41,42,43,44,61,62,63,64,65,73,95,97}
end


--creates an array of worlds
function createworlds() 
   worlds = {}
   for m=1,numberofworlds do
      worlds[m]=createworld(m)
   end
   worlds=buildgates(worlds)
   worlds=addchests(worlds)
   quest(worlds)
   --worlds=addweapons(worlds)
return worlds
end


--creates a world and adds environment
--world[verticaltiles][horizantaltiles]
function createworld(m)
   world = {}
   for i=1,verticaltiles do
      world[i]={}
      for n=1,horizontaltiles do
	 if math.random()<0.86 then
	    world[i][n]=math.random(1,3)
	 else
	    world[i][n]=math.random(4,10)
	 end
	 --create the edges
	 if i==1 or i==verticaltiles or n==1 or n==horizontaltiles then world[i][n]=-1 end
      end
   end
   --add worldtypes
   if m==numberofworlds then zeldaworld(world,m)
   elseif m==8 then swordworld(world,m)
   elseif m==12 then boomerangworld(world,m)
   else worldtype=math.random(1,4)
      if worldtype==1 then
	 world=grassworld(world,m)
      elseif worldtype==2 then
	 world=cliffworld(world,m)
      elseif worldtype==3 then
	 world=waterworld(world,m)
      elseif worldtype==4 then
	 world=hermitworld(world,m)
      elseif worldtype==5 then
	 world=villageworld(world,m)
      elseif worldtype==6 then
	 world=testworld(world,m)
      end
   end
   addspawns(world,m)
return world
end

function createoverworld()
   overworld = {}
   for i=0,sizeoverworld[1]+1 do
      overworld[i]={}
      for n=0, sizeoverworld[2]+1 do
	 overworld[i][n]=0
      end
   end
   --starting point
   overworld[coor[1]][coor[2]]=1
   --automated generation
   count = 2
   while true do
      for i=1,sizeoverworld[1] do
	 if count==numberofworlds+1 then break end
	 for n=1, sizeoverworld[2]do
	    if count==numberofworlds+1 then break end
	    if overworld[i][n]==0 then
	       x=0
	       if overworld[i-1][n]~=0 then x=x+1 end
	       if overworld[i+1][n]~=0 then x=x+1 end
	       if overworld[i][n-1]~=0 then x=x+1 end
	       if overworld[i][n+1]~=0 then x=x+1 end
	       if x==1  then
		  if math.random()<(0.42) then
		     overworld[i][n]=count
		     count=count+1
		  end
	       end
	    end
	 end
      end
      if count==numberofworlds+1 then break end
   end

return overworld
end


--creates gates between worlds, can only be generated after all worlds are generated
function buildgates(worlds)
   gatedworlds=worlds
   for i=1,sizeoverworld[1] do
      for n=1,sizeoverworld[2]do
	 if overworld[i][n]~=0 then
	    --add north gate
	    if overworld[i-1][n]~=0 then
	       worlds[overworld[i][n]][1][1]=35
	       table.insert(Objects[overworld[i][n]],{336,0,143,10,'North'})
	       table.insert(Objects[overworld[i][n]],{1,1,336,32,'Object'})
	       table.insert(Objects[overworld[i][n]],{336+143,1,800-336-143,32,'Object'})
	    else
	      worlds[overworld[i][n]][1][1]=31
	      table.insert(Objects[overworld[i][n]],{1,1,800,32,'Object'})
	    end
	    --add south gate
	    if overworld[i+1][n]~=0 then
	       worlds[overworld[i][n]][verticaltiles][1]=34
	       table.insert(Objects[overworld[i][n]],{336,598,143,10,'South'})
	       table.insert(Objects[overworld[i][n]],{1,576,336,32,'Object'})
	       table.insert(Objects[overworld[i][n]],{336+143,576,800-336-143,32,'Object'})
	    
	    else
	       worlds[overworld[i][n]][verticaltiles][1]=30
	       table.insert(Objects[overworld[i][n]],{1,576,800,32,'Object'})
	    end
	    --add west gate
	    if overworld[i][n-1]~=0 then
	       worlds[overworld[i][n]][2][1]=36
	       table.insert(Objects[overworld[i][n]],{0,272,10,100,'West'})
	       table.insert(Objects[overworld[i][n]],{0,32,32,272-32,'Object'})
	       table.insert(Objects[overworld[i][n]],{0,272+100,32,640-64-272-100,'Object'})
	       else
	       worlds[overworld[i][n]][2][1]=32
	       table.insert(Objects[overworld[i][n]],{0,32,32,640-64,'Object'})
	    end	    
	    --add east gate
	    if overworld[i][n+1]~=0 then
	       worlds[overworld[i][n]][1][horizontaltiles]=37
	       table.insert(Objects[overworld[i][n]],{790,272,10,100,'East'})
	       table.insert(Objects[overworld[i][n]],{768,32,32,272-32,'Object'})
	       table.insert(Objects[overworld[i][n]],{768,272+100,32,640-64-272-100,'Object'})
	       
	    else
	       worlds[overworld[i][n]][1][horizontaltiles]=33
	       table.insert(Objects[overworld[i][n]],{768,32,32,640-64,'Object'})
	    end	
	 end
      end
   end

return gatedworlds
end



--creates of blob for random patches. typeblob 0 is a veritcal  patch typeblob 1 horizantal for nice looking round blobs call createblob twice once vertical once horizontal 
function createblob(world,m,typeblob,length,width,x,y,typebush)
   if typeblob ==0 then
      for n=0,length-1 do
	 for i=0,math.random(0,width-1) do
	    world[n+y][x+i]=typebush
	    table.insert(Objects[m],{(x+i-1)*tilesize,(n+y-1)*tilesize,32,32,'Object'})
	 end
	 for i=0,math.random(0,width-1) do
	    world[n+y][x-i]=typebush
	    table.insert(Objects[m],{(x-i-1)*tilesize,(n+y-1)*tilesize,32,32,'Object'})
	 end	 
      end
   elseif typeblob==1 then
      for n=0,length-1 do
	 for i=0,math.random(0,width-1) do
	    world[y+i][n+x]=typebush
	    table.insert(Objects[m],{(x+n-1)*tilesize,(y+i-1)*tilesize,32,32,'Object'})
	 end
	 for i=0,math.random(0,width-1) do
	    world[y-i][n+x]=typebush
	    table.insert(Objects[m],{(x+n-1)*tilesize,(y-i-1)*tilesize,32,32,'Object'})
	 end	 
      end
   end

return world
end
   
function addbushes(world,m,width,length,typebush)
   if math.random(1,2)==1 then x=math.random(width+2,10)
   else x=math.random(16,horizontaltiles-width-length-1) end
   if math.random(1,2)==1 then y=math.random(width+2,10)
   else y=math.random(13,verticaltiles-length-width-1) end
   world=createblob(world,m,0,length,width,x,y,typebush)
   world=createblob(world,m,1,length,width,x,y,typebush)
return world
end   

function add32x32(world,m,tiletype)
   x=math.random(2,horizontaltiles-1)
   y=math.random(2,verticaltiles-1)
   if inlist(world[y][x],forbiddentiles) then world=add32x32(world,m,tiletype) 
   else
      world[y][x]=tiletype
      if m~=0 then
	 table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Object'})
      end
   end
return world
end


function add64x64(world,m,tiletype)
   x=math.random(3,horizontaltiles-3)
   y=math.random(3,verticaltiles-3)
   if inlist(world[y][x],forbiddentiles) or inlist(world[y+1][x],forbiddentiles) or inlist(world[y+1][x+1],forbiddentiles) or inlist(world[y][x+1],forbiddentiles) then
      world=add64x64(world,m,tiletype)--if not possible to place tile try again
   else
      world[y][x]=tiletype
      world[y][x+1]=-1
      world[y+1][x+1]=-1
      world[y+1][x]=-1
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,64,64,'Object'})
   end
    
return world
end

function addwater(world,m)
   lx=math.random(3,19)
   ly=math.random(3,13)
   rx=math.random(lx+4,23) 
   ry=math.random(ly+4,17)
   table.insert(Objects[m],{(lx-1)*tilesize,(ly-1)*tilesize,(rx-lx+1)*tilesize,(ry-ly+1)*tilesize,'Object'})
   for n=lx,rx do
      for i=ly,ry do
	 if i==ly then
	    if n==lx then world[i][n]=25 --lefttopcorner
	    elseif n==rx then world[i][n]=26 --righttopcorner
	    else world[i][n]=22 end --top edge
	 elseif i==ry then
	    if n==lx then world[i][n]=27 --leftbottomcorner
	    elseif n==rx then world[i][n]=28 --rightbottomcorner
	    else world[i][n]=21 end --bottom edge
	 elseif n==lx then world[i][n]=23 --left edge
	 elseif n==rx then world[i][n]=24 --rightedge
	 else world[i][n]=math.random(18,19) end
      end
   end
return world
end


function addcliff(world,m)
   numberofcliffs=math.random(0,2)
   if numberofcliffs==0 or numberofcliffs==2 then
      for i=2,horizontaltiles-1 do
	 world[8][i]=17
	 world[9][i]=16
      end
      walkway=math.random(5,horizontaltiles-5)
      world[7][walkway]=-1
      world[8][walkway]=73
      world[9][walkway]=-1
      world[10][walkway]=-1
      world[7][walkway+1]=-1
      world[8][walkway+1]=-1
      world[9][walkway+1]=-1
      world[10][walkway+1]=-1
     

      table.insert(Objects[m],{32,7*tilesize+8,walkway*tilesize-64,15,'Object'})
      table.insert(Objects[m],{walkway*tilesize+32,7*tilesize+8,800-walkway*tilesize-64,15,'Object'})
   end
   if numberofcliffs==1 or numberofcliffs==2 then
      for i=2,horizontaltiles-1 do
	 world[13][i]=17
	 world[14][i]=16
      end
      walkway=math.random(5,horizontaltiles-5)
      world[12][walkway]=-1
      world[13][walkway]=73
      world[14][walkway]=-1
      world[15][walkway]=-1
      world[12][walkway+1]=-1 
      world[13][walkway+1]=-1
      world[14][walkway+1]=-1
      world[15][walkway+1]=-1
      table.insert(Objects[m],{32,12*tilesize+8,walkway*tilesize-64,15,'Object'})
      table.insert(Objects[m],{walkway*tilesize+32,12*tilesize+8,800-walkway*tilesize-64,15,'Object'})      
   end

return world
end



function grassworld(world,m)
   --add bushes
   for i=1,math.random(4,8) do
      world=addbushes(world,m,2,math.random(1,3),math.random(12,15))
   end
   --trees
   for i=1,math.random(6,9) do
      world=add64x64(world,m,29)
   end

return world
end

function cliffworld(world,m)
   
   --for small bushes
   for i=1,math.random(5,15) do
      world=add32x32(world,0,math.random(45,46))
   end
   --for cliff
   world=addcliff(world,m)
   
   --for tree
   for i=1,math.random(1,2) do
      world=add64x64(world,m,29)
   end
return world
end

function waterworld(world,m)
   --for small bushes
   for i=1,math.random(5,15) do
      world=add32x32(world,0,math.random(45,46))
   end
   
   --water
   world=addwater(world,m)

   --trees
   for i=1,math.random(1,5) do
      world=add64x64(world,m,29)
   end

return world
end

function villageworld(world,m)
   aaa=10
   for i=2,18 do
      world[aaa][i]= math.random(50,54)
      aaa=aaa+math.random(-1,1)
      world[aaa][i]= math.random(50,54)
   end
   world=buildhouse(world,1,m,3,3)
   world=buildhouse(world,2,m,8,3)
   world=buildhouse(world,3,m,15,3)
   world=buildhouse(world,4,m,22,3)
   world=buildhouse(world,5,m,15,8)
   world=buildhouse(world,6,m,22,8)
return world
end

function hermitworld(world,m)   
   world=buildhouse(world,math.random(1,6),m,math.random(3,20),math.random(3,10))
   world=addscenery(world,math.random(61,65),m,math.random(3,20),math.random(11,16))
   for i=1,math.random(3,9) do
      world=add64x64(world,m,29)
   end
   --for small bushes
   for i=1,math.random(5,9) do
      world=add32x32(world,0,math.random(45,46))
   end

return world
end

function buildhouse(world,typehouse,m,x,y)
   if typehouse==1 then
      for i=0,2 do
	 for n=0,2 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=39
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,64,55,'Object'})
      --door
      table.insert(Objects[m],{(x-1)*tilesize+22,(y-1)*tilesize+50,20,20,'Door'})
      xoutside=(x-1)*tilesize+22
      youtside=(y-1)*tilesize+50+40
   end
   
   if typehouse==2 then
      for i=0,4 do
	 for n=0,2 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=40
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,116,64,'Object'})
      --door
      table.insert(Objects[m],{(x-1)*tilesize+22,(y-1)*tilesize+60,20,20,'Door'})
      xoutside=(x-1)*tilesize+22
      youtside=(y-1)*tilesize+60+40
   end
   
   if typehouse==3 then
      for i=0,3 do
	 for n=0,2 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=41
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,80,56,'Object'})
      --door
      table.insert(Objects[m],{(x-1)*tilesize+30,(y-1)*tilesize+55,20,20,'Door'})
      xoutside=(x-1)*tilesize+30
      youtside=(y-1)*tilesize+55+40
   end

   
   if typehouse>3 then
      for i=0,3 do
	 for n=0,3 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=38+typehouse
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,64,42,'Object'})
      --door
      table.insert(Objects[m],{(x-1)*tilesize+22,(y-1)*tilesize+40,20,20,'Door'})
      xoutside=(x-1)*tilesize+22
      youtside=(y-1)*tilesize+40+40
   end
   x=math.random(66,69)
   worlds[m+numberofworlds]=x
   addObjectshouse(m,x,xoutside,youtside)
   return world
end



function addweapons(worlds)
--bettersword
   worlds=addweapon(worlds,1,'bettersword')

--boomerang
   worlds=addweapon(worlds,1,'boomerangitem')


return worlds
end

function addweapon(worlds,v,weapon)
   x=math.random(2,horizontaltiles-1)
   y=math.random(2,verticaltiles-1)
      
   if worlds[v][y][x]>10 or worlds[v][y][x]<1 then addweapon(worlds,v,weapon)--only on grass
   else 
      table.insert(Objects[v],{(x-1)*tilesize,(y-1)*tilesize,32,32,weapon})
   end
return worlds
end

function addchests(worlds)
   for n=1,4 do
      v=math.random(1,numberofworlds)
      worlds=addchest(worlds,v)
   end
return worlds
end


function addchest(worlds,world,iteminchest)
   x=math.random(2,horizontaltiles-1)
   y=math.random(2,verticaltiles-1)
   if worlds[v+numberofworlds]~=nil then --place in houses
      table.insert(Objects[v+numberofworlds],{310,310,32,32,'Chest'})
   elseif worlds[v][y][x]>10 or worlds[v][y][x]<1 then addchest(worlds,world,iteminchest)--only place keys on grass
   else 
      table.insert(Objects[v],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Chest'})
   end

return worlds
end

function testworld(world,m)
   y=10
   x=10
   for i=0,2 do
      for n=0,2 do
	 world[y+n][x+i]=-1
      end
   end
   world[y][x]=65
   table.insert(Objects[m],{(x-1)*tilesize+10,(y-1)*tilesize,40,36,'Object'})
return world
end

function addscenery(world,object,m,x,y)
   if object==61 then
      for i=0,1 do
	 for n=0,1 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=object
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,38,38,'Object'})
      table.insert(Objects[m],{(x-1)*tilesize+38,(y-1)*tilesize,26,10,'Object'})
   elseif object==62 then
      world[y][x]=object
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Object'})  
   elseif object==63 then
      for i=0,1 do
	 for n=0,0 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=object
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,44,32,'Object'})
   elseif object==64 then
      for i=0,1 do
	 for n=0,1 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=object
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,56,36,'Object'})
   elseif object==65 then
      for i=0,2 do
	 for n=0,2 do
	    world[y+n][x+i]=-1
	 end
      end
      world[y][x]=object
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,40,36,'Object'})

   end


return world
end

function addObjectshouse(m,x,xoutside,youtside)
   Objects[m+numberofworlds]={}
   --Walls
   --Top
   table.insert(Objects[m+numberofworlds],{280,224,240,20,'Object'})
   --Down
   table.insert(Objects[m+numberofworlds],{280,355,240,20,'Object'})
   --Left
   table.insert(Objects[m+numberofworlds],{280,244,25,131,'Object'})
   --Rights
   table.insert(Objects[m+numberofworlds],{495,244,25,131,'Object'})
   --Door
   table.insert(Objects[m+numberofworlds],{390,354,20,15,'Door2',xoutside+10,youtside})
end

function addspawns(world,m)
	Spawnpoints[m]={}
   for i=1,10 do
      addspawn(world,m)
   end
end

function addspawn(world,m)
   x=math.random(3,23)
   y=math.random(3,17)
   if world[y][x]<10 and world[y][x]>0 then
      table.insert(Spawnpoints[m],{x,y})
   else
      addspawn(world,m)
   end
end

function buildcave(world,m,x,y)
   for i=0,3 do
      for n=0,3 do
	 world[y+n][x+i]=-1
      end
   end
   world[y][x]=95
   table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,64,42,'Object'})
   --door
   table.insert(Objects[m],{(x-1)*tilesize+22,(y-1)*tilesize+40,20,20,'Door'})
   xoutside=(x-1)*tilesize+22
   youtside=(y-1)*tilesize+40+40 
   worlds[m+numberofworlds]=94
   addObjectshouse(m,x,xoutside,youtside)
   return world
end

function zeldaworld(world,m)  
   for i=0,10 do
      for n=0,6 do
	 world[6+n][8+i]=-1
      end
   end
   world[6][8]=97
   table.insert(Objects[m],{(8-1)*tilesize+20,(6-1)*tilesize+2,300,130,'Object'})
   table.insert(Objects[m],{(8-1)*tilesize+3,(6-1)*tilesize+120,95,78,'Object'})
   table.insert(Objects[m],{(8-1)*tilesize+244,(6-1)*tilesize+120,95,78,'Object'})
   --door
   table.insert(Objects[m],{(8-1)*tilesize+155,(6-1)*tilesize+126,35,22,'Door'})
   worlds[m+numberofworlds]=96

   Objects[m+numberofworlds]={}
   table.insert(Objects[m+numberofworlds],{250,60,278,15,'Object'})
   table.insert(Objects[m+numberofworlds],{250,60,30,190,'Object'})
   table.insert(Objects[m+numberofworlds],{500,60,30,190,'Object'})
   table.insert(Objects[m+numberofworlds],{250,225,60,190,'Object'})
   table.insert(Objects[m+numberofworlds],{470,225,60,190,'Object'})
   table.insert(Objects[m+numberofworlds],{250,360,280,30,'Object'})
   table.insert(Objects[m+numberofworlds],{370,354,40,15,'Door2',(8-1)*tilesize+180,(6-1)*tilesize+175})

return world
end


function swordworld(world,m)   
   world=buildcave(world,m,math.random(3,20),math.random(3,10))
   
   for i=1,math.random(3,9) do
      world=add64x64(world,m,29)
   end
   --for small bushes
   for i=1,math.random(5,9) do
      world=add32x32(world,0,math.random(45,46))
   end
   table.insert(Objects[m+numberofworlds],{384,260,32,32,'bettersword'})
return world
end


function boomerangworld(world,m)   
   world=buildcave(world,m,math.random(3,20),math.random(3,10))
   
   for i=1,math.random(3,9) do
      world=add64x64(world,m,29)
   end
   --for small bushes
   for i=1,math.random(5,9) do
      world=add32x32(world,0,math.random(45,46))
   end
   table.insert(Objects[m+numberofworlds],{384,260,32,32,'boomerangitem'})
return world
end
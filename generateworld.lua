require('util')

function loadtiles()
   images = {}
   for i=0,9 do
      images[i+1] = love.graphics.newImage("tiles/grass/grass" .. tostring(i) .. ".png")
   end
   images[11]=love.graphics.newImage("sprites/wall.gif")
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
   images[38]=love.graphics.newImage("tiles/bushes/small_bush.png")

   --here the list of tiles which cannot be drawnover
   forbiddentiles={-1,18,19,20,21,22,23,24,25,26,27,28,29}
end


--creates an array of worlds
function createworlds() 
   worlds = {}
   for m=1,numberofworlds do
      worlds[m]=createworld(m)
   end
   gatedworlds= buildgates(worlds)
return gatedworlds
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
   worldtype=math.random(1,3)
   if worldtype==1 then
      world=grassworld(world,m)
   elseif worldtype==2 then
      world=cliffworld(world,m)
   elseif worldtype==3 then
      world=waterworld(world,m)
   end
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
	 if count==numberofworlds then break end
	 for n=1, sizeoverworld[2]do
	    if count==numberofworlds then break end
	    if overworld[i][n]==0 then
	       x=0
	       if overworld[i-1][n]~=0 then x=x+1 end
	       if overworld[i+1][n]~=0 then x=x+1 end
	       if overworld[i][n-1]~=0 then x=x+1 end
	       if overworld[i][n+1]~=0 then x=x+1 end
	       if x~=0 then
		  if math.random()<(0.42/x) then
		     overworld[i][n]=count
		     count=count+1
		  end
	       end
	    end
	 end
      end
      if count==numberofworlds then break end
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
          table.insert(Objects[overworld[i][n]],{336,0,128,34,'North'})
	    else
	       worlds[overworld[i][n]][1][1]=31
	    end
	    --add south gate
	    if overworld[i+1][n]~=0 then
	       worlds[overworld[i][n]][verticaltiles][1]=34
          table.insert(Objects[overworld[i][n]],{336,572,128,34,'South'})
	    else
	       worlds[overworld[i][n]][verticaltiles][1]=30
	    end
	    --add west gate
	    if overworld[i][n-1]~=0 then
	       worlds[overworld[i][n]][2][1]=36
          table.insert(Objects[overworld[i][n]],{0,268,34,128,'West'})
	    else
	       worlds[overworld[i][n]][2][1]=32
	    end	    
	    --add east gate
	    if overworld[i][n+1]~=0 then
	       worlds[overworld[i][n]][1][horizontaltiles]=37
          table.insert(Objects[overworld[i][n]],{768,268,34,128,'East'})
	    else
	       worlds[overworld[i][n]][1][horizontaltiles]=33

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
   else
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
   x=math.random(width+1,horizontaltiles-width-length-1)
   y=math.random(width+1,verticaltiles-length-width-1)
   world=createblob(world,m,0,length,width,x,y,typebush)
   world=createblob(world,m,1,length,width,x,y,typebush)
return world
end   

function add32x32(world,m,tiletype)
   x=math.random(2,horizontaltiles-1)
   y=math.random(2,verticaltiles-1)
   world[y][x]=tiletype
   if m~=0 then
      table.insert(Objects[m],{(x-1)*tilesize,(y-1)*tilesize,32,32,'Object'})
   end
return world
end


function add64x64(world,m,tiletype)
   x=math.random(2,horizontaltiles-2)
   y=math.random(2,verticaltiles-2)
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
      world[8][walkway]=1
      world[9][walkway]=1
      world[8][walkway+1]=1
      world[9][walkway+1]=1
      table.insert(Objects[m],{32,7*tilesize+8,walkway*tilesize-64,15,'Object'})
      table.insert(Objects[m],{walkway*tilesize+32,7*tilesize+8,800-walkway*tilesize-64,15,'Object'})
   end
   if numberofcliffs==1 or numberofcliffs==2 then
      for i=2,horizontaltiles-1 do
	 world[13][i]=17
	 world[14][i]=16
      end
      walkway=math.random(5,horizontaltiles-5)
      world[13][walkway]=1
      world[14][walkway]=1
      world[13][walkway+1]=1
      world[14][walkway+1]=1
      table.insert(Objects[m],{32,12*tilesize+8,walkway*tilesize-64,15,'Object'})
      table.insert(Objects[m],{walkway*tilesize+32,12*tilesize+8,800-walkway*tilesize-64,15,'Object'})      
   end

return world
end



function grassworld(world,m)
   --add bushes
   for i=1,math.random(1,3) do
      world=addbushes(world,m,3,math.random(1,4),math.random(12,15))
   end
   --trees
   for i=1,math.random(1,9) do
      world=add64x64(world,m,29)
   end

return world
end

function cliffworld(world,m)
   
   --for small bushes
   for i=1,math.random(5,15) do
      world=add32x32(world,0,38)
   end
   --for cliff
   world=addcliff(world,m)
return world
end

function waterworld(world,m)
   --for small bushes
   for i=1,math.random(5,15) do
      world=add32x32(world,0,38)
   end
   
   --water
   world=addwater(world,m)

   --trees
   for i=1,math.random(1,5) do
      world=add64x64(world,m,29)
   end

return world
end
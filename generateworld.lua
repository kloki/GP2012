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

end



--creates an array of worlds
function createworlds() 
   worlds = {}
   for m=1,numberofworlds do
      worlds[m]=createworld()
   end
   gatedworlds= buildgates(worlds)
return gatedworlds
end


--creates a world and adds environment
--world[verticaltiles][horizantaltiles]
function createworld()
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
   --add bushes
   for i=1,math.random(0,4) do
      world=addbushes(world)
   end
   -- add tree
   for i=1,math.random(0,4) do
      world=addtrees(world)
   end

   --add water
   if math.random()<0.2 then
      world=addwater(world)
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
   overworld[3][6]=1
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
	    else
	       worlds[overworld[i][n]][1][1]=31
	    end
	    --add south gate
	    if overworld[i+1][n]~=0 then
	       worlds[overworld[i][n]][verticaltiles][1]=34
	    else
	       worlds[overworld[i][n]][verticaltiles][1]=30
	    end
	    --add west gate
	    if overworld[i][n-1]~=0 then
	       worlds[overworld[i][n]][2][1]=36
	    else
	       worlds[overworld[i][n]][2][1]=32
	    end	    
	    --add east gate
	    if overworld[i][n+1]~=0 then
	       worlds[overworld[i][n]][1][horizontaltiles]=37
	    else
	       worlds[overworld[i][n]][1][horizontaltiles]=33

	    end	
	 end
      end
   end

return gatedworlds
end



--creates of blob for random patches. typeblob 0 is a veritcal  patch typeblob 1 horizantal 
function createblob(typeblob,height,width)
   blob={}
   if typeblob ==0 then
      for i=1,height do
	 blob[i]=math.random(1,width)
      end
   end
   if typeblob ==1 then
      for i=1,width do
	 blob[i]=math.random(1,height)
      end
   end
return blob
end
   
function addbushes(world)
   typebush=math.random(12,15)
   width=math.random(2,5)
   height=math.random(2,5)
   typeblob=math.random(0,1)
   patch=createblob(typeblob,height,width)
   locationbush={math.random(height+1,horizontaltiles-width-1),math.random(width+1,verticaltiles-height)-1}
   if typeblob ==0 then
      for n=1,height do
	 for i=1,patch[n]do
	    world[n+locationbush[2]][i + locationbush[1]-math.floor(i/2)]=typebush
	 end
      end
   else
      for n=1,width do
	 for i=1,patch[n]do
	    world[i + locationbush[2]-math.floor(i/2)][n+locationbush[1]]=typebush
	 end
      end
   end
return world
end   

function addtrees(world)
   x=math.random(2,horizontaltiles-2)
   y=math.random(2,verticaltiles-2)
   world[y][x]=29
   world[y][x+1]=-1
   world[y+1][x+1]=-1
   world[y+1][x]=-1
return world
end

function addwater(world)
   lx=math.random(3,19)
   ly=math.random(3,14)
   rx=math.random(lx+4,23) 
   ry=math.random(ly+4,18)
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
	 else world[i][n]=math.random(18,20) end
      end
   end
return world
end
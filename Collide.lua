require 'HardonCollider'
require 'util'
require 'objectHandling'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
   local Type_a = shape_a.Type
   local Type_b = shape_b.Type
   
   if Type_a == 'Link' or Type_b == 'Link' then
      if Type_b == 'Link' then 
	 shape_a,shape_b,Type_a,Type_b,mtv_x,mtv_y = shape_b,shape_a,Type_b,Type_a,-mtv_x,-mtv_y end
      if Type_b == 'Object' then Link:move(mtv_x,mtv_y)
      elseif Type_b == 'Portal' then
	 coor = {coor[1] + shape_b.iy, coor[2] + shape_b.ix}
	 currentworld = overworld[coor[1] ][coor[2] ]
	 knownmap[coor[1]][coor[2]]=1
	 Link:moveTo(388-shape_b.ix*358,305-shape_b.iy*270) --links new position translated from the center of the screen
      elseif Type_b == 'Foe' then
	 --damage
         if shape_a.hit <= 0 then
            shape_a.hit = cool_time --cooldown time
            if godmode then health=health-1 end
	    TEsound.play("sound-effects/Link_Hurt.wav","effect")
         end
         shape_a:move(mtv_x,mtv_y)
      elseif Type_b == "Gate" then
	 Link:move(mtv_x,mtv_y)
	 if inlist(shape_b.KeyType,inventory) then deleteObject('Gate',shape_b.location) else botsgate = true end
      elseif Type_b == "Key" then
	 table.insert(inventory,shape_b.key) 
	 deleteObject(shape_b.key,shape_b.location)
	 TEsound.play("sound-effects/Fanfare_Item.wav","effect")
      elseif Type_b == "bettersword" then
	 havebettersword=true
    swofo = true
	 damage=2
	 deleteObject("bettersword",shape_b.location)
	 TEsound.play("sound-effects/Fanfare_Item.wav","effect")
      elseif Type_b == "boomerangitem" then
	 haveboomerang=true
	 deleteObject("boomerangitem",shape_b.location)
	 TEsound.play("sound-effects/Fanfare_Item.wav","effect")
         foundboem = true
         fouboe = true
      elseif Type_b == "Heart" then
	      deleteObject("Heart",shape_b.location)
	 if health<8 then health=health+1 end
	 TEsound.play("sound-effects/Heart.wav","effect")
      elseif Type_b == "Door" then
	 currentworld=numberofworlds+currentworld
	 Link:moveTo(400,330)
	 TEsound.play("sound-effects/Door1.wav","effect")
      elseif Type_b == "Door2" then
	 currentworld=currentworld-numberofworlds
	 Link:moveTo(shape_b.returnlocation[1],shape_b.returnlocation[2])
	 TEsound.play("sound-effects/Door2.wav","effect")
      elseif Type_b == "Chest" then
	 table.insert(Objects[currentworld],{shape_b.location[1]+6,shape_b.location[2]+6,15,15,'Heart'})
	 modifyObject("Chest",shape_b.location,"OpenChest")
	 TEsound.play("sound-effects/Chest_Open.wav","effect")
      elseif Type_b == "Rupee" then
	 Rupees = Rupees+shape_b.value
	 shape_b.exist = false
	 Collider:remove(shape_b)
	 TEsound.play("sound-effects/Rupee.wav","effect")
      elseif Type_b == "Zelda" then
         shape_b:move(-1.2*mtv_x,-1.2*mtv_y)
         shape_b.dir = -shape_b.dir
         TEsound.play("sound-effects/Zelda_Laugh.wav","effect")
         win = true
         --WON!!!
      end
   elseif Type_a == 'Foe' or Type_b == 'Foe' then
      if Type_b == 'Foe' then 
	 shape_a,shape_b,Type_a,Type_b,mtv_x,mtv_y = shape_b,shape_a,Type_b,Type_a,-mtv_x,-mtv_y end
      shape_a.turnprob = 0
      if Type_b == 'Object' or Type_b ==  'Portal' then
         shape_a:move(1.2*mtv_x,1.2*mtv_y)
	 local r = math.random()
	 if r > 0.667 then shape_a.dir = {-shape_a.dir[1],-shape_a.dir[2]}
	 elseif r > 0.333 then shape_a.dir = {shape_a.dir[2],shape_a.dir[1]} 
	 else shape_a.dir = {-shape_a.dir[2],-shape_a.dir[1]} end
      elseif Type_b == 'Foe' then
         shape_a:move(mtv_x/2,mtv_y/2)
         shape_a.dir = {-shape_a.dir[1],-shape_a.dir[2]}
         shape_b:move(-mtv_x/2,-mtv_y/2)
         shape_b.dir = {-shape_b.dir[1],-shape_b.dir[2]}
      elseif Type_b == 'Sword' then
         enemyHit(shape_a)
         shape_a:move(mtv_x,mtv_y)
      elseif Type_b == 'Boomerang' then
         enemyHit(shape_a)
         shape_b:move(mtv_x,mtv_y)
         shape_b.dir = {-shape_b.dir[1],-shape_b.dir[2]}
      end
   elseif Type_a == 'Boomerang' or Type_b == 'Boomerang' then
      if Type_b == 'Boomerang' then 
         shape_a,shape_b,Type_a,Type_b,mtv_x,mtv_y = shape_b,shape_a,Type_b,Type_a,-mtv_x,-mtv_y end
      if Type_b == 'Object' or Type_b == 'Gate' or Type_b == 'Portal' then
         shape_a:move(mtv_x,mtv_y)
         shape_a.dir = {-shape_a.dir[1],-shape_a.dir[2]}
      end
   elseif Type_a == 'Zelda' or Type_b == 'Zelda' then
      if Type_b == 'Zelda' then 
         shape_a,shape_b,Type_a,Type_b,mtv_x,mtv_y = shape_b,shape_a,Type_b,Type_a,-mtv_x,-mtv_y end
      if Type_b == 'Object' or Type_b == 'Gate' or Type_b == 'Portal' then
         shape_a:move(1.2*mtv_x,1.2*mtv_y)
         shape_a.dir = -shape_a.dir
      end
	end
end

-- this is called when two shapes stop colliding
function collision_stop(dt, shape_a, shape_b)
   
end

function enemyHit(shape)
   if shape.hit <= 0 then
      shape.hit = cool_time --cooldown time
      shape.life = shape.life-damage
      if shape.life < 1 then 
         Collider:setGhost(shape)
         x,y = shape:bbox()
         if math.random()>0.6 then 
            if math.random()>0.8 then addRupee(x,y,'blue') 
            else addRupee(x,y,'green') end
         elseif math.random()>0.7 then
            table.insert(Objects[currentworld],{x+6,y+6,15,15,'Heart'})
            removeObjects()
            addObjects()
         end
         TEsound.play("sound-effects/Enemy_Kill.wav","effect")
      else
         TEsound.play("sound-effects/Enemy_Hit.wav","effect")
      end
   end
end

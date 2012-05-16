require 'HardonCollider'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	Type_a, ind_a = getType(shape_a)
	Type_b, ind_b = getType(shape_b)
	
	if Type_a == 'Link' or Type_b == 'Link' then
		if Type_b == 'Link' then 
			ind_a,ind_b,Type_a,Type_b,mtv_x,mtv_y = ind_b,ind_a,Type_b,Type_a,-mtv_x,-mtv_y end
		if Type_b == 'Object' then Link:move(mtv_x,mtv_y) end
		if Type_b == 'Portal' then
			local ix, iy
			if     ind_b == 'North' then ix,iy = 0,-1
			elseif ind_b == 'East' then ix,iy = 1,0
			elseif ind_b == 'South' then ix,iy = 0,1
			elseif ind_b == 'West' then ix,iy = -1,0 end
			coor = {coor[1] + iy, coor[2] + ix}
			currentworld = overworld[coor[1] ][coor[2] ]
			local dx,dy = xsprite,ysprite
			Link:moveTo(300,300)
		end
	end
end

-- this is called when two shapes stop colliding
function collision_stop(dt, shape_a, shape_b)

end

Directions = {'North','South','West','East'}

function getType(shape)
   if shape == Link then return 'Link', 0 end
	--if shape == Sword then return 'Sword', 0 end
   for i=1,#Object do
      if shape == Object[i] then return 'Object', i end
   end
	for i=1,#Directions do
		if shape == Portal[Directions[i]] then return 'Portal', Directions[i] end
	end
   --for i=1,#gorons do
   --   if shape == goron_bb[i] then return 'goron', i end
   --end
   --for i=1,#Portal do
   --   if shape == Portal[i] then return 'Portal', i end
   --end
   return nil, nil
end
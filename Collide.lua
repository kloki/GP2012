require 'HardonCollider'

function on_collision(dt, shape_a, shape_b, mtv_x, mtv_y)
	Type_a, ind_a = getType(shape_a)
	Type_b, ind_b = getType(shape_b)
	
	if Type_a == 'Link' or Type_b == 'Link' then
		if Type_b == 'Link' then 
			ind_a,ind_b,Type_a,Type_b,mtv_x,mtv_y = ind_b,ind_a,Type_b,Type_a,-mtv_x,-mtv_y end
		if Type_b == 'Object' then Link:move(mtv_x,mtv_y)
		elseif Type_b == 'Portal' then
			local ix, iy
			local ox,oy = Link:bbox()
			if     ind_b == 'North' then ix,iy,spx,spy = 0,-1,ox,640-64
			elseif ind_b == 'East' then ix,iy,spx,spy = 1,0,32,oy
			elseif ind_b == 'South' then ix,iy,spx,spy = 0,1,ox,32
			elseif ind_b == 'West' then ix,iy,spx,spy = -1,0,800-64,oy end
			coor = {coor[1] + iy, coor[2] + ix}
			currentworld = overworld[coor[1] ][coor[2] ]
			Link:moveTo(spx,spy)
		elseif Type_b == 'Foe' then
         LinkHit = true
         Link:move(mtv_x,mtv_y)
         --get the normal vector in direction of the enemy
         nv = {mtv_x/( math.sqrt(mtv_x^2 + mtv_y^2)),mtv_y/( math.sqrt(mtv_x^2 + mtv_y^2))}
         Link:move(40*nv[1],40*nv[2])
		end
	elseif Type_a == 'Foe' or Type_b == 'Foe' then
		if Type_b == 'Foe' then 
			ind_a,ind_b,Type_a,Type_b,mtv_x,mtv_y = ind_b,ind_a,Type_b,Type_a,-mtv_x,-mtv_y end
      if Type_b == 'Object' or 'Portal' then
         Foes[ind_a]:move(1.2*mtv_x,1.2*mtv_y)
			local r = math.random()
			if r > 0.667 then Foes[ind_a].dir = {-Foes[ind_a].dir[1],-Foes[ind_a].dir[2]}
			elseif r > 0.333 then Foes[ind_a].dir = {Foes[ind_a].dir[2],Foes[ind_a].dir[1]} 
			else Foes[ind_a].dir = {-Foes[ind_a].dir[2],-Foes[ind_a].dir[1]} end
      elseif Type_b == 'Foe' then
         Foes[ind_a]:move(-mtv_x/2,-mtv_y/2)
         Foes[ind_a].dir = {-Foes[ind_a].dir[1],-Foes[ind_a].dir[2]}
         Foes[ind_b]:move(-mtv_x/2,-mtv_y/2)
         Foes[ind_b].dir = {-Foes[ind_b].dir[1],-Foes[ind_b].dir[2]}
		elseif Type_b == 'Sword' then
			test_output = 'got here'
			--remove foes
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
	for k,v in pairs(Foes) do
      if shape == v then return 'Foe',k end
   end
	if shape == Sword then return 'Sword', 0 end
   return nil, nil
end
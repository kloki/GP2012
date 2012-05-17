require 'HardonCollider'

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
			Link:moveTo(388-shape_b.ix*358,305-shape_b.iy*270) --links new position translated from the center of the screen
		elseif Type_b == 'Foe' then
		   LinkHit = true
		   --damage
		   health=health-1
		   if health <1 then health = 1 end--for nothing if Link dies
		   shape_a:move(mtv_x,mtv_y)
		   --get the normal vector in direction of the enemy
		   nv = {mtv_x/( math.sqrt(mtv_x^2 + mtv_y^2)),mtv_y/( math.sqrt(mtv_x^2 + mtv_y^2))}
		   shape_a:move(40*nv[1],40*nv[2])
		end
	elseif Type_a == 'Foe' or Type_b == 'Foe' then
		if Type_b == 'Foe' then 
			shape_a,shape_b,Type_a,Type_b,mtv_x,mtv_y = shape_b,shape_a,Type_b,Type_a,-mtv_x,-mtv_y end
      if Type_b == 'Object' or 'Portal' then
         shape_a:move(1.2*mtv_x,1.2*mtv_y)
			local r = math.random()
			if r > 0.667 then shape_a.dir = {-shape_a.dir[1],-shape_a.dir[2]}
			elseif r > 0.333 then shape_a.dir = {shape_a.dir[2],shape_a.dir[1]} 
			else shape_a.dir = {-shape_a.dir[2],-shape_a.dir[1]} end
      elseif Type_b == 'Foe' then
         shape_a:move(-mtv_x/2,-mtv_y/2)
         shape_a.dir = {-shape_a.dir[1],-shape_a.dir[2]}
         shape_b:move(-mtv_x/2,-mtv_y/2)
         shape_b.dir = {-shape_b.dir[1],-shape_b.dir[2]}
		elseif Type_b == 'Sword' then
			test_output = 'got here'
			--remove foes
      end
	end
end

-- this is called when two shapes stop colliding
function collision_stop(dt, shape_a, shape_b)

end
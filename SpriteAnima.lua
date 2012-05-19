require ('lAnA')
function loadSprites()
   sheet = love.graphics.newImage("sprites/LinkMC1test.gif")

   linkdownS = love.graphics.newQuad(24,12,20,32,720,1024)
   linkleftS = love.graphics.newQuad(24,44,20,30,720,1024)
   linkupS = love.graphics.newQuad(25,80,20,30,720,1024)
   linkleftS:flip(true,false)
   linkrightS = love.graphics.newQuad(24,44,20,30,720,1024)
    
   linkdownRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12,false)
   linkrightRun = newAnimation(sheet,27,32,0.1,10,52,44,false)
   linkupRun = newAnimation(sheet,23,32,0.1,10,61,80,false)
   linkleftRun = newAnimation(sheet,27,32,0.1,10,52,44,true)
   
   linkdownSword = newAnimation(sheet,32,38,0.1,7,20,130,false)
   linkrightSword = newAnimation(sheet,38,38,0.1,7,9,174,false)
   linkupSword = newAnimation(sheet,32,40,0.1,7,12,215,false)
   linkleftSword = newAnimation(sheet,38,38,0.1,7,9,174,true)
   linkdownSword:setMode("once")
   linkupSword:setMode("once")
   linkrightSword:setMode("once")
   linkleftSword:setMode("once")
	
	goron_sheet = love.graphics.newImage("sprites/goron.png")
   goron_sheet2 = love.graphics.newImage("sprites/goronfront.png")
   goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
	goronrightRun = newAnimation(goron_sheet,24,30,0.1,8,92,158,false)
	goronleftRun  = newAnimation(goron_sheet,24,30,0.1,8,92,158,true)
	goronupRun    = newAnimation(goron_sheet,30.5,30,0.15,7,82,89,false)
	gorondownRun  = newAnimation(goron_sheet2,29,30,0.1,8,0,0,false)
   
   snake_sheet = love.graphics.newImage("sprites/snake.png")
   snakeleft  = newAnimation(snake_sheet,24,16,0.1,4,2, 3,false)
   snakeright = newAnimation(snake_sheet,24,16,0.1,4,2,25,false)
   snakedown  = newAnimation(snake_sheet,22,16,0.1,4,4,46,false)
   snakeup    = newAnimation(snake_sheet,22,16,0.1,4,4,68,false)
   snakeleft:setMode("bounce")
   snakeright:setMode("bounce")
   snakedown:setMode("bounce")
   snakeup :setMode("bounce")
   --
   sprite = 'standdown'
   Link.heading = 'down'
   move = false
end

function drawSprite()
	local x,y = Link:bbox()
   --love.graphics.drawq(sheet,linkdownS,x,y)
   if sprite == 'moveup' then
      linkupRun:draw(x,y)
   elseif sprite == 'movedown' then
      linkdownRun:draw(x,y)
   elseif sprite == 'moveright' then

      linkrightRun:draw(x,y)
   elseif sprite == 'moveleft' then
      linkleftRun:draw(x,y)

   elseif sprite == 'swordup' then
      linkupSword:draw(x,y)
   elseif sprite == 'sworddown' then
      linkdownSword:draw(x,y)
   elseif sprite == 'swordright' then
      linkrightSword:draw(x,y)
   elseif sprite == 'swordleft' then
      linkleftSword:draw(x,y)

   elseif sprite == 'standup' then
      love.graphics.drawq(sheet,linkupS,x,y)
   elseif sprite == 'standright' then
      love.graphics.drawq(sheet,linkrightS,x,y)
   elseif sprite == 'standleft' then
      love.graphics.drawq(sheet,linkleftS,x,y)
   elseif sprite == 'standdown' then
      love.graphics.drawq(sheet,linkdownS,x,y)
   end      
end

function updateSprite(dt)
   u = love.keyboard.isDown("up")
   d = love.keyboard.isDown("down")
   r = love.keyboard.isDown("right")
   l = love.keyboard.isDown("left")
   --s = love.keyboard.isDown(" ")
   --b = love.keyboard.isDown("lctrl")
   -- hier logica
   if u or d or r or l then
      move = true
   else
      move = false
   end


   if spressed then
      move = false
      if Link.heading == 'down' then
         linkdownSword:update(dt)
         sprite = 'sworddown'
         if linkdownSword:getCurrentFrame() == 7 then
            spressed = false
            linkdownSword:reset()
         end
      elseif Link.heading == 'up' then
         linkupSword:update(dt)
         sprite = 'swordup'
         if linkupSword:getCurrentFrame() == 7 then
            spressed = false
            linkupSword:reset()
         end
      elseif Link.heading == 'right' then
         linkrightSword:update(dt)
         sprite = 'swordright'
         if linkrightSword:getCurrentFrame() == 7 then
            spressed = false
            linkrightSword:reset()
            sprite = 'standright'
         end
      elseif Link.heading == 'left' then
         linkleftSword:update(dt)
         sprite = 'swordleft'
         if linkleftSword:getCurrentFrame() == 7 then
            spressed = false
            linkleftSword:reset()
         end
      end
   elseif move then
      if u then
         linkupRun:update(dt)
         sprite = 'moveup'
         Link.heading = 'up'
      end
      if d then
         linkdownRun:update(dt)
         sprite = 'movedown'
         Link.heading = 'down'
      end
      if r then
         linkrightRun:update(dt)
         sprite = 'moveright'
         Link.heading = 'right'
      end
      if l then
         linkleftRun:update(dt)
         sprite = 'moveleft'
         Link.heading = 'left'
      end
      if (u and r) or (u and l) then
         linkupRun:update(dt)
         sprite = 'moveup'
         Link.heading = 'up'
      end
      if (d and r) or (d and l) then
         linkdownRun:update(dt)
         sprite = 'movedown'
         Link.heading = 'down'
      end
      if u and d then
         sprite = 'standdown'
      end
      if r and l then
         sprite = 'standdown'
      end
   else
      if Link.heading == 'down' then
         sprite = 'standdown'
      elseif Link.heading == 'up' then
         sprite = 'standup'
      elseif Link.heading == 'right' then
         sprite = 'standright'
      elseif Link.heading == 'left' then
         sprite = 'standleft'
      end
   end

end

function drawFoes(dt)
   local x,y
   for i, v in ipairs(Foes) do
      x,y = v:bbox()
      --love.graphics.drawq(goron_sheet,goronfrontS,x,y)
      if Foes[i].life > 0 then
         if Foes[i].sprite == 'goron' then
            if 	 Foes[i].dir[2] == 1  then gorondownRun:draw(x,y)
            elseif Foes[i].dir[2] == -1 then goronupRun:draw(x,y)
            elseif Foes[i].dir[1] == 1  then goronrightRun:draw(x,y)
            elseif Foes[i].dir[1] == -1 then goronleftRun:draw(x,y) end
         elseif Foes[i].sprite == 'snake' then
            if 	 Foes[i].dir[2] == 1  then snakedown:draw(x,y)
            elseif Foes[i].dir[2] == -1 then snakeup:draw(x,y)
            elseif Foes[i].dir[1] == 1  then snakeright:draw(x,y)
            elseif Foes[i].dir[1] == -1 then snakeleft:draw(x,y) end
         end
      end
   end
end

function updateFoes(dt)
	local x,y
	for i,v in ipairs(Foes) do
      if v.life > 0 then
         v:move(v.dir[1]*v.speed*dt,v.dir[2]*v.speed*dt)
      end
	end
	goronrightRun:update(dt)
	goronleftRun:update(dt)
	goronupRun:update(dt)
	gorondownRun:update(dt)
   snakeup:update(dt)
   snakedown:update(dt)
   snakeright:update(dt)
   snakeleft:update(dt)
end

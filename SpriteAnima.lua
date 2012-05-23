require ('lAnA')
function loadSprites()
   sheet = love.graphics.newImage("sprites/LinkMC1test.gif")
   sworddown = love.graphics.newImage("sprites/sworddown.png")
   swordright = love.graphics.newImage("sprites/swordright2.png")
   swordup = love.graphics.newImage("sprites/swordup.png")

   linkdownS = love.graphics.newQuad(24,12,20,32,720,1024)
   linkleftS = love.graphics.newQuad(24,44,20,30,720,1024)
   linkupS = love.graphics.newQuad(25,80,20,30,720,1024)
   linkleftS:flip(true,false)
   linkrightS = love.graphics.newQuad(24,44,20,30,720,1024)
    
   linkdownRun = newAnimation(sheet,23.5,32,0.1,10,59.5,12,false)
   linkrightRun = newAnimation(sheet,27,32,0.1,10,52,44,false)
   linkupRun = newAnimation(sheet,23,32,0.1,10,61,80,false)
   linkleftRun = newAnimation(sheet,27,32,0.1,10,52,44,true)
   
   linkdownSword = newAnimation(sworddown,50,50,0.06,8,1,1,false)
   linkrightSword = newAnimation(swordright,50,50,0.06,7,1,1,false)
   linkupSword = newAnimation(swordup,50,50,0.06,8,1,1,false)
   linkleftSword = newAnimation(swordright,50,50,0.06,7,1,1,true)
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
   
   green_rupee_sheet = love.graphics.newImage("tiles/objects/rupee_green.png")
   blue_rupee_sheet  = love.graphics.newImage("tiles/objects/rupee_blue.png")
   red_rupee_sheet   = love.graphics.newImage("tiles/objects/rupee_red.png")
   rupee_green = newAnimation(green_rupee_sheet,15,20,0.12,3,1,1)
   rupee_blue  = newAnimation(blue_rupee_sheet ,15,20,0.12,3,1,1)
   rupee_red   = newAnimation(red_rupee_sheet  ,15,20,0.12,3,1,1)
   
   dieAnim = newAnimation(snake_sheet,24,22,0.1,5,0,112,false)
   dieAnim:setMode("once")
   --
   sprite = 'standdown'
   Link.heading = 'down'
   move = false
end

function drawSprite()
	local x,y = Link:bbox()
	love.graphics.setColor(Link.color)
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
      linkupSword:draw(x-12,y-5)
   elseif sprite == 'sworddown' then
      linkdownSword:draw(x-14,y-10)
   elseif sprite == 'swordright' then
      linkrightSword:draw(x-5,y-7)
   elseif sprite == 'swordleft' then
      linkleftSword:draw(x-22,y-6)

   elseif sprite == 'standup' then
      love.graphics.drawq(sheet,linkupS,x,y)
   elseif sprite == 'standright' then
      love.graphics.drawq(sheet,linkrightS,x,y)
   elseif sprite == 'standleft' then
      love.graphics.drawq(sheet,linkleftS,x,y)
   elseif sprite == 'standdown' then
      love.graphics.drawq(sheet,linkdownS,x,y)
   end      
	love.graphics.setColor(255,255,255)
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
      elseif v.life == 0 then
         dieAnim:draw(x,y)
         if dieAnim:getCurrentFrame() == 5 then
            dieAnim:reset()
            v.life = -1
         end
      end
   end
end

function updateFoes(dt)
	local x,y
	for i,v in ipairs(Foes) do
      --walk in a random direction
      v.turnprob = math.min(v.turnprob + 0.001*dt,0.2)
      if math.random() < v.turnprob then
         if math.random() > 0.5 then
            v.dir = {v.dir[2],v.dir[1]}
         else
            v.dir = {-v.dir[2],-v.dir[1]}
         end
         v.turnprob = 0 --reset turn probability
      end
      --update movement
      if v.life > 0 then
         v:move(v.dir[1]*v.speed*dt,v.dir[2]*v.speed*dt)
      elseif v.life == 0 then
         dieAnim:update(dt)
      end
	end
   --update animations (for efficiency change this to updating only the used animations)
	goronrightRun:update(dt)
	goronleftRun:update(dt)
	goronupRun:update(dt)
	gorondownRun:update(dt)
   snakeup:update(dt)
   snakedown:update(dt)
   snakeright:update(dt)
   snakeleft:update(dt)
   rupee_green:update(dt)
   rupee_blue:update(dt)
   rupee_red:update(dt)   
end

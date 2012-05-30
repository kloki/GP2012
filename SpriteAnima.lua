require ('lAnA')
function loadSprites()
   --LINK
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

   --BOOMERANG
   boemerang = love.graphics.newImage("sprites/Boemerang.png")
   BoomerangAnim = newAnimation(boemerang,20,40,0.06,6,1,1,false)
   
   --SWORD
   sworddown = love.graphics.newImage("sprites/sworddown.png")
   swordright = love.graphics.newImage("sprites/swordright2.png")
   swordup = love.graphics.newImage("sprites/swordup2.png")

   linkdownSword = newAnimation(sworddown,50,50,0.06,8,1,1,false)
   linkrightSword = newAnimation(swordright,50,50,0.06,7,1,1,false)
   linkupSword = newAnimation(swordup,50,50,0.06,8,1,1,false)
   linkleftSword = newAnimation(swordright,50,50,0.06,7,1,1,true)
   linkdownSword:setMode("once")
   linkupSword:setMode("once")
   linkrightSword:setMode("once")
   linkleftSword:setMode("once")
   
   --link throwing boomerang
   linkdownBoomerang = newAnimation(sheet,27,30,0.08,6,31,599,false)
   linkrightBoomerang = newAnimation(sheet,30,30,0.08,6,212,599,false)
   linkleftBoomerang = newAnimation(sheet,30,30,0.08,6,212,599,true)
   linkupBoomerang = newAnimation(sheet,29,30,0.08,6,402,599,false)
   linkdownBoomerang:setMode("once")
   linkrightBoomerang:setMode("once")
   linkleftBoomerang:setMode("once")
   linkupBoomerang:setMode("once")
	
   --GORON
	goron_sheet = love.graphics.newImage("sprites/goron.png")
   goron_sheet2 = love.graphics.newImage("sprites/goronfront.png")
   goronfrontS = love.graphics.newQuad(162,12,26,30,368,448)
	goronrightRun = newAnimation(goron_sheet,24,30,0.1,8,92,158,false)
	goronleftRun  = newAnimation(goron_sheet,24,30,0.1,8,92,158,true)
	goronupRun    = newAnimation(goron_sheet,30.5,30,0.15,7,82,89,false)
	gorondownRun  = newAnimation(goron_sheet2,29,30,0.1,8,0,0,false)
   
   --SNAKE
   snake_sheet = love.graphics.newImage("sprites/snake.png")
   snakeleft  = newAnimation(snake_sheet,24,16,0.1,4,2, 3,false)
   snakeright = newAnimation(snake_sheet,24,16,0.1,4,2,25,false)
   snakedown  = newAnimation(snake_sheet,22,16,0.1,4,4,46,false)
   snakeup    = newAnimation(snake_sheet,22,16,0.1,4,4,68,false)
   snakeleft:setMode("bounce")
   snakeright:setMode("bounce")
   snakedown:setMode("bounce")
   snakeup :setMode("bounce")
   
   crow_sheet = love.graphics.newImage("sprites/crow.png")
   crowstill,crowleft,crowright = {},{},{}
   crowstill['blue'] = love.graphics.newQuad(1,1,20,18,100,37)
   crowstill['red']  = love.graphics.newQuad(1,19,20,18,100,37)
   crowleft['blue']  = newAnimation(crow_sheet,20,18,0.08,4,20,1,false)
   crowleft['red'] = newAnimation(crow_sheet,20,18,0.08,4,20,19,false)
   crowright['blue']  = newAnimation(crow_sheet,20,18,0.08,4,20,1,true)
   crowright['red'] = newAnimation(crow_sheet,20,18,0.08,4,20,19,true)
   crowleft['blue']:setMode("bounce")
   crowleft['red']:setMode("bounce")
   crowright['blue']:setMode("bounce")
   crowright['red']:setMode("bounce")
   
   green_rupee_sheet = love.graphics.newImage("tiles/objects/rupee_green.png")
   blue_rupee_sheet  = love.graphics.newImage("tiles/objects/rupee_blue.png")
   red_rupee_sheet   = love.graphics.newImage("tiles/objects/rupee_red.png")
   rupee_green = newAnimation(green_rupee_sheet,15,20,0.12,3,1,1)
   rupee_blue  = newAnimation(blue_rupee_sheet ,15,20,0.12,3,1,1)
   rupee_red   = newAnimation(red_rupee_sheet  ,15,20,0.12,3,1,1)
   
   dieAnim = newAnimation(snake_sheet,24,22,0.1,5,0,112,false)
   dieAnim:setMode("once")

   --SPECIAL
   alert = love.graphics.newImage("sprites/alert.png")
   
   --VARIABLES
   sprite = 'standdown'
   Link.heading = 'down'
   move = false
end

function drawSprite()
	local x,y = Link:bbox()
	love.graphics.setColor(Link.color)
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

   elseif sprite == 'boomerangdown' then
      linkdownBoomerang:draw(x,y)
   elseif sprite == 'boomerangright' then
      linkrightBoomerang:draw(x,y)
   elseif sprite == 'boomerangleft' then
      linkleftBoomerang:draw(x,y)
   elseif sprite == 'boomerangup' then
      linkupBoomerang:draw(x,y)
      
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
   local x,y = Link:bbox()
   xboem = x
   yboem = y

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
   elseif bpressed then
      if Link.heading == 'down' then
         linkdownBoomerang:update(dt)
         sprite = 'boomerangdown'
         if linkdownBoomerang:getCurrentFrame() == 6 then
            bpressed = false
            linkdownBoomerang:reset()
         end
      elseif Link.heading == 'right' then
         linkrightBoomerang:update(dt)
         sprite = 'boomerangright'
         if linkrightBoomerang:getCurrentFrame() == 6 then
            bpressed = false
            linkrightBoomerang:reset()
         end      
      elseif Link.heading == 'left' then
         linkleftBoomerang:update(dt)
         sprite = 'boomerangleft'
         if linkleftBoomerang:getCurrentFrame() == 6 then
            bpressed = false
            linkleftBoomerang:reset()
         end      
      elseif Link.heading == 'up' then
         linkupBoomerang:update(dt)
         sprite = 'boomerangup'
         if linkupBoomerang:getCurrentFrame() == 6 then
            bpressed = false
            linkupBoomerang:reset()
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
      love.graphics.setColor(v.color)
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
         elseif Foes[i].sprite == 'crow' then
            if     Foes[i].dir[1] == 0 and Foes[i].dir[2] == 0 then love.graphics.drawq(crow_sheet,crowstill[Foes[i].col],x,y)
            elseif Foes[i].dir[1] == -1 then crowleft[Foes[i].col]:draw(x,y)
            else crowright[Foes[i].col]:draw(x,y) end
         end
         if v.alert then
            love.graphics.draw(alert,x+10,y+10)
         end
      elseif v.life == 0 then
         dieAnim:draw(x,y)
         if dieAnim:getCurrentFrame() == 5 then
            dieAnim:reset()
            v.life = -1
         end
      end
      love.graphics.setColor(255,255,255)
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
         if v.hit > 0 then 
            v.hit = v.hit -1*dt
            if math.cos(v.hit*(1/0.1)*3.14) > 0 then
               v.color = {255,0,0}
            else
               v.color = {255,255,255}
            end
         else
            v.color = {255,255,255}
         end
      elseif v.life == 0 then
         v.color = {255,255,255}
         dieAnim:update(dt)
      end
      local Foe_x,Foe_y = v:bbox()
      local Link_x, Link_y = v:bbox()
      if ((Foe_x - Link_x)^2 + (Foe_y - Link_y)^2) < 20 then
         v.alert = true
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
   for _,color in pairs{'red','blue'} do
      crowleft[color]:update(dt)
      crowright[color]:update(dt)
   end   
   rupee_green:update(dt)
   rupee_blue:update(dt)
   rupee_red:update(dt)   
end

function drawWeapons()
   if Boomerang.active then BoomerangAnim:draw(Boomerang.x,Boomerang.y) end
end

function updateWeapons(dt)
   if Boomerang.active then 
      BoomerangAnim:update(dt) 
      Boomerang.x = Boomerang.x + Boomerang.speed*Boomerang.dir[1]*dt
      Boomerang.y = Boomerang.y + Boomerang.speed*Boomerang.dir[2]*dt
      Boomerang:moveTo(Boomerang.x+8,Boomerang.y+16)
   end
end
require ('lAnA')
function loadSprite()
    sheet = love.graphics.newImage("sprites/LinkMC2.gif")
    linkfrontS = love.graphics.newQuad(24,12,20,30,720,2630)
    linkfrontRun = newAnimation(sheet,24,32,0.1,10,56,12)
    
    linkfrontM = {}
    linkfrontM[1] = love.graphics.newQuad(59,12,23,32,720,2630)
    linkfrontM[2] = love.graphics.newQuad(82,12,23,32,720,2630)
    linkfrontM[3] = love.graphics.newQuad(107,12,22,32,720,2630)
    linkfrontM[4] = love.graphics.newQuad(130,12,22,32,720,2630)
    linkfrontM[5] = love.graphics.newQuad(153,12,22,32,720,2630)
    linkfrontM[6] = love.graphics.newQuad(176,12,22,32,720,2630)
    linkfrontM[7] = love.graphics.newQuad(131,12,22,32,720,2630)
    linkfrontM[8] = love.graphics.newQuad(131,12,22,32,720,2630)
    linkfrontM[9] = love.graphics.newQuad(131,12,22,32,720,2630)
    linkfrontM[10] = love.graphics.newQuad(131,12,22,32,720,2630)
    sp=linkfrontS
    
end

function drawSprite()
    linkfrontRun:draw(xplane,yplane)
    --love.graphics.drawq(sheet,sp, xplane, yplane)
    --love.graphics.drawq(sheet,linkfrontM[3], 200, 200)
    --love.graphics.drawq(sheet,linkfrontM[4], 100, 100)
    --love.graphics.drawq(sheet,linkfrontM[5], 10, 10)
    --love.graphics.drawq(sheet,linkfrontM[6], 100, 10)
end

function updateSprite(dt)
    linkfrontRun:update(dt)
end

-- Author: Flyboxx               --
-- Date: Dec/5/2014              --
-- Version: TEKKIT               --
-- Updated Jan/31/2017 to TEKKIT --

clearscr = function()
  term.clear()
  term.setCursorPos(1,1)
end

clearscr()

print("====== Farmer ======")
print("By Flyboxx")
print("Edited by RSK")

sleep(1)
clearscr()

-- Variables --

local args = {...}
farming = true
ystep = 1
xpos = 1
ypos = 0

-- Init --

-- Functions --

setPos = function(x, y)
  xpos = x
  ypos = y
end

returnHome = function()
  turtle.turnLeft()
  for i = 1, 9, 1 do
    turtle.forward()
  end
  turtle.turnLeft()
  for i = 1, 10, 1 do
    turtle.forward()
  end
  turtle.turnLeft()
  turtle.turnLeft()
end

clearInv = function()
  for i = 1,16,1 do
    turtle.select(i)
	if turtle.getItemCount(i) ~= 0 then
	  if turtle.compareTo(15) then
	    turtle.dropDown()
	  elseif turtle.compareTo(16) then
	    turtle.turnLeft()
	    turtle.drop()
	    turtle.turnRight()
	  else
	    turtle.turnLeft()
	    turtle.drop()
	    turtle.turnRight()
	  end
	end
  end
end

getFuel = function(arg1)
  if arg1 == "first" then
    print("Refueling...")
    turtle.turnRight()
    turtle.select(1)
    turtle.suck()
  end
  
  turtle.refuel(1)
  
  if turtle.getFuelLevel() < 99 then
    getFuel("notfirst")
  else
    turtle.drop()
	turtle.turnLeft()
  end
end

initFarm = function()
  clearInv()

  if turtle.getFuelLevel() < 99 then
    getFuel("first")
  end

  turtle.forward()
  setPos(1,1)
end

initPlant = function()
  clearInv()

  if turtle.getFuelLevel() < 99 then
    getFuel("first")
  end

  turtle.select(1)
  turtle.suckDown(64)
  turtle.select(2)
  turtle.suckDown(16)
  turtle.select(1)
  
  turtle.forward()
  setPos(1,1)
end

-- ==========*Till Program*========== --
till = function()
  initFarm()
  clearscr()
  print("Tilling...")
 
  while(farming) do
 
    turtle.digDown()
 
    if xpos == 5 and ypos == 10 then
      returnHome()
      clearInv()
      break
    end
 
    if ypos == 10
	then
      turtle.turnRight()
      turtle.forward()
      xpos = xpos + 1
      turtle.turnRight()
      turtle.digDown()
      ystep = -1
    end
 
 if ypos == 2 and xpos == 3 then 
	farming = false
	turtle.forward()
	ypos = ypos + 1
	farming = true
	end
	
	if ypos == 7 and xpos == 3 then 
	farming = false
	turtle.forward()
	ypos = ypos + 1
	farming = true
	end
 
    if ypos == 1 and xpos ~= 1 then
      turtle.turnLeft()
      turtle.forward()
      xpos = xpos + 1
      turtle.turnLeft()
      turtle.digDown()
      ystep = 1
    end
 
    turtle.forward()
    ypos = ypos + ystep
 
  end
end








-- ==========*Plant Program*========== --
plant = function()
  initPlant()
  clearscr()
  print("Planting...")
  
  while(farming) do

    turtle.placeDown()
	
	if turtle.getItemCount() == 0 then
	  turtle.select(turtle.getSelectedSlot() + 1)
	end
  
    if xpos == 5 and ypos == 10 then
      returnHome()
	  turtle.select(1)
	  sleep(450)
	  break
    end
  
    if ypos == 10 then
      turtle.turnRight()
	  turtle.forward()
	  xpos = xpos + 1
	  turtle.turnRight()
	  turtle.placeDown()
	  ystep = -1
    end
  

    if ypos == 1 and xpos ~= 1 then
      turtle.turnLeft()
	  turtle.forward()
	  xpos = xpos + 1
	  turtle.turnLeft()
	  turtle.placeDown()
	  ystep = 1
    end
  
    turtle.forward()
    ypos = ypos + ystep
  end
end

-- ==========*Harvest Program*========== --
harvest = function()
  initFarm()
  clearscr()
  print("Harvesting...")
  
  while(farming) do

    turtle.digDown()
  
    if xpos == 5 and ypos == 10 then
      returnHome()
	  clearInv()
	  turtle.select(1)
	  break
    end
  
    if ypos == 10 then
      turtle.turnRight()
	  turtle.forward()
	  xpos = xpos + 1
	  turtle.turnRight()
	  turtle.digDown()
	  ystep = -1
    end
  
  if ypos == 2 and xpos == 3 then 
	farming = false
	turtle.forward()
	ypos = ypos + 1
	farming = true
	end
	
	if ypos == 7 and xpos == 3 then 
	farming = false
	turtle.forward()
	ypos = ypos + 1
	farming = true
	end
	
    if ypos == 1 and xpos ~= 1 then
      turtle.turnLeft()
	  turtle.forward()
	  xpos = xpos + 1
	  turtle.turnLeft()
	  turtle.digDown()
	  ystep = 1
    end
	

	
    turtle.forward()
    ypos = ypos + ystep

  end
end



-- ==========*Main Program*========== --
till()
while(farming) do
  plant()
  harvest()
end
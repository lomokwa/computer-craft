-- Fuel check and refueling functions

function checkFuel()
  if turtle.getFuelLevel() < 10 then
    turtle.select(1);
    turtle.refuel(1);

    return true; 
  end

  if turtle.getItemCount(1) <= 5 then
    print("Running out of fuel! Getting more.");

    return false;
  end

end

function detectFuelChest()
  if not turtle.detectDown() then
    return false;
  end

  local success, data = turtle.inspect();
  if success and data.name == "minecraft:chest" then
    return true;
  end

  return false;
end

function getMoreFuel()
  if not checkFuel() then
    while not turtle.detectDown() do
      turtle.down();
    end

    turtle.turnLeft();

    while not turtle.detect() do
      turtle.forward();
    end

    turtle.turnLeft();
    
    while not turtle.detect() do
      turtle.forward();
    end
  end

  if detectFuelChest() then
    turtle.suck(1, 59)
    
    return true;
  end
end

-- Mining functions

function mine()
  while not checkFuel() do
    getMoreFuel();
  end

  if turtle.detect() do
    turtle.dig();
    turtle.turnRight();
  end


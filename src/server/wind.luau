local gustCycleDelay = 5  -- Max duration between gust cycles in seconds
local gustCycleDuration = 3.5  -- Duration of each gust cycle in seconds

-- During each gust cycle, a portion of "gust" will be added to "baseWind" in a ramped fashion
local baseWind = Vector3.new(5, 0, 2)  -- Base wind speed and direction
local gustIntervals = 100  -- Number of iterations used to calculate each gust interval
local dg = gustCycleDuration / gustIntervals
local dgf = dg / gustCycleDuration

-- Set global wind to base wind initially
workspace.GlobalWind = baseWind

-- Wait delay amount before starting gusts
task.wait(gustCycleDelay)

while true do
	-- Generate random gust speed
	local randomGustSpeed = math.random(10, 30)

	-- Generate random gust direction (unit vector)
	local randomGustDirection = Vector3.new(math.random() - 0.5, 0, math.random() - 0.5).unit

	for i = 1, gustIntervals do
		local f = math.sin(math.pi * dgf * i)  -- Use sin() function to ramp gust
		workspace.GlobalWind = baseWind + f * (randomGustSpeed * randomGustDirection)  -- Set global wind to base wind + gust
		task.wait(dg)
	end

	workspace.GlobalWind = baseWind  -- Reset global wind to base wind at the end of gust cycle
	task.wait(math.random() * gustCycleDelay)  -- Wait a random fraction of delay before the next gust cycle
end

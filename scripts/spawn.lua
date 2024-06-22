local Players = game:GetService("Players")

local function onPlayButtonClicked(player)
	-- Load the character for the player when the "Play" button is clicked
	player:LoadCharacter()
end

local function onPlayerAdded(player)
	local playerGui = player:WaitForChild("PlayerGui")

	-- Assuming the MainMenu frame is directly under StarterGui
	local mainMenu = playerGui:WaitForChild("MainMenu")

	-- Assuming the Play button is a child of the MainMenu frame
	local playButton = mainMenu:WaitForChild("Play")

	playButton.MouseButton1Click:Connect(function()
		-- Hide the MainMenu frame when the Play button is clicked
		mainMenu.Visible = false

		-- Call the function to load the character
		onPlayButtonClicked(player)
	end)
end

-- Connect the function to the PlayerAdded event
Players.PlayerAdded:Connect(onPlayerAdded)

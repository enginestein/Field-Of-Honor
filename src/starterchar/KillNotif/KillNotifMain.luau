---Settings---
local Kill_Message = "Enemy Killed: "----the message that will appear after you killed an enemy comes with the reward.
local Leaderstat_Reward_Value = 25-------how much money or exp you get from killing enemies
local Show_UserName = true------------Will(true) or won't(false) show the enemy's username
--------------


local Humanoid = script.Parent.Humanoid
local msg = script.TextLabel
msg.Visible = false
local function Dead()
	local tag = Humanoid:FindFirstChild("creator")
	if tag ~= nil then
		local leaderstats = tag.Value:FindFirstChild("leaderstats")
		if leaderstats ~= nil then
			leaderstats.Exp.Value = leaderstats.Exp.Value + Leaderstat_Reward_Value---instead of "Exp", you can change it to your currency's name if you want
		end
		local sound = Instance.new("Sound")
		sound.Parent = tag.Value.Character
		sound.SoundId = "rbxassetid://3603370582"---replace with your sound id
		sound:Play()
		msg.Visible = true
		if Show_UserName then
			msg.Text = Kill_Message..Humanoid.Parent.Name.." [+"..Leaderstat_Reward_Value.."]"
		else
			msg.Text = Kill_Message.." [+"..Leaderstat_Reward_Value.."]"
		end
		msg.Parent = tag.Value:FindFirstChild("PlayerGui").KillNotification.Frame
		wait(15)
		sound:Destroy()
	end
end
Humanoid.Died:Connect(Dead)
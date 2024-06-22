---Settings---
local Time_Before_Disappearing = 3.4
local Fade_Out_Enabled = true---fade out effect
local Fade_Out_Smoothness = 0.1----smaller number = smoother it fades
--------------
local txt = script.Parent

txt.Changed:Connect(function()
    if txt.Parent:IsA("Frame") then
        wait(Time_Before_Disappearing)
        if Fade_Out_Enabled then
            repeat
                wait()
                txt.TextTransparency = txt.TextTransparency + Fade_Out_Smoothness
            until txt.TextTransparency >= 1
            wait(Time_Before_Disappearing)
            txt:Destroy()
        else
            txt:Destroy()
        end
    end
end)
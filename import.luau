local remodel = require("./remodel")
 
local inputGame = remodel.readPlaceFile("Field Of Honor.rbxlx")
local outputGame = remodel.readPlaceFile("Field Of Honor_out.rbxlx")

outputGame.Workspace.Terrain:Destroy()
inputGame.Workspace.Terrain.Parent = outputGame.Workspace
 
remodel.writePlaceFile("output-place-updated.rbxlx", outputGame)
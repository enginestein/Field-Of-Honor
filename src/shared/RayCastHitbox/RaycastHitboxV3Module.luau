--]]

local RaycastHitbox = { 
	Version = "3.3",
	AttachmentName = "DmgPoint",
	DebugMode = false,
	WarningMessage = false
}

--------

local Handler = require(script.MainHandler)
local HitboxClass = require(script.HitboxObject)

function RaycastHitbox:Initialize(object, ignoreList)
	assert(object, "You must provide an object instance.")
	
	local newHitbox = Handler:check(object)
	if not newHitbox then
		newHitbox = HitboxClass:new()
		newHitbox:config(object, ignoreList)
		newHitbox:seekAttachments(RaycastHitbox.AttachmentName, RaycastHitbox.WarningMessage)
		newHitbox.debugMode = RaycastHitbox.DebugMode
		Handler:add(newHitbox)
	end
	return newHitbox
end

function RaycastHitbox:Deinitialize(object) --- Deprecated
	Handler:remove(object)
end

function RaycastHitbox:GetHitbox(object)
   return Handler:check(object)
end

return RaycastHitbox

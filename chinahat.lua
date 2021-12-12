--[[
	https://github.com/awesomeusername69420/meth_tools
	
	Rice Mode: Activated
	
	Command(s):
		rice_ang (int)  -  Changes the angle of the hat
		rice_len (int)  -  Changes the length of the hat
]]

local inang = 25
local length = 15

local function getHeadPos(ent)
	if not ent:IsValid() then
		return Vector(0, 0, 0)
	end
	
	local entpos = ent:GetPos()
	local headpos = ent:EyePos()
	
	for i = 0, ent:GetBoneCount() - 1 do
		if string.find(string.lower(ent:GetBoneName(i)), "head") then
			headpos = ent:GetBonePosition(i)
			
			if headpos == entpos then
				headpos = ent:GetBoneMatrix(i):GetTranslation()
			end

			break
		end
	end
	
	return headpos
end

hook.Add("HUDPaint", "", function()
	if LocalPlayer():ShouldDrawLocalPlayer() then
		local base = getHeadPos(LocalPlayer()) + Vector(0, 0, 10)
		local ang = Angle(inang, 0, 0)
		
		cam.Start3D()
			for i = 1, 360 do
				render.DrawLine(base, base + (ang:Forward() * length), Color(255, 255, 255, 75), false)
				ang.y = ang.y + 1
			end
		cam.End3D()
	end
end)

concommand.Add("rice_ang", function(p, c, args)
	args[1] = args[1] or 25
	
	inang = tonumber(args[1])
end)

concommand.Add("rice_len", function(p, c, args)
	args[1] = args[1] or 15
	
	length = tonumber(args[1])
end)

-- RealTime by danny9484
PLUGIN = nil
-- Use the InfoReg shared library to process the Info.lua file:
dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua")

function Initialize(Plugin)
	Plugin:SetName("RealTime")
	Plugin:SetVersion(1)

	-- Hooks
cPluginManager:AddHook(cPluginManager.HOOK_WORLD_TICK, Time);

	PLUGIN = Plugin -- NOTE: only needed if you want OnDisable() to use GetName() or something like that

	-- Command Bindings

	-- read Config
	local IniFile = cIniFile();
	if (IniFile:ReadFile(PLUGIN:GetLocalFolder() .. "/worlds.ini")) then
		local i = 1
		Worlds = {}
		while IniFile:GetValue("Worlds", tostring(i)) ~= "" do
			Worlds[i] = IniFile:GetValue("Worlds", tostring(i))
			LOG(Plugin:GetName() .. ": Synching " .. Worlds[i])
			i = i + 1
		end
	else
		LOG("can't read worlds.ini")
		return false
	end

	LOG("Initialized " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function OnDisable()
	LOG(PLUGIN:GetName() .. " is shutting down...")
end

function Time(World)
	local i = 1
	while Worlds[i] ~= nil do
		if Worlds[i] == World:GetName() then
			hour = os.date("%H") * 1000 + 18000;
			minute = os.date("%M") * 100 / 6;
			seconds = os.date("%S") * 28 / 100;
			ticks = hour + minute + seconds;
			if (ticks > 24000) then
				ticks = ticks - 24000;
			end
			World:SetTimeOfDay(ticks);
		end
		i = i + 1
	end
end

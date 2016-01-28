PLUGIN = nil

function Initialize(Plugin)
	Plugin:SetName("RealTime")
	Plugin:SetVersion(1)
	
	-- Hooks
cPluginManager:AddHook(cPluginManager.HOOK_WORLD_TICK, Time);
	
	PLUGIN = Plugin -- NOTE: only needed if you want OnDisable() to use GetName() or something like that
	
	-- Command Bindings

	LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end

function OnDisable()
	LOG(PLUGIN:GetName() .. " is shutting down...")
end

function Time(World)
	hour = os.date("%H") * 1000 + 18000;
	minute = os.date("%M") * 100 / 6;
	seconds = os.date("%S") * 28 / 100;
	ticks = hour + minute + seconds;
	if (ticks > 24000) then
		ticks = ticks - 24000;
	end
	World:SetTimeOfDay(ticks);
	-- LOG(ticks);
end
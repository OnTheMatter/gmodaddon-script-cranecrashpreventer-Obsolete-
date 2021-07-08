if (CLIENT) then return end;
AddCSLuaFile("CraneBugFixLuaHook.lua");

local function sf_cranecheck_backup(ent)
	if (ent:GetClass() == "phys_magnet") then
		//print("Magnet has been found!");
		local sf_cranelist = ents.FindByClass("prop_vehicle_crane");
		if (#sf_cranelist > 0) then
			//print("And There are cranes!");
			local sf_closest_crane = sf_cranelist[1];
			for _,sf_crane_i in ipairs(sf_cranelist) do
				if (sf_crane_i:GetPos():Distance(ent:GetPos()) > sf_closest_crane:GetPos():Distance(ent:GetPos())) then
					sf_closest_crane = sf_crane_i;
				end
			end
		ent:DeleteOnRemove(sf_closest_crane);
		end
	end
end

hook.Add("OnEntityCreated","sf_craneremovalcrashfix",function(ent)
	if (ent:GetClass() == "phys_magnet") then
		//print("Magnet has been found!");
		local sf_cranelist = ents.FindByClass("prop_vehicle_crane");
		if (#sf_cranelist > 0) then
			//print("And There are cranes!");
			local sf_closest_crane = sf_cranelist[1];
			for _,sf_crane_i in ipairs(sf_cranelist) do
				if (sf_crane_i:GetPos():Distance(ent:GetPos()) > sf_closest_crane:GetPos():Distance(ent:GetPos())) then
					sf_closest_crane = sf_crane_i;
				end
			end
			ent:DeleteOnRemove(sf_closest_crane);
		else
			timer.Simple(0.05,function() sf_cranecheck_backup(ent) end)		--When you load a save, you have a 0.1 second time-period where you can prevent the crane from crashing the game. If the magnet misses a crane then this is vital!
		end
	end
end)

/*
hook.Add("GM:Initialize","sf_cranecrashluahook",function(ent) 
	 local sf_cranelist = ents.FindByClass("prop_vehicle_crane");
	 local sf_magnetlist = ents.FindByClass("phys_magnet");
	 if (#sf_cranelist <= 0 || #sf_magnetlist <= 0) then return end;
	 local sf_crane_min_checks = math.min(#sf_cranelist,#sf_magnetlist);
	 local sf_crane_iterator_ticker = 0;
	 for sf_cranei = 0,#sf_cranelist,1 do
	 	sf_cranelist[sf_cranei]:Remove
	 end
end)
*/
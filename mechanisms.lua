--[[ Thanks to sofar for helping with that code.
Recommended setting in minetest.conf (requires 0.4.14 or newer) :
	nodetimer_interval = 0.1
]]

local plate = {}
screwdriver = screwdriver or {}

local function door_toggle(pos_actuator, pos_door, player)
	local actuator = minetest.get_node(pos_actuator)
	local door = lib_doors.get(pos_door)

	if actuator.name:sub(-4) == "_off" then
		minetest.set_node(pos_actuator,
			{name=actuator.name:gsub("_off", "_on"), param2=actuator.param2})
	end
	door:open(player)

	minetest.after(2, function()
		if minetest.get_node(pos_actuator).name:sub(-3) == "_on" then
			minetest.set_node(pos_actuator,
				{name=actuator.name, param2=actuator.param2})
		end
		door:close(player)
	end)
end

function plate.construct(pos)
	local timer = minetest.get_node_timer(pos)
	timer:start(0.1)
end

function plate.timer(pos)
	local objs = minetest.get_objects_inside_radius(pos, 0.8)
	if objs == {} or not doors.get then return true end
	local minp = {x=pos.x-2, y=pos.y, z=pos.z-2}
	local maxp = {x=pos.x+2, y=pos.y, z=pos.z+2}
	local doors = minetest.find_nodes_in_area(minp, maxp, "group:lib_doors")

	for _, player in pairs(objs) do
		if player:is_player() then
			for i = 1, #doors do
				door_toggle(pos, doors[i], player)
			end
			break
		end
	end
	return true
end

function plate.register(material, desc, def)
	lib_tools.register("pressure_"..material.."_off", {
		description = desc.." Pressure Plate",
		tiles = {"lib_tools_pressure_"..material..".png"},
		drawtype = "nodebox",
		node_box = lib_tools.pixelbox(16, {{1, 0, 1, 14, 1, 14}}),
		groups = def.groups,
		sounds = def.sounds,
		sunlight_propagates = true,
		on_rotate = screwdriver.rotate_simple,
		on_construct = plate.construct,
		on_timer = plate.timer
	})
	lib_tools.register("pressure_"..material.."_on", {
		tiles = {"lib_tools_pressure_"..material..".png"},
		drawtype = "nodebox",
		node_box = lib_tools.pixelbox(16, {{1, 0, 1, 14, 0.4, 14}}),
		groups = def.groups,
		sounds = def.sounds,
		drop = "lib_tools:pressure_"..material.."_off",
		sunlight_propagates = true,
		on_rotate = screwdriver.rotate_simple
	})
end

plate.register("wood", "Wooden", {
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=2}
})

plate.register("stone", "Stone", {
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky=3, oddly_breakable_by_hand=2}
})

lib_tools.register("lever_off", {
	description = "Lever",
	tiles = {"lib_tools_lever_off.png"},
	drawtype = "nodebox",
	node_box = lib_tools.pixelbox(16, {{2, 1, 15, 12, 14, 1}}),
	groups = {cracky=3, oddly_breakable_by_hand=2},
	sounds = default.node_sound_stone_defaults(),
	sunlight_propagates = true,
	on_rotate = screwdriver.rotate_simple,
	on_rightclick = function(pos, node, clicker)
		if not doors.get then return end
		local minp = {x=pos.x-2, y=pos.y-1, z=pos.z-2}
		local maxp = {x=pos.x+2, y=pos.y+1, z=pos.z+2}
		local doors = minetest.find_nodes_in_area(minp, maxp, "group:lib_doors")

		for i = 1, #doors do
			door_toggle(pos, doors[i], clicker)
		end
	end
})

lib_tools.register("lever_on", {
	tiles = {"lib_tools_lever_on.png"},
	drawtype = "nodebox",
	node_box = lib_tools.pixelbox(16, {{2, 1, 15, 12, 14, 1}}),
	groups = {cracky=3, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	sunlight_propagates = true,
	on_rotate = screwdriver.rotate_simple,
	drop = "lib_tools:lever_off"
})


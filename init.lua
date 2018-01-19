

lib_tools = {}



-- internationalization boilerplate
lib_tools.MP = minetest.get_modpath(minetest.get_current_modname())
lib_tools.gettext, lib_tools.ngettext = dofile(lib_tools.MP.."/intllib.lua")
lib_tools.S = lib_tools.gettext
lib_tools.NS = lib_tools.ngettext

--local S, NS = dofile(MP.."/intllib.lua")


dofile(minetest.get_modpath("lib_tools").."/utils.lua")
dofile(minetest.get_modpath("lib_tools").."/registration.lua")

dofile(minetest.get_modpath("lib_tools").."/anvil.lua")
dofile(minetest.get_modpath("lib_tools").."/chess.lua")
dofile(minetest.get_modpath("lib_tools").."/cooking.lua")
dofile(minetest.get_modpath("lib_tools").."/craftguide.lua")
dofile(minetest.get_modpath("lib_tools").."/enchanting3.lua")
dofile(minetest.get_modpath("lib_tools").."/enchanting.lua")
dofile(minetest.get_modpath("lib_tools").."/mailbox.lua")
dofile(minetest.get_modpath("lib_tools").."/mechanisms.lua")
dofile(minetest.get_modpath("lib_tools").."/nodes_straw.lua")
dofile(minetest.get_modpath("lib_tools").."/rope.lua")

dofile(minetest.get_modpath("lib_tools").."/config.lua")
dofile(minetest.get_modpath("lib_tools").."/rubber.lua")
dofile(minetest.get_modpath("lib_tools").."/flashlight.lua")
dofile(minetest.get_modpath("lib_tools").."/sonic_screwdriver.lua")
dofile(minetest.get_modpath("lib_tools").."/tree_tap.lua")


minetest.register_craftitem("lib_tools:bowl", {
	description = "Bowl",
	inventory_image = "xdecor_bowl.png",
	wield_image = "xdecor_bowl.png"
})

minetest.register_craftitem("lib_tools:bowl_soup", {
	description = "Bowl of soup",
	inventory_image = "xdecor_bowl_soup.png",
	wield_image = "xdecor_bowl_soup.png",
	groups = {not_in_creative_inventory=1},
	stack_max = 1,
	on_use = function(itemstack, user)
		itemstack:replace("lib_tools:bowl 1")
		if rawget(_G, "hunger") then
			minetest.item_eat(20)
		else
			user:set_hp(20)
		end
		return itemstack
	end
})

minetest.register_node("lib_tools:television", {
	description = "Television",
	light_source = 11,
	groups = {snappy=3},
	on_rotate = screwdriver.rotate_simple,
	tiles = {
		"xdecor_television_left.png^[transformR270",
		 "xdecor_television_left.png^[transformR90",
		 "xdecor_television_left.png^[transformFX",
		 "xdecor_television_left.png",
		 "xdecor_television_back.png",
		{name="xdecor_television_front_animated.png",
			animation = {type="vertical_frames", length=80.0}
		}
	}
})



minetest.register_craft({
	output = "lib_tools:bowl 3",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""}
	}
})

minetest.register_craft({
	output = "lib_tools:cauldron_empty",
	recipe = {
		{"default:iron_lump", "", "default:iron_lump"},
		{"default:iron_lump", "", "default:iron_lump"},
		{"default:iron_lump", "default:iron_lump", "default:iron_lump"}
	}
})

minetest.register_craft({
	output = "lib_tools:enchantment_table",
	recipe = {
		{"", "default:book", ""},
		{"default:diamond", "default:obsidian", "default:diamond"},
		{"default:obsidian", "default:obsidian", "default:obsidian"}
	}
})

minetest.register_craft({
	output = "lib_tools:lever_off",
	recipe = {
		{"group:stick"},
		{"group:stone"}
	}
})

minetest.register_craft({
	output = "lib_tools:mailbox",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"dye:red", "default:paper", "dye:red"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "lib_tools:pressure_stone_off",
	type = "shapeless",
	recipe = {"group:stone", "group:stone"}
})

minetest.register_craft({
	output = "lib_tools:pressure_wood_off",
	type = "shapeless",
	recipe = {"group:wood", "group:wood"}
})

minetest.register_craft({
	output = "lib_tools:tv",
	recipe = {
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:steel_ingot", "default:copper_ingot", "default:steel_ingot"}
	}
})


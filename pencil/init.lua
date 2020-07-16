minetest.log("action","[pencil] Loading")
pencil = {}
function pencil.register_pencil(id,name,text,image,not_cre_inv)
	local id,name,text,image = id,name,text,image
	if not(id) then
		print("[pencil] Cannot register a pencil with no id")
		return
	end
	if not(text) then
		text = "Unconfiged"
		print("[pencil] Pencil With no text, using \"Unconfiged\"")
	end
	if not(name) then
		name = text.." Pencil"
		print("[pencil] Pencil With no name, using \""..text.." Pencil\"")
	end
	if not(image) then
		image = "pencil.png"
		print("[pencil] Pencil With no image, using \"pencil.png\"")
	end
	if not_cre_inv == nil then
		not_cre_inv = false
		print("[pencil] Pencil's not_cre_inv setting is nil, using \"false\"")
	end
	minetest.register_craftitem(id, {
		description = tostring(name),
		on_use = function(itemstack, user, pointed_thing)
			local pos = minetest.get_pointed_thing_position(pointed_thing, above)
			local meta = minetest.get_meta(pos);
			meta:set_string("infotext",tostring(text));
		end,
		inventory_image = tostring(image),
		not_in_creative_inventory = not_cre_inv
	})
	minetest.log("action","[pencil] Register a pencil "..tostring(id).." with text "..tostring(text))
end

-- match to old version
register_pencil = function(id,name,text,image)
	pencil.register_pencil(id,name,text,image)
	minetest.log("warning","[pencil] The pencil "..id.." was registered by using \"register_pencil\" , use \"pencil.register_pencil\" instad.")
end

pencil.register_pencil("pencil:hello_world","Hello World Pencil","Hello World!",nil,false)
-- test the warning when using the old function to register pencil
register_pencil("pencil:blank","Blank Test Pencil",nil,"barrier_inv.png",false)
pencil.register_pencil("pencil:eraser","Eraser"," ","eraser.png",false)
pencil.register_pencil("pencil:tmp","TMP Pencil"," ",nil,false)
pencil.register_pencil("pencil:noaccess","No Access Pencil","Don't Access!",nil,false)

minetest.register_privilege("add_pencil", {
	description = "Can use pencil_add command to add pencil."
})
minetest.register_chatcommand("pencil_add", {
	params = "<text>",
	privs = {add_pencil=true},
	description = "Change the text on TMP pencil (pencil:tmp)",
	func = function(name,param)
		pencil.register_pencil(":pencil:tmp",tostring(param).." TMP Pencil",tostring(param),nil)
	end,
})

minetest.register_chatcommand("pencil_change", {
	params = "<text>",
	privs = {add_pencil=true},
	description = "Change the text on TMP pencil (pencil:tmp)",
	func = function(name,param)
		pencil.register_pencil("pencil:tmp_"..name,name.."\'s Pencil",nil,nil,true)
	end,
})

minetest.register_node("pencil:get_tmp",{
	tiles = {"pencil.png"},
	is_ground_content = false,
	on_use = function(itemstack, player, pointed_thing)
		local receiver = player:get_player_name()
		local receiverref = player
		if receiverref == nil then
			return false, receiver .. " is not a known player"
		end
		local leftover = receiverref:get_inventory():add_item("main", "pencil:user_"..receiver)
	end,
})

minetest.register_on_joinplayer(function(player)
		print(player:get_player_name())
		pencil.register_pencil("pencil:user_"..tostring(player:get_player_name()),tostring(player:get_player_name()).."\'s Pencil"," ",nil,true)
	end
)
minetest.log("action","[pencil] Loaded")

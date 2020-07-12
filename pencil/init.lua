print("[pencil] Loading")
function register_pencil(id,name,text,image)
	local id,name,text,image = id,name,text,image
	if not(id) then
		print("[pencil] Cannot register a pencil with no name")
		return
	end
	if not(text) then
		text = "Unconfiged"
	end
	if not(name) then
		name = text.." Pencil"
	end
	if not(image) then
		image = "pencil.png"
	end
	minetest.register_craftitem(id, {
		description = name,
		on_use = function(itemstack, user, pointed_thing)
			local pos = minetest.get_pointed_thing_position(pointed_thing, above)
			local meta = minetest.get_meta(pos);
			meta:set_string("infotext",text);
		end,
		inventory_image = image
	})
	print("[pencil] Register a pencil "..id.." with text "..text)
end

register_pencil("pencil:hello_world","Hello World Pencil","Hello World!",nil)
register_pencil("pencil:blank","Blank Test Pencil",nil,"barrier_inv.png")
register_pencil("pencil:eraser","Eraser"," ","eraser.png")
register_pencil("pencil:tmp","TMP Pencil"," ",nil)
register_pencil("pencil:noaccess","No Access Pencil","Don't Access!",nil)

minetest.register_privilege("add_pencil", {
	description = "Can use pencil_add command to add pencil."
})
math.randomseed(100)
random = math.random(1000)
minetest.register_chatcommand("pencil_add", {
	params = "<text>",
	privs = {add_pencil=true},
	description = "Add a pencil.",
	func = function(name,param)
		register_pencil(":pencil:tmp",tostring(param).." TMP Pencil",tostring(param),nil)
	end,
})
print("[pencil] Loaded")

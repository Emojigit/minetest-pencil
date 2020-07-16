# Pencil: The Minetest Mod
Pencil is a minetest mod api that can make tools to change the infotext in a block.

![Screenshot](https://raw.githubusercontent.com/Emojigit/minetest-pencil/master/Inkedscreenshot_20200709_185325_LI.jpg)

# API usage
## pencil.register_pencil(id,name,text,image)

 - id = the name of pencil (e.g. mod:foobar )
 - name = the name that display in inventory (e.g. FooBar Pencil ). The default is `text.."Pencil"`.
 - text = The text hat display in the block which right-clicked by the pencil. The default is `Unconfiged`.
 - image = the image that show in hudbar and inventory (e.g. foobar.png). The default is [`pencil.png`](https://github.com/Emojigit/minetest-pencil/blob/master/pencil/textures/pencil.png)

# Links
(Minetest Forum)[https://forum.minetest.net/viewtopic.php?t=25076]
(Minetest ContentDB)[https://content.minetest.net/packages/Emojiminetest/pencil]

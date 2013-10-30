

windmill = {}

windmill.register_windmill = function( nodename, descr, animation_png, animation_png_reverse, scale, inventory_image, animation_speed, craft_material )

    minetest.register_node( nodename, {
	description = descr.." (clockwise)",
	drawtype = "signlike", 
        visual_scale = scale,
	tiles = {
		{name=animation_png, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=animation_speed}},
	},
	inventory_image = inventory_image.."^[transformFX",
	wield_image     = inventory_image.."^[transformFX",
	wield_scale = {x=1, y=1, z=1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 1, -- reflecting a bit of light might be expected
	selection_box = {
		type = "wallmounted",
		wall_side   = {-0.4, -2.5, -2.5, -0.2, 2.5, 2.5},
	},
	groups = {choppy=2,dig_immediate=3,attached_node=1},
	legacy_wallmounted = true,

    })


    -- this one rotates in the opposite direction than the first one
    minetest.register_node( nodename.."_reverse", {
	description = descr.." (counterclockwise)",
	drawtype = "signlike",
        visual_scale = scale,
	tiles = {
		{name=animation_png_reverse, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=animation_speed}},
	},
	inventory_image = inventory_image,
	wield_image     = inventory_image,
	wield_scale = {x=1, y=1, z=1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 1, -- reflecting a bit of light might be expected
	selection_box = {
		type = "wallmounted",
		wall_side   = {-0.4, -2.5, -2.5, -0.2, 2.5, 2.5},
	},
	groups = {choppy=2,dig_immediate=3,attached_node=1},
	legacy_wallmounted = true,

    })

    minetest.register_craft({
        output = nodename.."_reverse",
        recipe = {{ nodename }},
    }) 

    minetest.register_craft({
        output = nodename,
        recipe = {{ nodename.."_reverse" }},
    })

    minetest.register_craft({
        output = nodename,
        recipe = {
                { craft_material,       "",                    craft_material },
                { "",                   "default:stick",       "",             },
                { craft_material,       "",                    craft_material },
        }
})
end


windmill.register_windmill( "windmill:windmill",       "Windmill rotors",
			"windmill.png", "windmill_reverse.png",
			6.0, "windmill_inv.png", 1.0, "default:steel_ingot" );

windmill.register_windmill( "windmill:windmill_modern", "Windmill turbine",
			"windmill_3blade_cw.png", "windmill_3blade_ccw.png",
			6.0, "windmill_3blade_inv.png", 1.0, "homedecor:plastic_sheet" );

windmill.register_windmill( "windmill:windmill_sails", "Windmill sails",
			"windmill_wooden_cw_with_sails.png", "windmill_wooden_ccw_with_sails.png",
			6.0, "windmill_wooden_inv.png", 1.0, "wool:white" );


minetest.register_node("windmill:axis", {
	description = "Axis for mounting windmills",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {choppy=2,dig_immediate=3},
	node_box = {
		type = "fixed",
		fixed = {{-0.25, -0.5, -0.25, 0.25, 0.4, 0.25},
			 {-0.1,-0.1,-0.5,0.1,0.1,0.5}},
	},
	selection_box = {
		type = "fixed",
		fixed = {{-0.25, -0.5, -0.25, 0.25, 0.4, 0.25},
			 {-0.1,-0.1,-0.5,0.1,0.1,0.5}},
	},
})


minetest.register_craft({
        output = "windmill:axis",
        recipe = {
                {"default:steel_ingot", "default:stick",       "default:steel_ingot" },
        }
})

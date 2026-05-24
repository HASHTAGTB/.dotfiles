-- APPEARANCE
-- Visual theme (general + decoration):  source/themes/
-- Animation preset:                     source/animations/

require("modules.themes.beautiful")
require("modules.animations.vertical_minimal")

-- ---------------------------------------------------------------------------
-- LAYOUTS
-- ---------------------------------------------------------------------------
hl.config({
	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	scrolling = {
		column_width = 0.667,
		follow_min_visible = 0.3,
	},

	-- ---------------------------------------------------------------------------
	-- MISC
	-- ---------------------------------------------------------------------------
	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},

	-- ---------------------------------------------------------------------------
	-- BINDS
	-- ---------------------------------------------------------------------------
	binds = {
		allow_pin_fullscreen = true,
	},
})

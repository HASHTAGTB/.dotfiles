-- Theme: beautiful
-- Full visual style: blur, transparency, shadows, rounded corners

local primary = colors.primary or "rgba(a9c7ffff)"
local inverse_on_surface = colors.inverse_on_surface or "rgba(2e3035ff)"

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		gaps_workspaces = 0,
		border_size = 2,

		col = {
			active_border = primary,
			inactive_border = inverse_on_surface,
		},

		resize_on_border = false,
		allow_tearing = true,
		layout = "dwindle",

		snap = {
			enabled = false,
			window_gap = 10,
			monitor_gap = 10,
			border_overlap = false,
		},
	},

	decoration = {
		rounding = 6,
		rounding_power = 6.0,

		active_opacity = 0.8,
		inactive_opacity = 0.6,
		fullscreen_opacity = 1.0,

		dim_inactive = false,
		dim_strength = 0.2,
		dim_special = 0.5,

		shadow = {
			enabled = true,
			range = 35,
			render_power = 2,
			sharp = false,
			scale = 1.0,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 4,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			noise = 0.0117,
			contrast = 0.8916,
			brightness = 0.8172,
			vibrancy = 0.1696,
			popups = false,
		},
	},
})

-- INPUT
-- Merged: source/input.conf + edit_here/source/input.conf
-- Conflicts: edit_here values win; original source values shown as comments.

local osdclient = "swayosd-client"

hl.config({
	input = {
		-- [source had: kb_layout = "us"]
		kb_layout = "de",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		resolve_binds_by_sym = false,
		numlock_by_default = true,
		repeat_rate = 35,
		repeat_delay = 250,

		follow_mouse = 1,

		-- [source had: sensitivity = 0, accel_profile = "adaptive", force_no_accel = false]
		sensitivity = 1,
		accel_profile = "flat",
		force_no_accel = true,
		left_handed = false,
		mouse_refocus = true,

		-- [source had: scroll_method = "2fg"]
		natural_scroll = false,
		scroll_method = "no_scroll",
		scroll_button = 0,
		scroll_button_lock = false,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			tap_to_click = true,
			clickfinger_behavior = false,
			drag_lock = false,
		},
	},

	cursor = {
		sync_gsettings_theme = true,
		no_hardware_cursors = 2, -- 0=HW, 1=SW, 2=auto (disable on tearing)
		use_cpu_buffer = 2, -- 0=off, 1=on, 2=auto (Nvidia optimisation)
		hide_on_key_press = false,
		inactive_timeout = 0,
		warp_on_change_workspace = 0,
		no_break_fs_vrr = 2,
		zoom_factor = 1.0,
		zoom_disable_aa = true,
	},

	gestures = {
		workspace_swipe_distance = 300,
		workspace_swipe_cancel_ratio = 0.5,
		workspace_swipe_invert = true,
		workspace_swipe_create_new = true,
		workspace_swipe_forever = false,
	},
})

-- Gesture bindings (3-finger / 4-finger swipes and pinches)
-- Note: dispatcher-form gestures; adjust if Lua API evolves
-- hl.gesture({ fingers = 3, direction = "up", dispatcher = "hyprexpo:expo", args = "toggle" })
-- hl.gesture({
-- 	fingers = 3,
-- 	direction = "left",
-- 	dispatcher = "exec",
-- 	args = "swaync-client -t",
-- })
-- hl.gesture({
-- 	fingers = 3,
-- 	direction = "down",
-- 	dispatcher = "exec",
-- 	args = osdclient .. " --output-volume mute-toggle",
-- })
-- hl.gesture({
-- 	fingers = 3,
-- 	direction = "right",
-- 	dispatcher = "exec",
-- 	args = osdclient .. " --playerctl play-pause",
-- })
-- hl.gesture({
-- 	fingers = 4,
-- 	direction = "left",
-- 	dispatcher = "exec",
-- 	args = osdclient .. " --brightness -10",
-- })
-- hl.gesture({
-- 	fingers = 4,
-- 	direction = "right",
-- 	dispatcher = "exec",
-- 	args = osdclient .. " --brightness +10",
-- })
-- hl.gesture({
-- 	fingers = 4,
-- 	direction = "up",
-- 	dispatcher = "exec",
-- 	args = osdclient .. " --output-volume +10 --max-volume 95",
-- })
-- hl.gesture({
-- 	fingers = 4,
-- 	direction = "down",
-- 	dispatcher = "exec",
-- 	args = osdclient .. " --output-volume -10 --max-volume 95",
-- })
-- hl.gesture({
-- 	fingers = 3,
-- 	direction = "pinchout",
-- 	dispatcher = "exec",
-- 	args = "hyprlock --immediate",
-- })
-- hl.gesture({
-- 	fingers = 3,
-- 	direction = "pinchin",
-- 	dispatcher = "exec",
-- 	args = "slurp | grim -g - - | swappy -f -",
-- })
-- hl.gesture({
-- 	fingers = 4,
-- 	direction = "pinchout",
-- 	dispatcher = "exec",
-- 	args = "swaync-client -t",
-- })

-- KEYBINDINGS
-- Source: source/keybinds.conf
-- edit_here/source/keybinds.conf was all commented-out draft history; no active
-- lines to merge. The translations below cover every active bind in source.
--
-- bind flag mapping:
--   bindd  → hl.bind(...)
--   bindl  → hl.bind(..., { locked = true })
--   binded → hl.bind(..., { repeating = true })
--   bindeld / bindled → hl.bind(..., { locked = true, repeating = true })
--   bindld → hl.bind(..., { locked = true })
--   binddm → hl.bind(..., { mouse = true })
--   bind   → hl.bind(...)
--
-- Dispatchers not yet in the typed Lua API use hyprctl via exec_cmd.

-- ---------------------------------------------------------------------------
-- Variables
-- ---------------------------------------------------------------------------
local home = os.getenv("HOME")
local terminal = "kitty"
local fileManager = "kitty -e yazi"
local browser = "zen-browser"
local textEditor = "nvim"
local scripts = home .. "/Scripts"
local mainMod = "SUPER"

-- ---------------------------------------------------------------------------
-- 2. APPLICATION LAUNCHERS (UWSM wrapped)
-- ---------------------------------------------------------------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("uwsm-app -- " .. terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm-app -- " .. browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app -- " .. fileManager))
hl.bind(
	mainMod .. " + R",
	hl.dsp.exec_cmd("uwsm-app -- " .. terminal .. " --directory ~/Documents/txt/ -e " .. textEditor)
)
hl.bind("ALT + SPACE", hl.dsp.exec_cmd('pkill rofi; rofi -show drun -run-command "uwsm app -- {cmd}"'))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/emoji.sh"))
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/rofi_wallpaper_selctor.sh"))
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; uuctl"))

-- System Monitor
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd("uwsm-app -- " .. terminal .. " --class btop -e btop"))

-- System Utilities
hl.bind("ALT + 1", hl.dsp.exec_cmd("uwsm-app -- nm-connection-editor"))
hl.bind("ALT + 2", hl.dsp.exec_cmd("uwsm-app -- blueman-manager"))
hl.bind("ALT + 3", hl.dsp.exec_cmd("uwsm-app -- pavucontrol"))
hl.bind("ALT + 4", hl.dsp.exec_cmd("uwsm-app -- waypaper"))
hl.bind(mainMod .. " + numbersign", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/theme/random-wallpaper"))
-- hl.bind(
-- 	mainMod .. " + SHIFT + numbersign",
-- 	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/theme_matugen/theme_ctl.sh set --mode safe")
-- )

-- Game Mode / Passthrough submap
hl.bind("ALT + 6", function()
	hl.dispatch(
		hl.dsp.exec_cmd('notify-send -u critical -t 3000 "Passthrough Enabled" "Press ' .. mainMod .. '+ESC to exit"')
	)
	hl.dispatch(hl.dsp.submap("passthrough"))
end, { locked = true })

hl.define_submap("passthrough", function()
	hl.bind(mainMod .. " + escape", function()
		hl.dispatch(hl.dsp.exec_cmd('notify-send -u low -t 2000 "Passthrough Disabled" "Keybinds restored"'))
		hl.dispatch(hl.dsp.submap("reset"))
	end, { locked = true })
end)

-- DPMS (timer-wrapped per docs: never dispatch DPMS directly from a keybind)
hl.bind("ALT + F7", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "off" }))
	end, { timeout = 500, type = "oneshot" })
end, { locked = true })
hl.bind("ALT + F8", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "on" }))
	end, { timeout = 500, type = "oneshot" })
end, { locked = true })
hl.bind("ALT + F6", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "toggle", monitor = "DP-2" }))
		hl.dispatch(hl.dsp.dpms({ action = "toggle", monitor = "DP-5" }))
	end, { timeout = 500, type = "oneshot" })
end, { locked = true })
hl.bind("ALT + F5", function()
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = "toggle", monitor = "DP-1" }))
		hl.dispatch(hl.dsp.dpms({ action = "toggle", monitor = "DP-4" }))
	end, { timeout = 500, type = "oneshot" })
end, { locked = true })

-- Waybar
hl.bind("ALT + 9", hl.dsp.exec_cmd("uwsm-app -- waybar"))
hl.bind("ALT + 0", hl.dsp.exec_cmd("pkill waybar"), { locked = true })

-- wlogout / reload
hl.bind(
	"ALT + F4",
	hl.dsp.exec_cmd("wlogout --protocol layer-shell --buttons-per-row 6 --column-spacing 2 --row-spacing 0")
)
hl.bind("ALT + R", hl.dsp.exec_cmd("hyprctl reload"), { locked = true })

-- ---------------------------------------------------------------------------
-- 3. CUSTOM SCRIPTS & UTILITIES
-- ---------------------------------------------------------------------------

-- Opacity / blur / visuals toggles
hl.bind(
	mainMod .. " + ALT + period",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/theme/cycle-appearance"),
	{ locked = true }
)
hl.bind(mainMod .. " + period", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), { locked = true })
hl.bind(mainMod .. " + comma", hl.dsp.window.set_prop({ prop = "no_blur", value = "toggle" }), { locked = true })

-- Zoom
local function screen_zoom(delta)
	local current_zoom = hl.get_config("cursor.zoom_factor")
	local zoom = 1
	if current_zoom >= 1 then
		zoom = current_zoom + current_zoom * delta
	end
	hl.config({ cursor = { zoom_factor = zoom } })
end

hl.bind("SUPER + KP_Add", function()
	screen_zoom(0.5)
end, { repeating = true })
hl.bind("SUPER + KP_Subtract", function()
	screen_zoom(-0.5)
end, { repeating = true })
hl.bind("SUPER + BACKSPACE", function()
	screen_zoom(-1)
end, { repeating = true })

-- Hyprshade
-- hl.bind(mainMod .. " + ALT + X", hl.dsp.exec_cmd("hyprshade off"), { locked = true })
-- hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("hyprshade on saturation"), { locked = true })

-- Clipboard & screenshot
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(
		scripts
			.. '/clipboard/close_terminal_clipboard.sh uwsm-app -- kitty --class terminal_clipboard.sh -e "'
			.. scripts
			.. '/clipboard/terminal_clipboard.sh"'
	)
)

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill hyprpicker || hyprpicker -a"))

-- Screenshot: selection → clipboard + save
hl.bind(
	mainMod .. " + S",
	hl.dsp.exec_cmd(
		"pgrep -x slurp || (slurp | grim -g - - | tee \"$HOME/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d-%H%M%S').png\" | wl-copy -t image/png)"
	)
)

-- Screenshot: focused monitor fullscreen → clipboard + save
hl.bind(
	"Print",
	hl.dsp.exec_cmd(
		[[grim -o "$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')" - | tee "$HOME/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d-%H%M%S').png" | wl-copy -t image/png && notify-send "Fullscreen Screenshot"]]
	)
)

-- Screenshot: selection → swappy annotation
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("pgrep -x slurp || (slurp | grim -g - - | uwsm-app -- swappy -f -)"))

-- Screenshot: fullscreen → swappy annotation
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("pgrep -x swappy || (grim - | uwsm-app -- swappy -f -)"))

-- Google Image Search
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(scripts .. "/google/google_image_search.sh"))

-- OCR → Google text search (select region, OCR it, open Google search)
hl.bind(
	mainMod .. " + SHIFT + G",
	hl.dsp.exec_cmd(
		[=[bash -c 'q=$(slurp | grim -g - - | tesseract stdin stdout 2>/dev/null | python3 -c "import sys,urllib.parse; print(urllib.parse.quote(sys.stdin.read().strip()))"); xdg-open "https://www.google.com/search?q=$q"']=]
	)
)

-- OCR
hl.bind(
	mainMod .. " + T",
	hl.dsp.exec_cmd("pgrep tesseract || (slurp | grim -g - - | tesseract stdin stdout -l eng | wl-copy)")
)
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("grim - | tesseract stdin stdout -l eng | wl-copy"))

-- Notifications
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("swaync-client --hide-all"), { locked = true })

-- Screen lock
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/lock"))

-- ---------------------------------------------------------------------------
-- 4. WINDOW MANAGEMENT
-- ---------------------------------------------------------------------------
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + A", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + X", hl.dsp.window.pin())
hl.bind(mainMod .. " + Y", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.layout("movetoroot"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.layout("swapsplit"))

-- Smart float: toggle float → resize to 90% → center
hl.bind(mainMod .. " + D", function()
	local win = hl.get_active_window()
	if not win then
		return
	end
	if not win.floating then
		local mon = win.monitor or hl.get_active_monitor()
		local w = mon and math.floor(mon.width * 0.9) or 1200
		local h = mon and math.floor(mon.height * 0.9) or 800
		hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
		hl.dispatch(hl.dsp.window.resize({ exact = true, x = w, y = h }))
		hl.dispatch(hl.dsp.window.center())
	else
		hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	end
end)

-- Focus (HJKL, repeating)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }), { repeating = true })
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }), { repeating = true })
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }), { repeating = true })
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }), { repeating = true })

-- Window movement (SHIFT+HJKL, repeating)
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }), { repeating = true })

-- Window resizing (arrow keys, repeating)
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- ---------------------------------------------------------------------------
-- 5. WORKSPACE MANAGEMENT (context-aware multi-monitor script)
-- ---------------------------------------------------------------------------
for i = 1, 10 do
	local key = tostring(i % 10) -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Workspace navigation
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }), { repeating = true })
hl.bind("ALT + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e+1" }), { repeating = true })

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- ---------------------------------------------------------------------------
-- 6. MOUSE BINDINGS
-- ---------------------------------------------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ---------------------------------------------------------------------------
-- 7. HARDWARE & MEDIA KEYS
-- ---------------------------------------------------------------------------

-- Volume & brightness (OSD client, locked + repeating)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Precise adjustments (Alt modifier)
hl.bind(
	"ALT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +1%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"ALT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -1%"),
	{ locked = true, repeating = true }
)

-- Player controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Manual media binds
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("ALT + P", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })

-- Mic mute (keyboard key code 91 = [ on some layouts)
hl.bind("code:91", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))

-- Calculator
hl.bind("XF86Calculator", hl.dsp.exec_cmd("uwsm-app -- gnome-calculator"))

-- ---------------------------------------------------------------------------
-- 8. MISC
-- ---------------------------------------------------------------------------
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd("wayscriber --daemon-toggle"))

-- Game Mode / Mouse Mode submap
hl.bind("ALT + 5", function()
	hl.dispatch(
		hl.dsp.exec_cmd('notify-send -u critical -t 3000 "Mouse Mode Enabled" "Press ' .. mainMod .. '+ESC to exit"')
	)
	hl.dispatch(hl.dsp.submap("mouse"))
end, { locked = true })

hl.define_submap("mouse", function()
	hl.bind("Q", hl.dsp.exec_cmd(scripts .. "/mouse_move left"), { repeating = true })
	hl.bind("E", hl.dsp.exec_cmd(scripts .. "/mouse_move right"), { repeating = true })
	hl.bind(mainMod .. " + escape", function()
		hl.dispatch(hl.dsp.exec_cmd('notify-send -u low -t 2000 "Mouse Mode Disabled" "Keybinds restored"'))
		hl.dispatch(hl.dsp.submap("reset"))
	end, { locked = true })
end)

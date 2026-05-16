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
local fileManager = "-- kitty -e yazi"
local browser = "zen-browser"
local textEditor = "nvim"
local scripts = home .. "/Scripts"
local mainMod = "SUPER"
local osdclient = "swayosd-client"

-- ---------------------------------------------------------------------------
-- 2. APPLICATION LAUNCHERS (UWSM wrapped)
-- ---------------------------------------------------------------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("uwsm-app -- " .. terminal))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm-app -- " .. browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm-app " .. fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("uwsm-app -- kitty --directory ~/Documents/Text/ -e " .. textEditor))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd('pkill rofi; rofi -show drun -run-command "uwsm app -- {cmd}"'))
-- hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/keybindings.sh"))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/emoji.sh"))
-- hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/rofi_theme.sh"))
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/rofi_wallpaper_selctor.sh"))
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; uuctl"))

-- Rofi Powermenu
-- hl.bind(
-- 	"ALT + SHIFT + SPACE",
-- 	hl.dsp.exec_cmd(
-- 		"uwsm-app -- pkill rofi; rofi -show power-menu -modi power-menu:" .. scripts .. "/rofi/powermenu.sh"
-- 	)
-- )

-- System Monitor
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd("uwsm-app -- " .. terminal .. " --class btop -e btop"))

-- System Utilities
hl.bind("ALT + 1", hl.dsp.exec_cmd("uwsm-app -- " .. terminal .. " --class wifitui -e wifitui"))
hl.bind("ALT + 2", hl.dsp.exec_cmd("uwsm-app -- blueman-manager"))
hl.bind("ALT + 3", hl.dsp.exec_cmd("uwsm-app -- pavucontrol"))
hl.bind("ALT + 4", hl.dsp.exec_cmd("uwsm-app -- waypaper"))
hl.bind(mainMod .. " + numbersign", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/theme/random-wallpaper"))
hl.bind(
	mainMod .. " + SHIFT + numbersign",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/theme_matugen/theme_ctl.sh set --mode safe")
)

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

-- Screen rotate
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/hypr/screen_rotate.sh -90"), { locked = true })
hl.bind(
	"CTRL + ALT + SHIFT + R",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/hypr/screen_rotate.sh +90"),
	{ locked = true }
)

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
hl.bind("ALT + 9", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/waybar/waybar_autostart.sh"))
hl.bind("ALT + 0", hl.dsp.exec_cmd("pkill waybar"), { locked = true })
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/waybar/dusky_waybars.sh --toggle"))
hl.bind(
	mainMod .. " + ALT + SHIFT + W",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/waybar/dusky_waybars.sh --back_toggle")
)

-- wlogout / reload
hl.bind("ALT + F4", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/wlogout/wlogout_scale.sh"))
hl.bind("ALT + R", hl.dsp.exec_cmd("hyprctl reload"), { locked = true })

-- Sliders
hl.bind("ALT + V", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/sliders/dusky_sliders.py"))

-- ---------------------------------------------------------------------------
-- 3. CUSTOM SCRIPTS & UTILITIES
-- ---------------------------------------------------------------------------

-- Display scale
hl.bind(
	mainMod .. " + CTRL + up",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/hypr/adjust_scale.py +"),
	{ locked = true, repeating = true }
)
hl.bind(
	mainMod .. " + CTRL + down",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/hypr/adjust_scale.py -"),
	{ locked = true, repeating = true }
)

-- Opacity / blur / visuals toggles
hl.bind(
	mainMod .. " + ALT + period",
	hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/theme/cycle-appearance"),
	{ locked = true }
)
hl.bind(mainMod .. " + period", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }), { locked = true })
hl.bind(mainMod .. " + comma", hl.dsp.window.set_prop({ prop = "no_blur", value = "toggle" }), { locked = true })

-- Zoom
hl.bind(
	"SUPER + KP_Add",
	hl.dsp.exec_cmd(
		[[sh -c "hyprctl keyword cursor:zoom_factor \"$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {print $2 * 1.25}')\""]]
	),
	{ repeating = true }
)
hl.bind(
	"SUPER + KP_Subtract",
	hl.dsp.exec_cmd(
		[[sh -c "hyprctl keyword cursor:zoom_factor \"$(hyprctl getoption cursor:zoom_factor | awk 'NR==1 {val = $2 / 1.25; if (val < 1.0) val = 1.0; print val}')\""]]
	),
	{ repeating = true }
)
hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1.0"), { locked = true })

-- Hyprshade
-- hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("uwsm-app -- pkill rofi; " .. scripts .. "/rofi/shader_menu.sh"))
hl.bind(mainMod .. " + ALT + X", hl.dsp.exec_cmd("hyprshade off"), { locked = true })
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("hyprshade on saturation"), { locked = true })

-- Animation menu
-- hl.bind(
-- 	mainMod .. " + ALT + A",
-- 	hl.dsp.exec_cmd(
-- 		'uwsm-app -- pkill rofi; rofi -show animations -modi "animations:' .. scripts .. '/rofi/hypr_anim.sh"'
-- 	)
-- )

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
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(scripts .. "/google_image_search/google_image_search.sh"))

-- OCR
hl.bind(
	mainMod .. " + T",
	hl.dsp.exec_cmd("pgrep tesseract || (slurp | grim -g - - | tesseract stdin stdout -l eng | wl-copy)")
)
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("grim - | tesseract stdin stdout -l eng | wl-copy"))

-- Ollama sidebar
hl.bind(
	mainMod .. " + ALT + O",
	hl.dsp.exec_cmd("uwsm-app -- kitty --class ollama_terminal.sh -e " .. scripts .. "/llm/ollama_terminal.sh")
)

-- Music recognition
hl.bind(
	mainMod .. " + ALT + M",
	hl.dsp.exec_cmd(
		"uwsm-app -- kitty --hold --class music_recognition.sh -e " .. scripts .. "/music/music_recognition.sh"
	)
)

-- Kokoro TTS
hl.bind(
	mainMod .. " + O",
	hl.dsp.exec_cmd('wl-copy "$(wl-paste -p)" && uwsm-app -- ' .. scripts .. "/tts_stt/dusky_kokoro/trigger.sh")
)

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
hl.bind(mainMod .. " + X", hl.dsp.layout("swapsplit")) -- also on X (dual action, see source)

-- Smart float: toggle float → resize to 90% → center
hl.bind(
	mainMod .. " + D",
	hl.dsp.exec_cmd(
		[[if hyprctl -j activewindow | jq -e '.floating | not'; then hyprctl --batch "dispatch togglefloating; dispatch resizeactive exact 90% 90%; dispatch centerwindow"; else hyprctl dispatch togglefloating; fi]]
	)
)

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
hl.bind(mainMod .. " + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

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

-- Spotify special workspace toggle
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("uwsm-app -- " .. scripts .. "/spotify/spotify_toggle.sh"))

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
	hl.dsp.exec_cmd(osdclient .. " --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osdclient .. " --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(osdclient .. " --output-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd(osdclient .. " --input-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(osdclient .. " --brightness raise"), { locked = true, repeating = true })
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osdclient .. " --brightness lower"),
	{ locked = true, repeating = true }
)

-- Precise adjustments (Alt modifier)
hl.bind(
	"ALT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(osdclient .. " --output-volume +1"),
	{ locked = true, repeating = true }
)
hl.bind(
	"ALT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osdclient .. " --output-volume -1"),
	{ locked = true, repeating = true }
)
hl.bind(
	"ALT + XF86MonBrightnessUp",
	hl.dsp.exec_cmd(osdclient .. " --brightness +1"),
	{ locked = true, repeating = true }
)
hl.bind(
	"ALT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osdclient .. " --brightness -1"),
	{ locked = true, repeating = true }
)

-- Player controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdclient .. " --playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdclient .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdclient .. " --playerctl previous"), { locked = true })

-- Manual media binds
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("ALT + P", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })

-- Mono audio toggle
hl.bind("ALT + M", hl.dsp.exec_cmd(scripts .. "/audio/mono_audio_pipewire.sh"), { locked = true })

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
	hl.bind("Q", hl.dsp.exec_cmd(scripts .. "/hypr/mouse_move.sh left"), { repeating = true })
	hl.bind("E", hl.dsp.exec_cmd(scripts .. "/hypr/mouse_move.sh right"), { repeating = true })
	hl.bind(mainMod .. " + escape", function()
		hl.dispatch(hl.dsp.exec_cmd('notify-send -u low -t 2000 "Mouse Mode Disabled" "Keybinds restored"'))
		hl.dispatch(hl.dsp.submap("reset"))
	end, { locked = true })
end)

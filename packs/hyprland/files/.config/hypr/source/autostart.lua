-- AUTOSTART
-- Merged: source/autostart.conf + edit_here/source/autostart.conf
-- Uses UWSM: apps are wrapped with "uwsm-app --" for systemd tracking.

hl.on("hyprland.start", function()
	-- Plugins
	hl.exec_cmd("hyprpm reload")

	-- Wallpaper engine
	hl.exec_cmd("uwsm-app -- awww-daemon")

	-- Clipboard manager (text + images)
	hl.exec_cmd("uwsm-app -- wl-paste --type text  --watch cliphist store")
	hl.exec_cmd("uwsm-app -- wl-paste --type image --watch cliphist store")

	-- Waybar (auto-starts with 1-min timer script)
	hl.exec_cmd("uwsm-app -- " .. os.getenv("HOME") .. "/user_scripts/waybar/waybar_autostart.sh")

	-- Fix slow app launch: import env into systemd + dbus
	hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1)")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")

	-- Hyprshade (run after 5s delay so compositor is settled)
	hl.exec_cmd("sleep 5 && hyprshade on saturation")

	-- Input remapper (load saved presets)
	hl.exec_cmd("input-remapper-control --command autoload")

	-- EasyEffects audio processing (background service mode)
	hl.exec_cmd("easyeffects --gapplication-service")
end)

-- "exec = hyprshade on saturation" (runs on start AND every reload) is
-- approximated here. "hyprland.reload" may not exist in all Lua builds;
-- verify against your Hyprland version. If unsupported, run hyprshade via
-- a post-reload hook or add it to your shell reload alias instead.
hl.on("config.reloaded", function()
	hl.exec_cmd("hyprshade on saturation")
end)

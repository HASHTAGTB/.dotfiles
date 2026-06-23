-- HYPRLAND MAIN CONFIGURATION
-- System: UWSM Managed
--
-- Merged from edit_here/ overlays and translated from hyprlang to Lua.
-- Original .conf files are preserved for reference; conflicting source values
-- are shown as comments inside each module.
--
-- Load order mirrors the original hyprland.conf source order.

-- Shared matugen color table — available to all modules as the global `colors`
colors = (function()
	local c = {}
	local f = io.open(os.getenv("HOME") .. "/.config/matugen/generated/hyprland-colors.conf", "r")
	if f then
		for line in f:lines() do
			local k, v = line:match("^%$(%w+)%s*=%s*(.-)%s*$")
			if k and k ~= "image" then
				c[k] = v
			end
		end
		f:close()
	end
	return c
end)()

require("modules.monitors")
require("modules.environment_variables")
require("modules.permissions")
require("modules.input")
require("modules.appearance")
require("modules.window_rules")
require("modules.keybinds")
require("modules.autostart")

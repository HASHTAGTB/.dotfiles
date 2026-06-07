-- ENVIRONMENT VARIABLES
-- Source: source/environment_variables.conf
-- Note: Most env vars live in ~/.config/uwsm/env{,-hyprland}.
-- This file holds Hyprland-specific vars that UWSM shouldn't see.

-- Fixes "XDG_CURRENT_DESKTOP not set" warning on boot
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

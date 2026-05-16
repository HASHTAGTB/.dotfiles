-- PERMISSIONS
-- Source: source/permissions.conf
-- Uncomment ecosystem enforce block below to enable hardened mode.
-- These permission lines are only active when enforcement is on.

-- hl.config({ ecosystem = { enforce_permissions = true } })

hl.permission("/usr/(bin|local/bin)/grim",                              "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/slurp",                             "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland",  "screencopy", "allow")
hl.permission("/usr/bin/waybar",                                        "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/hyprpm",                            "plugin",     "allow")

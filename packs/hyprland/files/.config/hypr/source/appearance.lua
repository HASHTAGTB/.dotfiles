-- APPEARANCE
-- Merged: source/appearance.conf + edit_here/source/appearance.conf
--         + source/animations/active/active.conf (inlined)
-- Conflicts: edit_here values win; original source values shown as comments.
-- Colors: parsed live from matugen-generated hyprland-colors.conf so they
--         update automatically whenever matugen regenerates.

-- ---------------------------------------------------------------------------
-- Colors from shared matugen table (loaded in hyprland.lua)
-- ---------------------------------------------------------------------------
local primary            = colors.primary            or "rgba(a9c7ffff)"
local inverse_on_surface = colors.inverse_on_surface or "rgba(2e3035ff)"

-- ---------------------------------------------------------------------------
-- 1. GENERAL
-- ---------------------------------------------------------------------------
hl.config({
    general = {
        gaps_in          = 6,
        gaps_out         = 12,
        gaps_workspaces  = 0,
        border_size      = 2,

        col = {
            active_border   = primary,
            inactive_border = inverse_on_surface,
        },

        resize_on_border = false,
        allow_tearing    = true,   -- requires windowrule immediate on game classes
        layout           = "dwindle",

        snap = {
            enabled        = false,
            window_gap     = 10,
            monitor_gap    = 10,
            border_overlap = false,
        },
    },

-- ---------------------------------------------------------------------------
-- 2. DECORATION
-- ---------------------------------------------------------------------------
    decoration = {
        rounding       = 6,
        rounding_power = 6.0,

        -- [source had: active_opacity = 1.0, inactive_opacity = 1.0]
        active_opacity     = 0.8,
        inactive_opacity   = 0.6,
        fullscreen_opacity = 1.0,

        -- [source had: dim_inactive = true]
        dim_inactive = false,
        dim_strength = 0.2,
        dim_special  = 0.8,

        shadow = {
            -- [source had: enabled = false]
            enabled      = true,
            range        = 35,
            render_power = 2,
            sharp        = false,
            scale        = 1.0,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            -- [source had: enabled = false]
            enabled           = true,
            size              = 4,
            passes            = 2,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = false,
            noise             = 0.0117,
            contrast          = 0.8916,
            brightness        = 0.8172,
            vibrancy          = 0.1696,
            popups            = false,
        },
    },

    animations = {
        enabled = true,
    },

-- ---------------------------------------------------------------------------
-- 4. LAYOUTS
-- ---------------------------------------------------------------------------
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        column_width      = 0.667,
        follow_min_visible = 0.3,
    },

-- ---------------------------------------------------------------------------
-- 5. MISC
-- ---------------------------------------------------------------------------
    misc = {
        force_default_wallpaper  = 1,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

-- ---------------------------------------------------------------------------
-- 6. BINDS (visual-specific)
-- ---------------------------------------------------------------------------
    binds = {
        allow_pin_fullscreen = true,
    },
})

-- ---------------------------------------------------------------------------
-- 3. ANIMATIONS  (inlined from source/animations/active/active.conf)
--    "FLUID Dusky: The Showcase Edition"
-- ---------------------------------------------------------------------------
hl.curve("overshot",   { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1  } } })
hl.curve("fluid",      { type = "bezier", points = { { 0.25, 1   }, { 0,   1    } } })
hl.curve("snap",       { type = "bezier", points = { { 0.5,  0.9 }, { 0.1, 1.05 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1,  1   }, { 0,   1    } } })
hl.curve("liner",      { type = "bezier", points = { { 1,    1   }, { 1,   1    } } })

hl.animation({ leaf = "windowsIn",      enabled = true,  speed = 7,  bezier = "overshot",   style = "popin 80%" })
hl.animation({ leaf = "windowsOut",     enabled = true,  speed = 5,  bezier = "snap",       style = "popin 80%" })
hl.animation({ leaf = "windowsMove",    enabled = true,  speed = 7,  bezier = "overshot",   style = "slide" })
hl.animation({ leaf = "border",         enabled = true,  speed = 2,  bezier = "liner" })
hl.animation({ leaf = "borderangle",    enabled = true,  speed = 40, bezier = "liner",      style = "once" })
hl.animation({ leaf = "fade",           enabled = true,  speed = 5,  bezier = "fluid" })
hl.animation({ leaf = "layersIn",       enabled = true,  speed = 6,  bezier = "overshot",   style = "popin 70%" })
hl.animation({ leaf = "layersOut",      enabled = false, speed = 0,  bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",   enabled = true,  speed = 5,  bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut",  enabled = true,  speed = 4,  bezier = "menu_decel" })
hl.animation({ leaf = "workspaces",     enabled = true,  speed = 8,  bezier = "overshot",   style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 8, bezier = "overshot",   style = "slidevert" })

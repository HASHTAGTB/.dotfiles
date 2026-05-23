-- WINDOW RULES
-- Merged: source/window_rules.conf + edit_here/source/window_rules.conf
-- edit_here adds: pacseek rule (appended at bottom)

-- ---------------------------------------------------------------------------
-- XWAYLAND
-- ---------------------------------------------------------------------------
hl.config({ xwayland = { force_zero_scaling = true } })

-- ---------------------------------------------------------------------------
-- MEDIA PLAYERS
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "float-mpv",
	match = { class = "^(mpv)$" },
	float = true,
	opaque = true,
	size = "640 360",
	center = true,
})

-- -- ---------------------------------------------------------------------------
-- -- STEAM
-- -- ---------------------------------------------------------------------------
hl.window_rule({
	name = "steam-general",
	match = { class = "^(steam)$" },
	float = true,
	opaque = true,
})
hl.window_rule({
	name = "steam-main-window",
	match = { class = "^(steam)$", title = "^(Steam)$" },
	size = "1100 600",
	center = true,
})
hl.window_rule({
	name = "steam-friends",
	match = { class = "^(steam)$", title = "^(Friends List)$" },
	size = "460 580",
})
hl.window_rule({
	name = "steam-idle",
	match = { class = "^(steam)$" },
	idle_inhibit = "fullscreen",
})

-- ---------------------------------------------------------------------------
-- SHOW ME THE KEY
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "showmethekey-floating",
	match = { title = "^(Floating Window - Show Me The Key)$" },
	float = true,
	pin = true,
	size = "470 50",
	move = "((monitor_w-(window_w/2))/2) (monitor_h-window_h-20)",
	no_dim = true,
	border_size = 0,
	opaque = true,
})

-- ---------------------------------------------------------------------------
-- DESKTOP UTILITIES (alphabetical)
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "uGet",
	match = { title = "^(uGet)$" },
	float = true,
	size = "889 505",
	center = true,
})
hl.window_rule({
	name = "float-calculator",
	match = { class = "^(org.gnome.Calculator)$" },
	float = true,
	size = "360 616",
	center = true,
})
hl.window_rule({
	name = "gnome-camera",
	match = { class = "^(org.gnome.Snapshot)$" },
	float = true,
	size = "528 298",
	center = true,
})
hl.window_rule({
	name = "float-cameractrls-viewfinder",
	match = { class = "^(hu.irl.cameractrls)$", title = "^(/dev/.*)$" },
	float = true,
	size = "624 353",
	center = true,
})
hl.window_rule({
	name = "float-loupe",
	match = { class = "^(org.gnome.Loupe)$" },
	float = true,
	opaque = true,
	size = "900 600",
	center = true,
})
hl.window_rule({
	name = "float-clocks",
	match = { class = "^(org.gnome.clocks)$" },
	float = true,
	size = "602 297",
	center = true,
})
hl.window_rule({
	name = "gparted",
	match = { class = "^(GParted)$" },
	float = true,
	size = "652 431",
	center = true,
})
hl.window_rule({
	name = "grsync",
	match = { class = "^(grsync)$" },
	float = true,
	size = "650 458",
	center = true,
})
hl.window_rule({
	name = "float-blueman",
	match = { class = "^(blueman-manager)$" },
	float = true,
	size = "530 313",
	center = true,
})
hl.window_rule({
	name = "handbrake",
	match = { class = "^(fr.handbrake.ghb)$" },
	float = true,
	size = "970 698",
	center = true,
})
hl.window_rule({
	name = "seahorse",
	match = { class = "^(org.gnome.seahorse.Application)$" },
	float = true,
	size = "827 632",
	center = true,
})
hl.window_rule({
	name = "bluetui",
	match = { class = "^(bluetui)$" },
	float = true,
	size = "551 362",
	center = true,
})
hl.window_rule({
	name = "airmon_ng",
	match = { class = "^(airmon_ng.sh)$" },
	float = true,
	size = "775 450",
	center = true,
})
hl.window_rule({
	name = "iphone_vnc.sh",
	match = { class = "^(iphone_vnc.sh)$" },
	float = true,
	size = "650 423",
	center = true,
})
hl.window_rule({
	name = "btrfs_zstd_compression_stats.sh",
	match = { class = "^(btrfs_zstd_compression_stats.sh)$" },
	float = true,
	size = "650 423",
	center = true,
})
hl.window_rule({
	name = "tailscale_setup",
	match = { class = "^(tailscale_setup)$" },
	float = true,
	size = "775 450",
	center = true,
})
hl.window_rule({
	name = "tailscale_uninstall",
	match = { class = "^(tailscale_uninstall)$" },
	float = true,
	size = "775 450",
	center = true,
})
hl.window_rule({
	name = "kew",
	match = { class = "^(kew)$" },
	float = true,
	size = "652 576",
	center = true,
})
hl.window_rule({
	name = "file_manager_switcher",
	match = { class = "^(235_file_manager_switch.sh)$" },
	float = true,
	size = "520 320",
	center = true,
})
hl.window_rule({
	name = "ftp_setup_arch.sh",
	match = { class = "^(250_ftp_arch.sh)$" },
	float = true,
	size = "652 576",
	center = true,
})
hl.window_rule({
	name = "325_hosts_files_block.sh",
	match = { class = "^(325_hosts_files_block.sh)$" },
	float = true,
	size = "827 575",
	center = true,
})
hl.window_rule({
	name = "change_ftp_directory_server.sh",
	match = { class = "^(change_ftp_directory_server.sh)$" },
	float = true,
	size = "652 576",
	center = true,
})
hl.window_rule({
	name = "arp_scan.sh",
	match = { class = "^(arp_scan.sh)$" },
	float = true,
	size = "652 576",
	center = true,
})
hl.window_rule({
	name = "02_openssh_setup.sh",
	match = { class = "^(02_openssh_setup.sh)$" },
	float = true,
	size = "652 576",
	center = true,
})
hl.window_rule({
	name = "clipboard_persistance",
	match = { class = "^(clipboard_persistance.sh)$" },
	float = true,
	size = "589 529",
	center = true,
})
hl.window_rule({
	name = "cache_purge",
	match = { class = "^(cache_purge.sh)$" },
	float = true,
	size = "589 529",
	center = true,
})
hl.window_rule({
	name = "mouse_button_reverse",
	match = { class = "^(mouse_button_reverse.sh)$" },
	float = true,
	size = "589 529",
	center = true,
})
hl.window_rule({
	name = "300_git_config.sh",
	match = { class = "^(300_git_config.sh)$" },
	float = true,
	size = "726 389",
	center = true,
})
hl.window_rule({
	name = "305_new_github_repo_to_backup.sh",
	match = { class = "^(305_new_github_repo_to_backup.sh)$" },
	float = true,
	size = "726 689",
	center = true,
})
hl.window_rule({
	name = "310_reconnect_and_push_new_changes_to_github.sh",
	match = { class = "^(310_reconnect_and_push_new_changes_to_github.sh)$" },
	float = true,
	size = "726 689",
	center = true,
})
hl.window_rule({
	name = "io_monitor.sh",
	match = { class = "^(io_monitor.sh)$" },
	float = true,
	size = "943 247",
	center = true,
})
hl.window_rule({
	name = "terminal_clipboard",
	match = { class = "^(terminal_clipboard.sh)$" },
	float = true,
	no_anim = true,
	size = "680 460",
	center = true,
})
hl.window_rule({
	name = "asusctl.sh",
	match = { class = "^(asusctl.sh)$" },
	float = true,
	size = "730 454",
	center = true,
})
hl.window_rule({
	name = "090_paru_packages_optional.sh",
	match = { class = "^(090_paru_packages_optional%.sh)$" },
	float = true,
	size = "831 572",
})
hl.window_rule({
	name = "dusky_wayclick.sh",
	match = { class = "^(dusky_wayclick.sh)$" },
	float = true,
	size = "831 572",
})
hl.window_rule({
	name = "dusky_tui_wayclick.sh",
	match = { class = "^(dusky_tui_wayclick.sh)$" },
	float = true,
	size = "790 530",
})
hl.window_rule({
	name = "285_tty_autologin.sh",
	match = { class = "^(285_tty_autologin.sh)$" },
	float = true,
	size = "730 454",
	center = true,
})
hl.window_rule({
	name = "dusky_monitor.sh",
	match = { class = "^(dusky_monitor.sh)$" },
	float = true,
	size = "857 522",
	center = true,
})
hl.window_rule({
	name = "dusky_keybinds.sh",
	match = { class = "^(dusky_keybinds.sh)$" },
	float = true,
	size = "(monitor_w*0.9) (monitor_h*0.9)",
	move = "(monitor_w*0.05) (monitor_h*0.05)",
})
hl.window_rule({
	name = "dusky_appearances.sh",
	match = { class = "^(dusky_appearances.sh)$" },
	float = true,
	size = "790 530",
	center = true,
})
hl.window_rule({
	name = "dusky_matugen_presets.sh",
	match = { class = "^(dusky_matugen_presets.sh)$" },
	float = true,
	size = "820 620",
	center = true,
})
hl.window_rule({
	name = "dusky_input.sh",
	match = { class = "^(dusky_input.sh)$" },
	float = true,
	size = "790 530",
	center = true,
})
hl.window_rule({
	name = "dusky_power.sh",
	match = { class = "^(dusky_power.sh)$" },
	float = true,
	size = "790 530",
	center = true,
})
hl.window_rule({
	name = "dusky_battery_notify.sh",
	match = { class = "^(dusky_battery_notify.sh)$" },
	float = true,
	size = "790 530",
	center = true,
})
hl.window_rule({
	name = "135_battery_notify_service.sh",
	match = { class = "^(135_battery_notify_service.sh)$" },
	float = true,
	size = "504 501",
	center = true,
})
hl.window_rule({
	name = "dusky_hypridle.sh",
	match = { class = "^(dusky_hypridle.sh)$" },
	float = true,
	size = "790 530",
	center = true,
})
hl.window_rule({
	name = "fastfetch",
	match = { class = "^(fastfetch)$" },
	float = true,
	size = "943 393",
	center = true,
})
hl.window_rule({
	name = "kitty",
	match = { class = "^(dusky_window_rules.sh)$" },
	float = true,
	size = "1025 753",
	center = true,
})
hl.window_rule({
	name = "dysk",
	match = { class = "^(dysk)$" },
	float = true,
	size = "1005 298",
	center = true,
})
hl.window_rule({
	name = "performance.sh",
	match = { class = "^(performance.sh)$" },
	float = true,
	size = "566 569",
	center = true,
})
hl.window_rule({
	name = "kokoro",
	match = { class = "^(kokoro)$" },
	float = true,
	pin = true,
	size = "254 90",
	move = "(monitor_w-window_w-8) (monitor_h-window_h-8)",
	no_dim = true,
	opaque = true,
})
hl.window_rule({
	name = "kokoro_installer.sh",
	match = { class = "^(kokoro_installer.sh)$" },
	float = true,
	pin = true,
	size = "876 601",
})
hl.window_rule({
	name = "peaclock",
	match = { class = "^(peaclock)$" },
	float = true,
	center = true,
	size = "406 179",
})
hl.window_rule({
	name = "wifitui_float",
	match = { class = "^(wifitui)$" },
	float = true,
	size = "596 318",
	center = true,
})
hl.window_rule({
	name = "dusky_network.sh",
	match = { class = "^(dusky_network.sh)$" },
	float = true,
	size = "840 598",
	center = true,
})
hl.window_rule({
	name = "tray-tui",
	match = { class = "^(tray-tui)$" },
	float = true,
	size = "791 488",
	center = true,
})
hl.window_rule({
	name = "cava",
	match = { class = "^(cava)$" },
	float = true,
	size = "791 488",
	center = true,
})
hl.window_rule({
	name = "htop",
	match = { class = "^(htop)$" },
	float = true,
	size = "1080 607",
	center = true,
})
hl.window_rule({
	name = "nvtop",
	match = { class = "^(nvtop)$" },
	float = true,
	size = "1080 607",
	center = true,
})
hl.window_rule({
	name = "dgop",
	match = { class = "^(dgop)$" },
	float = true,
	size = "1080 607",
	center = true,
})
hl.window_rule({
	name = "btop",
	match = { class = "^(btop)$" },
	float = true,
	size = "1080 607",
	center = true,
})
hl.window_rule({
	name = "wavemon",
	match = { class = "^(wavemon)$" },
	float = true,
	size = "1180 680",
	center = true,
})
hl.window_rule({
	name = "nvim",
	match = { class = "^(nvim)$" },
	float = true,
	size = "455 549",
	center = true,
})
hl.window_rule({
	name = "org.gnome.TextEditor",
	match = { class = "^(org.gnome.TextEditor)$" },
	float = true,
	size = "(monitor_w*0.65) (monitor_h*0.92)",
	move = "(monitor_w*0.05) (monitor_h*0.05)",
	center = true,
})
hl.window_rule({
	name = "errands",
	match = { title = "^(Errands)$" },
	float = true,
	size = "519 614",
	center = true,
})
hl.window_rule({
	name = "backups_dusky",
	match = { class = "^(thunar)$", title = "^(dusky_backups - Thunar)$" },
	float = true,
	size = "(monitor_w*0.5612) (monitor_h*0.8)",
	center = true,
})
hl.window_rule({
	name = "yazi",
	match = { class = "^(yazi)$", title = "^(Backup Viewer)$" },
	float = true,
	size = "(monitor_w*0.6283) (monitor_h*0.8600)",
	center = true,
})
hl.window_rule({
	name = "dusky_control_center.py",
	match = { title = "^(Dusky Control Center)$", class = "^(com.github.dusky.controlcenter)$" },
	float = true,
	animation = "slide down",
	size = "(monitor_w*0.50) (monitor_h*0.92)",
	move = "(monitor_w*0.05) (monitor_h*0.05)",
	center = true,
})
hl.window_rule({
	name = "disks",
	match = { title = "^(Disks)$", class = "^(org.gnome.DiskUtility)$" },
	float = true,
	size = "890 512",
	center = true,
})
hl.window_rule({
	name = "baobab",
	match = { class = "^(org.gnome.baobab)$" },
	float = true,
	size = "1152 648",
	center = true,
})
hl.window_rule({ name = "float_thunar_rename", match = { class = "Thunar", title = "^Rename.*$" }, float = true })
hl.window_rule({
	name = "sysbench_benchmark.sh",
	match = { class = "^(sysbench_benchmark.sh)$" },
	float = true,
	size = "567 658",
	center = true,
})
hl.window_rule({
	name = "ntfs_fix.sh",
	match = { class = "^(ntfs_fix.sh)$" },
	float = true,
	size = "766 485",
	center = true,
})
hl.window_rule({
	name = "power_saver.sh",
	match = { class = "^(power_saver.sh)$" },
	float = true,
	size = "568 456",
	center = true,
})
hl.window_rule({
	name = "power_saver_off.sh",
	match = { class = "^(power_saver_off.sh)$" },
	float = true,
	size = "568 456",
	center = true,
})
hl.window_rule({
	name = "080_aur_paru_fallback_yay.sh",
	match = { class = "^(080_aur_paru_fallback_yay.sh)$" },
	float = true,
	size = "567 658",
	center = true,
})
hl.window_rule({
	name = "085_warp.sh",
	match = { class = "^(085_warp.sh)$" },
	float = true,
	size = "567 658",
	center = true,
})
hl.window_rule({
	name = "335_preload_config.sh",
	match = { class = "^(335_preload_config.sh)$" },
	float = true,
	size = "889 669",
	center = true,
})
hl.window_rule({
	name = "465_sddm_setup.sh",
	match = { class = "^(465_sddm_setup.sh)$" },
	float = true,
	size = "889 669",
	center = true,
})
hl.window_rule({
	name = "update_dusky.sh",
	match = { class = "^(update_dusky.sh)$" },
	float = true,
	size = "1192 710",
	center = true,
})
hl.window_rule({
	name = "ORCHESTRA.sh",
	match = { class = "^(ORCHESTRA.sh)$" },
	float = true,
	size = "(monitor_w*0.9) (monitor_h*0.9)",
	move = "(monitor_w*0.05) (monitor_h*0.05)",
})
hl.window_rule({
	name = "deploy_dotfiles.sh",
	match = { class = "^(deploy_dotfiles.sh)$" },
	float = true,
	size = "(monitor_w*0.9) (monitor_h*0.9)",
	move = "(monitor_w*0.05) (monitor_h*0.05)",
})
hl.window_rule({
	name = "restore_stash.sh",
	match = { class = "^(restore_stash.sh)$" },
	float = true,
	size = "1192 710",
	center = true,
})
hl.window_rule({
	name = "send_logs.sh",
	match = { class = "^(send_logs.sh)$" },
	float = true,
	size = "500 250",
	center = true,
})
hl.window_rule({
	name = "about_dusky.sh",
	match = { class = "^(about_dusky.sh)$" },
	float = true,
	size = "503 264",
	center = true,
})
hl.window_rule({
	name = "ollama_terminal.sh",
	match = { class = "^(ollama_terminal.sh)$" },
	float = true,
	size = "(monitor_w*0.28) (monitor_h*0.88)",
	animation = "slide left",
	rounding = 9,
	move = "(monitor_w*0.038) (monitor_h*0.5 - window_h*0.5)",
})
hl.window_rule({
	name = "dusky_service_toggle.sh",
	match = { class = "^(dusky_service_toggle.sh)$" },
	float = true,
	size = "840 598",
	center = true,
})
hl.window_rule({
	name = "music_recognition.sh",
	match = { class = "^(music_recognition.sh)$" },
	float = true,
	size = "409 147",
	center = true,
})
hl.window_rule({
	name = "dusky_hyprlock_switcher.sh",
	match = { class = "^(dusky_hyprlock_switcher.sh)$" },
	float = true,
	size = "871 521",
	center = true,
})
hl.window_rule({
	name = "dusky_waybars.sh",
	match = { class = "^(dusky_waybars.sh)$" },
	float = true,
	size = "810 520",
	center = true,
})
hl.window_rule({
	name = "dusky_swaync_side.sh",
	match = { class = "^(dusky_swaync_side.sh)$" },
	float = true,
	size = "553 490",
	center = true,
})
hl.window_rule({
	name = "float-zathura",
	match = { class = "^(org.pwmt.zathura)$" },
	float = true,
	size = "655 526",
	center = true,
})
hl.window_rule({
	name = "float-waypaper",
	match = { class = "^(waypaper)$" },
	float = true,
	size = "786 492",
	center = true,
})
hl.window_rule({
	name = "float-share-picker",
	match = { class = "^(hyprland-share-picker)$" },
	float = true,
	size = "500 300",
	center = true,
})
hl.window_rule({
	name = "float-nwg-look",
	match = { class = "^(nwg-look)$" },
	float = true,
	size = "627 464",
	center = true,
})
hl.window_rule({
	name = "float-kvantum",
	match = { class = "^(kvantummanager)$" },
	float = true,
	size = "585 512",
	center = true,
})
hl.window_rule({
	name = "float-qt6ct",
	match = { class = "^(qt6ct)$" },
	float = true,
	size = "700 609",
	center = true,
})
hl.window_rule({
	name = "float-qt5ct",
	match = { class = "^(qt5ct)$" },
	float = true,
	size = "636 665",
	center = true,
})
hl.window_rule({
	name = "float-guifetch",
	match = { class = "^(guifetch)$" },
	float = true,
	size = "800 500",
	center = true,
})
hl.window_rule({
	name = "float-pavucontrol",
	match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" },
	float = true,
	size = "643 422",
	center = true,
})
hl.window_rule({
	name = "float-nm-editor",
	match = { class = "^(nm-connection-editor)$" },
	float = true,
	size = "432 423",
	center = true,
})
hl.window_rule({
	name = "float_vm_viewer",
	match = { class = "^(virt-manager)$", title = "^(.* on QEMU/KVM)$" },
	float = true,
	center = true,
	size = "1043 634",
})

-- ---------------------------------------------------------------------------
-- PICTURE-IN-PICTURE
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "pip-global",
	match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
	float = true,
	pin = true,
	size = "248 140",
	move = "(monitor_w-window_w-20) (monitor_h-window_h-20)",
	no_dim = true,
	opaque = true,
})

-- Pinned window styling (green border, no dim)
hl.window_rule({
	name = "style-pinned-windows",
	match = { pin = true },
	no_dim = true,
	border_color = "rgb(328E6E)",
	border_size = 2,
	animation = "slide left",
})

-- ---------------------------------------------------------------------------
-- GLOBAL BEHAVIORS
-- ---------------------------------------------------------------------------
hl.window_rule({ name = "global-persistent-size", match = { float = true }, persistent_size = true })
hl.window_rule({ name = "global-suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

-- ---------------------------------------------------------------------------
-- XWAYLAND PHANTOM WINDOW FIX
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "fix-xwayland-phantom",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

-- -- ---------------------------------------------------------------------------
-- -- FULLSCREEN STYLING
-- -- ---------------------------------------------------------------------------
-- hl.window_rule({
-- 	name = "style-fullscreen",
-- 	match = { fullscreen = true },
-- 	border_color = "rgb(E2971F)",
-- 	border_size = 4,
-- 	rounding = 0,
-- })

-- ---------------------------------------------------------------------------
-- COMMON DIALOGS
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "float-dialogs-title",
	match = {
		title = "^(Open|Open File|Select a File|Choose wallpaper|Open Folder|Save As|Library|File Upload|Authentication Required|Add Folder to Workspace|Choose Files|Confirm to replace files|File Operation Progress)(.*)$|^(.*dialog.*)$",
	},
	float = true,
	center = true,
	size = "816 537",
})
hl.window_rule({
	name = "float-dialogs-class",
	match = { class = "^(org.gnome.FileRoller|[Xx]dg-desktop-portal-gtk|.*dialog.*)$" },
	float = true,
	center = true,
	size = "816 537",
})

-- ---------------------------------------------------------------------------
-- LAYER RULES
-- ---------------------------------------------------------------------------
hl.layer_rule({
	name = "swaync_slide",
	match = { namespace = "swaync-control-center" },
	animation = "slide left",
	dim_around = false,
	blur = true,
	xray = false,
	ignore_alpha = 0.3,
})
hl.layer_rule({
	name = "swaync_notifications",
	match = { namespace = "swaync-notification-window" },
	blur = true,
	ignore_alpha = 0.2,
})
hl.layer_rule({
	name = "rofi",
	match = { namespace = "rofi" },
})
hl.layer_rule({
	name = "logout_dialog_style",
	match = { namespace = "logout_dialog" },
	blur = true,
	ignore_alpha = 0.0,
})
hl.layer_rule({
	name = "selection_white_menu",
	match = { namespace = "selection" },
	blur = false,
	no_anim = true,
})

-- ---------------------------------------------------------------------------
-- SPECIAL WORKSPACES
-- ---------------------------------------------------------------------------
hl.workspace_rule({ workspace = "special:magic", gaps_out = 20, gaps_in = 6 })
hl.window_rule({
	name = "style-magic-workspace",
	match = { workspace = "special:magic" },
	border_color = colors.primary or "rgba(a9c7ffff)",
	border_size = 1,
})

-- ---------------------------------------------------------------------------
-- MISC (focus/fullscreen interaction)
-- ---------------------------------------------------------------------------
hl.config({
	misc = {
		on_focus_under_fullscreen = 2,
		initial_workspace_tracking = 1,
		focus_on_activate = true,
	},
})

-- ueberzug (image preview helper — float with no animation/shadow/focus)
hl.window_rule({
	name = "ueberzug",
	match = { class = "ueberzug.*" },
	float = true,
	no_anim = true,
	no_shadow = true,
	no_focus = true,
})

-- ---------------------------------------------------------------------------
-- FROM edit_here/source/window_rules.conf
-- ---------------------------------------------------------------------------
hl.window_rule({
	name = "pacseek",
	match = { title = ".*pacseek.*" },
	float = true,
	size = "1080 607",
	center = true,
})

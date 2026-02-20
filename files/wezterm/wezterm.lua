local wezterm = require 'wezterm';
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local opts = {
    position = "top",
    modules = {
        workspace = {
            enabled = false
        },
        pane = {
            enabled = false
        },
        username = {
            enabled = false
        },
        clock = {
            enabled = false
        }
    }
}

local config = {
    font = wezterm.font("MesloLGS NF"),
    font_size = 12.0,
    exit_behavior = "Close",
    check_for_updates = false,
    enable_tab_bar = true,
    color_scheme = "Espresso",
    keys = {{
        key = 'Enter',
        mods = 'SHIFT',
        action = wezterm.action.SendString('\x1b[13;2u')
    }}
}

bar.apply_to_config(config, opts)

return config;

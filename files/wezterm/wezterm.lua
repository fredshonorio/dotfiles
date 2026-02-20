local wezterm = require 'wezterm';
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez");

print(tabline.get_theme())
tabline.setup({
  options = {
    --theme_overrides = {
     -- tab = {
       --       active = { fg = '#89b4fa', bg = '#313244' },
        --inactive = { fg = '#cdd6f4', bg = '#181825' },
      --}
    --},
    icons_enabled = true,
    theme = 'Espresso',
    tabs_enabled = true,
    theme_overrides = {},
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { },
    tabline_b = { },
    tabline_c = { },
    tab_active = {
      
{Attribute={Underline="Curly"}},
      'index',
      {Attribute={Underline="Curly"}},
      { 'cwd', padding = { left = 0, right = 1 } },
      {Attribute={Underline="Curly"}},
      ":: ",
      {Attribute={Underline="Curly"}},
      { 'process'},
    },
    tab_inactive = { 'index', 
      { 'cwd', padding = { left = 0, right = 1 } },
      ":: ",
      { 'process' },
  },
    tabline_x = { },
    tabline_y = {  },
    tabline_z = { 'hostname' },
  },
  extensions = {},
})


local config = {
  font = wezterm.font("MesloLGS NF"),
  font_size = 12.0,
  exit_behavior = "Close",
  check_for_updates = false,
  enable_tab_bar = true,
  color_scheme = "Espresso",
  keys = {
    {
      key = 'Enter',
      mods = 'SHIFT',
      action = wezterm.action.SendString('\x1b[13;2u'),
    },
  }
}

tabline.apply_to_config(config)

return config;
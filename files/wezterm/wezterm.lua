local wezterm = require 'wezterm';

return {
  font = wezterm.font("MesloLGS NF"),
  font_size = 12.0,
  exit_behavior = "Close",
  check_for_updates = false,
  enable_tab_bar = false,
  color_scheme = "Espresso",
  keys = {
    {
      key = 'Enter',
      mods = 'SHIFT',
      action = wezterm.action.SendString('\x1b[13;2u'),
    },
  }
}


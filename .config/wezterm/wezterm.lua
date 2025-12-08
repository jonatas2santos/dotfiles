-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Variable for keybinds
local act = wezterm.action

-- For windows, use pwsh as the default shell
-- config.default_prog = { 'pwsh.exe', '-NoLogo' }

-- Hyprland fix
config.enable_wayland = false

-- Disable close confirmation
config.window_close_confirmation = 'NeverPrompt'

-- This is where you actually apply your config choices.

-- disable window buttons
config.window_decorations = "RESIZE"

-- Tab bar
config.use_fancy_tab_bar = true            -- tab style native or retro
config.enable_tab_bar = true               -- enable tab bar
config.hide_tab_bar_if_only_one_tab = true -- hide tab bar automatically
-- tab bar configuration
config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono Nerd Font Mono', weight = 'Bold' }, -- font tab bar
  font_size = 8.0,                                                    -- tab bar font size
  -- tab bar colors
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#FFFFFF',
}
config.colors = {
  tab_bar = {
    -- color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  },
}

-- Font
config.font = wezterm.font('JetBrains Mono Nerd Font Mono', { weight = 'Bold', italic = true }) -- fonts of your choice, with bold and italic enabled
config.font_size = 13.0                                                            -- font size

-- Appearance
config.color_scheme = 'Oxocarbon Dark (Gogh)' -- set the color scheme
config.window_background_opacity = 1.0        -- background opacity
-- config.window_background_image = '/path/to/wallpaper.jpg' -- set image as background
config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.3,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,

  -- You can adjust the saturation also.
  saturation = 1.0,
}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- Spawn a fish shell in login mode
-- config.default_prog = { '/usr/local/bin/fish', '-l' }

-- Keybinds
config.disable_default_key_bindings = true -- disable all default keybinds
config.keys = {
  -- yazi
  {
    key = 'y',
    mods = 'CTRL|ALT',
    action = act.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { 'yazi' },
    },
  },
  -- copy to clipboard
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo 'ClipboardAndPrimarySelection',
  },

  -- paste from clipboard
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = act.PasteFrom 'Clipboard',
  },
  -- {
  --   key = 'v',
  --   mods = 'CTRL|SHIFT',
  --   action = act.PasteFrom 'PrimarySelection',
  -- },

  -- new window
  {
    key = 'n',
    mods = 'CTRL|ALT',
    action = act.SpawnWindow,
  },

  -- toggle fullscreen
  {
    key = 'Enter',
    mods = 'CTRL|ALT',
    action = act.ToggleFullScreen,
  },

  -- scroll page up/down
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(-1),
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = act.ScrollByPage(1),
  },

  -- show debug overlay
  {
    key = 'd',
    mods = 'CTRL|ALT',
    action = act.ShowDebugOverlay,
  },

  -- command palette
  {
    key = ';',
    mods = 'CTRL',
    action = act.ActivateCommandPalette,
  },

  -- split vertical/horizontal
  {
    key = 'v',
    mods = 'CTRL|ALT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'b',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- decrease/increase/reset font size
  {
    key = '_',
    mods = 'CTRL|SHIFT',
    action = act.DecreaseFontSize,
  },
  {
    key = '+',
    mods = 'CTRL|SHIFT',
    action = act.IncreaseFontSize,
  },
  {
    key = '`',
    mods = 'CTRL|SHIFT',
    action = act.ResetFontSize,
  },

  -- new tab (current directory)
  {
    key = 'c',
    mods = 'CTRL|ALT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },

  -- new tab
  {
    key = 't',
    mods = 'CTRL|ALT',
    action = act.SpawnTab 'DefaultDomain',
  },

  -- close pane
  {
    key = 'q',
    mods = 'CTRL|ALT',
    action = act.CloseCurrentPane { confirm = false },
  },

  -- move between panes
  {
    key = 'h',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection 'Right',
  },

  -- toggle tabs
  {
    key = 'H',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(1),
  },

  -- move tabs
  {
    key = '[',
    mods = 'CTRL|ALT',
    action = act.MoveTabRelative(-1),
  },
  {
    key = ']',
    mods = 'CTRL|ALT',
    action = act.MoveTabRelative(1),
  },
  -- change to a specific tab
  {
    key = '1',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(0),
  },
  {
    key = '2',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(1),
  },
  {
    key = '3',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(2),
  },
  {
    key = '4',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(3),
  },
  {
    key = '5',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(4),
  },
  {
    key = '6',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(5),
  },
  {
    key = '7',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(6),
  },
  {
    key = '8',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(7),
  },
  {
    key = '9',
    mods = 'CTRL|ALT',
    action = act.ActivateTab(-1),
  },
}

-- Finally, return the configuration to wezterm:
return config

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Darktooth (base16)"

--config.font = wezterm.font 'Monaco'
--config.font = wezterm.font 'Andala Mono'
--config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold', italic = true })
-- config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = true })
wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }) -- /Users/mesterlum/Library/Fonts/JetBrainsMono-Bold.ttf, CoreText
-- wezterm.font("Mononoki Nerd") -- /Users/mesterlum/Library/Fonts/JetBrainsMono-Bold.ttf, CoreText
config.font_size = 15

config.hide_tab_bar_if_only_one_tab = true
config.hide_mouse_cursor_when_typing = true

-- and finally, return the configuration to wezterm
return config

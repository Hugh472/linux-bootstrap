local wezterm = require 'wezterm'

return {
    keys = {
        -- Map Option + Left Arrow to move backward by word
        {key="LeftArrow", mods="ALT", action=wezterm.action{SendString="\x1bb"}},
        -- Map Option + Right Arrow to move forward by word
        {key="RightArrow", mods="ALT", action=wezterm.action{SendString="\x1bf"}},
    },
}

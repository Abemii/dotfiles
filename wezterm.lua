local wezterm = require("wezterm")

local is_mac = wezterm.target_triple:find("darwin") ~= nil
local config = {}

-----------------------------------------------------------
-- 共通設定
-----------------------------------------------------------

config.colors = {
    foreground = "#dcdfe4",
    background = "#282c34",
    cursor_bg = "#dcdfe4",
    cursor_border = "#dcdfe4",
    cursor_fg = "#282c34",
    selection_bg = "#44475a",
    selection_fg = "#f8f8f2",
    ansi = {
        "#282c34",
        "#e06c75",
        "#98c379",
        "#e5c07b",
        "#61afef",
        "#c678dd",
        "#56b6c2",
        "#dcdfe4",
    },
    brights = {
        "#282c34",
        "#e06c75",
        "#98c379",
        "#e5c07b",
        "#61afef",
        "#c678dd",
        "#56b6c2",
        "#dcdfe4",
    },
}

-- フォント設定
config.font = wezterm.font("HackGen Console NF")
config.font_size = 14.0

-- ベル音を無効化
config.audible_bell = "Disabled"

-- その他見た目
config.enable_tab_bar = false
config.use_fancy_tab_bar = false

-- 背景の透過を防ぐ
config.window_background_opacity = 1.0

config.use_ime = true

---------------------------------------
-- OS 別設定
---------------------------------------
if is_mac then
    -- macOS 専用設定
    config.front_end = "OpenGL" -- Intel Mac で特に有効
    config.max_fps = 60
    config.animation_fps = 60
    config.window_decorations = "RESIZE"

    -- mac の Option キーを Alt として扱う
    config.send_composed_key_when_left_alt_is_pressed = true
    config.send_composed_key_when_right_alt_is_pressed = false

    -- フォントのアンチエイリアス設定
    config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
else
    -- Linux 専用設定
    config.front_end = "WebGpu"
end

return config

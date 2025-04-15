local wezterm = require("wezterm")

return {
    -- カラー設定
    colors = {
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
    },

    -- フォント設定
    font = wezterm.font("HackGen Console NF"),
    font_size = 14.0,

    -- ベル音を無効化
    audible_bell = "Disabled",

    -- その他見た目
    enable_tab_bar = false,
    use_fancy_tab_bar = false,

    -- 背景の透過を防ぐ
    window_background_opacity = 1.0,
}

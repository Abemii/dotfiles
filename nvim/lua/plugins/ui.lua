return {
    -- Colorscheme
    {
        "joshdick/onedark.vim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("onedark")
        end,
    },

    -- Rainbow parentheses (basic version)
    {
        "kien/rainbow_parentheses.vim",
        event = "VeryLazy",
        init = function()
            vim.g.rbpt_colorpairs = {
                { "brown", "RoyalBlue3" },
                { "Darkblue", "SeaGreen3" },
                { "darkgray", "DarkOrchid3" },
                { "darkgreen", "firebrick3" },
                { "darkcyan", "RoyalBlue3" },
                { "darkred", "SeaGreen3" },
                { "darkmagenta", "DarkOrchid3" },
                { "brown", "firebrick3" },
                { "gray", "RoyalBlue3" },
                { "darkmagenta", "DarkOrchid3" },
                { "Darkblue", "firebrick3" },
                { "darkgreen", "RoyalBlue3" },
                { "darkcyan", "SeaGreen3" },
                { "darkred", "DarkOrchid3" },
                { "red", "firebrick3" },
            }
        end,
        config = function()
            vim.cmd([[
              augroup RainbowParenthesesAutoload
                autocmd!
                autocmd VimEnter * RainbowParenthesesToggle
                autocmd Syntax * RainbowParenthesesLoadRound
                autocmd Syntax * RainbowParenthesesLoadSquare
                autocmd Syntax * RainbowParenthesesLoadBraces
              augroup END
        ]])
        end,
    },

    -- Filetype icons (used by many plugins)
    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
    },

    -- Tint inactive windows
    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup({
                -- Override some defaults
                tint = -10, -- Darken colors, use a positive value to brighten
                saturation = 0.6, -- Saturation to preserve
                transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
                tint_background_colors = true, -- Tint background portions of highlight groups
                highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
                window_ignore_function = function(winid)
                    local bufid = vim.api.nvim_win_get_buf(winid)
                    local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
                    local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

                    -- Do not tint `terminal` or floating windows, tint everything else
                    return buftype == "terminal" or buftype == "nofile" or floating
                end,
            })
        end,
    },
}

return {
    -- コメントトグル
    {
        "scrooloose/nerdcommenter",
        event = "VeryLazy",
        init = function()
            vim.g.NERDSpaceDelims = 1
            vim.g.NERDCompactSexyComs = 1
            vim.g.NERDDefaultAlign = "left"
            vim.g.NERDAltDelims_java = 1
            vim.g.NERDCustomDelimiters = {
                c = { left = "/**", right = "*/" },
                prototxt = { left = "#" },
            }
            vim.g.NERDCommentEmptyLines = 1
            vim.g.NERDTrimTrailingWhitespace = 1
        end,
    },

    -- repeat.vim: . で surround 等の操作を繰り返し可能にする
    {
        "tpope/vim-repeat",
        lazy = true,
    },

    -- easy-align: テキスト整列
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "n" },
            { "ga", "<Plug>(EasyAlign)", mode = "x" },
        },
    },

    -- auto-pairs
    {
        "jiangmiao/auto-pairs",
        event = "InsertEnter",
    },

    -- vim-surround
    {
        "tpope/vim-surround",
        event = "VeryLazy",
    },
}

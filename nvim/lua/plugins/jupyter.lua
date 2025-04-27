return {
    -- molten-nvim の設定
    {
        "3rd/image.nvim",
        opts = {
            rocks = {
                hererocks = false,
            },
        },
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = true
            vim.g.molten_image_provider = "image.nvim"
        end,
    },

    -- jupytext.nvim の設定
    {
        "goerz/jupytext.nvim",
        opts = {
            format = "py:percent", -- または "md" など、好みの形式を指定
            autosync = true,
        },
        ft = { "python", "markdown" },
    },
}

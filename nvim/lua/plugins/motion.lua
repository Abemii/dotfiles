return {
    -- Smooth scrolling
    {
        "yuttie/comfortable-motion.vim",
        init = function()
            vim.g.comfortable_motion_no_default_key_mappings = 1
            vim.g.comfortable_motion_scroll_down_key = "j"
            vim.g.comfortable_motion_scroll_up_key = "k"
            vim.g.comfortable_motion_impulse_multiplier = 1
        end,
        config = function()
            local flick = function(mult)
                return string.format(
                    ":call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * %s)<CR>",
                    mult
                )
            end
            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }
            map("n", "<C-d>", flick(1), opts)
            map("n", "<C-u>", flick(-1), opts)
            map("n", "<C-f>", flick(2), opts)
            map("n", "<C-b>", flick(-2), opts)
        end,
    },

    -- Flash (modern motion plugin, lightspeed replacement)
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash Jump",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
        },
    },
}

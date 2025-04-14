return {
    {
        "heavenshell/vim-pydocstring",
        build = "make install",
        enabled = false,
        ft = { "python" },
        init = function()
            vim.g.pydocstring_formatter = "google"

            -- Ctrl-/ にマッピング（<C-_> == <C-/>）
            vim.keymap.set("n", "<C-_>", "<Plug>(pydocstring)", { silent = true })
        end,
    },

    -- python formatter
    -- {
    --     "smbl64/vim-black-macchiato",
    --     ft = { "python" },
    --     config = function()
    --         local map = vim.keymap.set
    --         local opts = { silent = true, buffer = true }
    --
    --         vim.api.nvim_create_autocmd("FileType", {
    --             pattern = "python",
    --             callback = function()
    --                 map("x", "<Leader>f", "<Plug>(BlackMacchiatoSelection)", opts)
    --                 map("n", "<Leader>f", "<Plug>(BlackMacchiatoCurrentLine)", opts)
    --             end,
    --         })
    --     end,
    -- },
}

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
}

return {
    {
        "kassio/neoterm",
        init = function()
            vim.g.neoterm_default_mod = "belowright"
            vim.g.neoterm_size = 10
            vim.g.neoterm_autoscroll = 1
            vim.g.neoterm_fixedsize = 1
        end,
        config = function()
            local map = vim.keymap.set
            local opts = { noremap = true, silent = true }

            -- Terminal: <C-w> to exit terminal mode
            map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)

            -- Normal mode: send current line to REPL
            map("n", "<C-n>", ":TREPLSendLine<CR>j0", opts)

            -- Visual mode: send selection to REPL
            map("v", "<C-n>", "V:TREPLSendSelection<CR>'>j0", opts)
        end,
    },
}

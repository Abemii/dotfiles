return {
    {
        "lambdalisue/fern.vim",
        dependencies = {
            "lambdalisue/nerdfont.vim",
            "lambdalisue/fern-renderer-nerdfont.vim",
            "lambdalisue/fern-git-status.vim",
            "lambdalisue/glyph-palette.vim",
            "lambdalisue/fern-mapping-git.vim",
            "lambdalisue/fern-hijack.vim",
        },
        config = function()
            -- Fern global settings
            vim.g["fern#renderer"] = "nerdfont"
            -- vim.g["fern#default_hidden"] = 1
            -- Hide the cursor in fern buffer for cleaner UI
            vim.g["fern#hide_cursor"] = 1
            vim.g["fern#default_exclude"] = table.concat({
                "__pycache__",
                "%.pyc",
                "%.o",
                "%.out",
                "build",
                "compile_commands%.json",
                "%.venv",
            }, ",")

            -- Fern launcher mapping (same as: nnoremap <silent> " :Fern ...)
            vim.keymap.set(
                "n",
                [[']],
                [[:Fern . -reveal=% -drawer -toggle -width=35<CR>]],
                { silent = true, noremap = true }
            )

            -- glyph_palette autocmd (for fern, nerdtree, startify)
            vim.api.nvim_create_augroup("my_glyph_palette", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = "my_glyph_palette",
                pattern = { "fern", "nerdtree", "startify" },
                callback = function()
                    vim.cmd("call glyph_palette#apply()")
                end,
            })

            -- fern buffer-local keymaps (mimicking s:init_fern())
            vim.api.nvim_create_augroup("fern_custom", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = "fern_custom",
                pattern = "fern",
                callback = function()
                    local map = function(lhs, rhs)
                        vim.api.nvim_buf_set_keymap(0, "n", lhs, rhs, { noremap = true, silent = true })
                    end

                    map("o", "<Plug>(fern-action-open:edit)")
                    map("go", "<Plug>(fern-action-open:edit)<C-w>p")
                    map("t", "<Plug>(fern-action-open:tabedit)")
                    map("T", "<Plug>(fern-action-open:tabedit)gT")
                    map("i", "<Plug>(fern-action-open:split)")
                    map("gi", "<Plug>(fern-action-open:split)<C-w>p")
                    map("s", "<Plug>(fern-action-open:vsplit)")
                    map("gs", "<Plug>(fern-action-open:vsplit)<C-w>p")
                    map("ma", "<Plug>(fern-action-new-path)")

                    map("C", "<Plug>(fern-action-enter)")
                    map("u", "<Plug>(fern-action-leave)")
                    map("r", "<Plug>(fern-action-reload)")
                    map("R", "gg<Plug>(fern-action-reload)<C-o>")
                    map("cd", "<Plug>(fern-action-cd)")
                    map("CD", "gg<Plug>(fern-action-cd)<C-o>")

                    map("q", ":<C-u>quit<CR>")
                end,
            })
        end,
    },
}

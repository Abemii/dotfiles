return {
    {
        "nvimtools/none-ls.nvim", -- formerly "jose-elias-alvarez/null-ls.nvim"
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- 🔍 Diagnostics
                    null_ls.builtins.diagnostics.flake8.with({
                        extra_args = {
                            "--max-line-length=119",
                            "--extend-ignore=E203",
                        },
                    }),
                    null_ls.builtins.diagnostics.textlint.with({
                        filetypes = { "markdown" },
                    }),

                    -- 🔧 Formatters
                    null_ls.builtins.formatting.black.with({
                        extra_args = { "--line-length", "119", "-q" },
                    }),
                    null_ls.builtins.formatting.isort.with({
                        extra_args = { "--line-length", "119", "--profile", "black" },
                    }),
                    null_ls.builtins.formatting.docformatter.with({
                        extra_args = {},
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.keymap.set("n", "<leader>f", function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end, { buffer = bufnr, desc = "Format buffer with null-ls" })
                    end
                end,
            })
        end,
    },
}

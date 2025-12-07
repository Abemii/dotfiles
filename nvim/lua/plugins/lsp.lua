return {
    -- LSP config plugin
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim", -- Language server manager
            "williamboman/mason-lspconfig.nvim", -- Mason + lspconfig bridge
        },
        config = function()
            -- Mason setup
            require("mason").setup()

            -- Mason-LSP bridge
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", -- Python (coc-jedi)
                    "clangd", -- C++
                    "lua_ls", -- Lua (coc-lua)
                    "jsonls", -- JSON (coc-json)
                    "bashls", -- shell script (coc-sh)
                },
                automatic_installation = true,
            })

            -- LSP setup using new Nvim 0.11+ approach
            -- Configure lua_ls with custom settings
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            -- Enable language servers
            vim.lsp.enable("pyright") -- Python
            vim.lsp.enable("clangd") -- C++
            vim.lsp.enable("jsonls") -- JSON
            vim.lsp.enable("bashls") -- shell script
            vim.lsp.enable("lua_ls") -- Lua

            -- Always show signcolumn
            vim.opt.signcolumn = "yes"
        end,
    },

    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lspsaga").setup({
                ui = {
                    border = "rounded",
                    title = true,
                    code_action = "💡",
                },
                lightbulb = {
                    enable = true,
                    sign = false,
                },
                symbol_in_winbar = {
                    enable = false,
                },
            })

            -- キーマップ（置き換え推奨）
            local keymap = vim.keymap.set
            local opts = { noremap = true, silent = true }

            keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
            keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
            keymap("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opts)
            keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
            keymap("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
            keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
            keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
        end,
    },
}

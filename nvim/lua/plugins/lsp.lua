return {
    -- LSP config plugin
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",           -- Language server manager
            "williamboman/mason-lspconfig.nvim", -- Mason + lspconfig bridge
        },
        config = function()
            -- Mason setup
            require("mason").setup()

            -- Mason-LSP bridge
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", -- Python (coc-jedi)
                    "clangd",  -- C++
                    "lua_ls",  -- Lua (coc-lua)
                    "jsonls",  -- JSON (coc-json)
                    "bashls",  -- shell script (coc-sh)
                },
                automatic_installation = true,
            })

            -- LSPconfig setup
            local lspconfig = require("lspconfig")

            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            -- General LSP keymaps
            -- vim.api.nvim_create_autocmd("LspAttach", {
            --     callback = function(args)
            --         local map = function(mode, lhs, rhs, desc)
            --             vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
            --         end
            --
            --         map("n", "gd", vim.lsp.buf.definition, "Go to definition")
            --         map("n", "gr", vim.lsp.buf.references, "Show references")
            --         map("n", "gi", vim.lsp.buf.implementation, "Show implementations")
            --         map("n", "K", vim.lsp.buf.hover, "Show documentation")
            --         map("n", "<leader>r", vim.lsp.buf.rename, "Rename symbol")
            --         -- map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
            --         map("n", "[g", vim.diagnostic.goto_prev, "Previous diagnostic")
            --         map("n", "]g", vim.diagnostic.goto_next, "Next diagnostic")
            --     end,
            -- })
            --
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

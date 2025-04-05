return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vim",
                    "dockerfile",
                    "json",
                    "lua",
                    "gitignore",
                    "bash",
                    "markdown",
                    "css",
                    "yaml",
                    "toml",
                    "html",
                    "cpp",
                    "python",
                    "diff",
                    "java",
                    "jq",
                    "make",
                },
                highlight = {
                    enable = true,
                },
            })
        end,
    },
}

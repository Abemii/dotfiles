-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup({
    spec = {
        { import = "plugins.runtime" },
        { import = "plugins.fern" },
        { import = "plugins.aerial" },
        { import = "plugins.telescope" },
        { import = "plugins.motion" },
        { import = "plugins.git" },
        { import = "plugins.feline" },
        { import = "plugins.treesitter" },
        { import = "plugins.ui" },
        { import = "plugins.markdown" },
        { import = "plugins.neoterm" },
        { import = "plugins.copilot" },
        { import = "plugins.editing" },
        { import = "plugins.spellcheck" },
        { import = "plugins.lang_python" },
        { import = "plugins.lang_ja" },
        { import = "plugins.lsp" },
        { import = "plugins.comp" },
        { import = "plugins.format_lint" },
    },
})

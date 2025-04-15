-- Set leader key
vim.g.mapleader = " "

-- Key mappings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Remap ; and : for easier access
vim.cmd("nnoremap ; :")
vim.cmd("nnoremap : ;")
vim.cmd("vnoremap ; :")
vim.cmd("vnoremap : ;")

-- Move by display lines instead of logical lines
keymap("", "j", "gj", opts)
keymap("", "k", "gk", opts)

-- Window navigation
keymap("n", "<C-J>", "<C-W><C-J>", opts)
keymap("n", "<C-K>", "<C-W><C-K>", opts)
keymap("n", "<C-L>", "<C-W><C-L>", opts)
keymap("n", "<C-H>", "<C-W><C-H>", opts)

-- General UI settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.scrolloff = 20
vim.opt.foldmethod = "indent"
vim.opt.wrap = false

-- Highlight trailing whitespace
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*",
    command = "match Error /\\s\\+$/",
})

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Encoding and UI effects
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.pumblend = 15
vim.opt.winblend = 15

-- Disable mouse
vim.opt.mouse = ""

-- Search settings
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true

-- Python host
vim.g.python3_host_prog = vim.env.PYTHON3_HOST_PROG or vim.fn.exepath("python3")

-- Use zsh as default shell
if vim.fn.executable("zsh") == 1 then
    vim.opt.shell = "zsh"
elseif vim.fn.executable("bash") == 1 then
    vim.opt.shell = "bash"
else
    vim.notify("Neither zsh nor bash was found. Default shell may not work properly.", vim.log.levels.WARN)
end

-- File handling
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.cmdheight = 1
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.ttyfast = true
vim.opt.clipboard = "unnamedplus"

-- tab/indent
vim.opt.expandtab = true -- expand tabs into spaces
vim.opt.tabstop = 4 -- 4 whitespaces for tabs visual presentation
vim.opt.shiftwidth = 4 -- shift lines by 4 spaces
vim.opt.softtabstop = 4
vim.opt.autoindent = true -- indent when moving to the next line
vim.opt.smartindent = true

-- backspace removes all
vim.opt.backspace = { "indent", "eol", "start" }

-- Indent guides settings
vim.opt.listchars = {
    tab = ">\\ ", -- tab character visual
    trail = "•", -- trailing spaces
    extends = "#", -- line overflow
    nbsp = ".", -- non-breaking space
}
vim.opt.list = true

-- auto comment off
vim.api.nvim_create_augroup("auto_comment_off", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    group = "auto_comment_off",
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "o", "r" }) -- disable auto comment continuation
    end,
})

-- Auto update
vim.opt.autoread = true
vim.opt.autowrite = true

-- Automatically check file updates when enter in window.
vim.api.nvim_create_augroup("vimrc_checktime", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
    group = "vimrc_checktime",
    pattern = "*",
    command = "checktime",
})

-- enable syntax highlighting
-- vim.cmd("syntax enable")

-- nvim-cmp で画面が揺れないようにする
vim.opt.signcolumn = "yes"

-- ZoomToggle
vim.api.nvim_create_user_command("ZoomToggle", function()
    local zoomed = vim.t.zoomed
    if zoomed then
        vim.cmd(vim.t.zoom_winrestcmd)
        vim.t.zoomed = false
    else
        vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
        vim.cmd("resize")
        vim.cmd("vertical resize")
        vim.t.zoomed = true
    end
end, {})

vim.keymap.set("n", "<leader><leader>", ":ZoomToggle<CR>", { noremap = true, silent = true })

-- ModWindo
vim.api.nvim_create_user_command("ModWindo", function(opts)
    local cmd = opts.args
    vim.cmd([[
    windo if &modifiable | execute ']] .. cmd .. [[' | endif
  ]])
end, { nargs = 1 })

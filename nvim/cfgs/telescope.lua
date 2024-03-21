-- https://github.com/nvim-telescope/telescope.nvim/issues/1923#issuecomment-1122642431
function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end


local keymap = vim.keymap.set
local tb = require('telescope.builtin')
local opts = { noremap = true, silent = true }

keymap('n', '<leader>,f', ':Telescope find_files<cr>', opts)
keymap('n', '<leader>,g', ':Telescope git_files<cr>', opts)
keymap('n', '<leader>,b', ':Telescope buffers<cr>', opts)
keymap('n', '<leader>,h', ':Telescope oldfiles<cr>', opts)
keymap('n', '<leader>,B', ':Telescope current_buffer_fuzzy_find<cr>', opts)
keymap('v', '<leader>,B', function()
	local text = vim.getVisualSelection()
	tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)
keymap('n', '<leader>,r', ':Telescope live_grep<cr>', opts)
keymap('v', '<leader>,r', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)
keymap('n', '<leader>,m', ':Telescope marks<cr>', opts)
keymap('n', '<leader>,c', ':Telescope colorscheme<cr>', opts)

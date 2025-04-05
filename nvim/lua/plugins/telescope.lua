return {
  -- Telescope core
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- Helper functions
      function vim.getVisualSelection()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg("v")
        vim.fn.setreg("v", {})

        text = string.gsub(text, "\n", "")
        return (#text > 0) and text or ""
      end

      function vim.getCursorText()
        vim.cmd('noau normal! "xyiw"')
        local text = vim.fn.getreg("x")
        vim.fn.setreg("x", {})

        text = string.gsub(text, "\n", "")
        return (#text > 0) and text or ""
      end

      -- Keybindings
      keymap("n", "<leader>,f", builtin.find_files, opts)
      keymap("n", "<leader>,g", builtin.git_files, opts)
      keymap("n", "<leader>,b", builtin.buffers, opts)
      keymap("n", "<leader>,h", builtin.oldfiles, opts)
      keymap("n", "<leader>,B", builtin.current_buffer_fuzzy_find, opts)
      keymap("v", "<leader>,B", function()
        local text = vim.getVisualSelection()
        builtin.current_buffer_fuzzy_find({ default_text = text })
      end, opts)
      keymap("n", "<leader>,r", builtin.live_grep, opts)
      keymap("v", "<leader>,r", function()
        local text = vim.getVisualSelection()
        builtin.live_grep({ default_text = text })
      end, opts)
      keymap("n", "<leader>,R", function()
        local text = vim.getCursorText()
        builtin.live_grep({ default_text = text })
      end, opts)
      keymap("n", "<leader>,m", builtin.marks, opts)
      keymap("n", "<leader>,c", builtin.colorscheme, opts)
    end,
  },
}

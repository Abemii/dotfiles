return {
    {
        "kamykn/spelunker.vim",
        event = "VeryLazy", -- 適宜調整可（必要なら filetype にもできる）
        init = function()
            vim.opt.spell = false -- set nospell

            -- Core options
            vim.g.enable_spelunker_vim = 1
            vim.g.enable_spelunker_vim_on_readonly = 0
            vim.g.spelunker_target_min_char_len = 4
            vim.g.spelunker_max_suggest_words = 15
            vim.g.spelunker_max_hi_words_each_buf = 100
            vim.g.spelunker_check_type = 1
            vim.g.spelunker_highlight_type = 1

            -- Disable checks
            vim.g.spelunker_disable_uri_checking = 1
            vim.g.spelunker_disable_email_checking = 1
            vim.g.spelunker_disable_account_name_checking = 1
            vim.g.spelunker_disable_acronym_checking = 1
            vim.g.spelunker_disable_backquoted_checking = 1

            -- Autogroup override
            vim.g.spelunker_disable_auto_group = 1

            -- Override highlight groups
            vim.g.spelunker_spell_bad_group = "SpelunkerSpellBad"
            vim.g.spelunker_complex_or_compound_word_group = "SpelunkerComplexOrCompoundWord"
        end,
        config = function()
            -- Autocmds for check_type 1 and 2
            vim.api.nvim_create_augroup("spelunker", { clear = true })

            vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
                group = "spelunker",
                pattern = {
                    "*.vim",
                    "*.js",
                    "*.jsx",
                    "*.json",
                    "*.md",
                    "*.py",
                    "*.cpp",
                    "*.hpp",
                    "*.cc",
                    "*.h",
                },
                callback = function()
                    vim.cmd("call spelunker#check()")
                end,
            })

            vim.api.nvim_create_autocmd("CursorHold", {
                group = "spelunker",
                pattern = {
                    "*.vim",
                    "*.js",
                    "*.jsx",
                    "*.json",
                    "*.md",
                    "*.py",
                    "*.cpp",
                    "*.hpp",
                    "*.cc",
                    "*.h",
                },
                callback = function()
                    vim.cmd("call spelunker#check_displayed_words()")
                end,
            })

            -- Highlight customization
            vim.cmd([[
        highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
        highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE
      ]])
        end,
    },
}

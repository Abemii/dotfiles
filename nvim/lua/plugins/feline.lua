return {
    {
        "feline-nvim/feline.nvim",
        dependencies = {
            "kyazdani42/nvim-web-devicons", -- アイコン用
        },
        config = function()
            local feline = require("feline")

            -- ここに元の設定からコピーされた変数・関数・構成を含めます
            local colors = {
                bg = "#282c34",
                fg = "#abb2bf",
                yellow = "#e0af68",
                cyan = "#56b6c2",
                darkblue = "#081633",
                green = "#98c379",
                orange = "#d19a66",
                violet = "#a9a1e1",
                magenta = "#c678dd",
                blue = "#61afef",
                red = "#e86671",
            }

            local vi_mode_colors = {
                NORMAL = colors.green,
                INSERT = colors.red,
                VISUAL = colors.magenta,
                OP = colors.green,
                BLOCK = colors.blue,
                REPLACE = colors.violet,
                ["V-REPLACE"] = colors.violet,
                ENTER = colors.cyan,
                MORE = colors.cyan,
                SELECT = colors.orange,
                COMMAND = colors.green,
                SHELL = colors.green,
                TERM = colors.green,
                NONE = colors.yellow,
            }

            local function file_osinfo()
                local os = vim.bo.fileformat:upper()
                local icon = (os == "UNIX" and " ") or (os == "MAC" and " ") or " "
                return icon .. os
            end

            local vi_mode_utils = require("feline.providers.vi_mode")

            local function diagnostics_exist(severity)
                local info = vim.b.coc_diagnostic_info
                return info and info[severity] and info[severity] > 0
            end

            local function lsp_get_diag(str)
                local info = vim.b.coc_diagnostic_info
                local count = info and info[str] or 0
                return " " .. count .. " "
            end

            -- 以下の `comps` と `components` の構築は元の構成をそのままコピー
            local comps = {
                vi_mode = {
                    left = {
                        provider = function()
                            return vi_mode_utils.get_vim_mode()
                        end,
                        hl = function()
                            local val = {
                                name = vi_mode_utils.get_mode_highlight_name(),
                                fg = vi_mode_utils.get_mode_color(),
                                -- fg = colors.bg
                            }
                            return val
                        end,
                        right_sep = " ",
                    },
                    right = {
                        -- provider = '▊',
                        -- provider = '' ,
                        hl = function()
                            local val = {
                                name = vi_mode_utils.get_mode_highlight_name(),
                                fg = vi_mode_utils.get_mode_color(),
                            }
                            return val
                        end,
                        left_sep = " ",
                        right_sep = " ",
                    },
                },
                file = {
                    info = {
                        provider = {
                            name = "file_info",
                            opts = {
                                type = "unique",
                                file_readonly_icon = "  ",
                                -- file_readonly_icon = '  ',
                                -- file_readonly_icon = '  ',
                                -- file_readonly_icon = '  ',
                                -- file_modified_icon = '',
                                file_modified_icon = "",
                                -- file_modified_icon = 'ﱐ',
                                -- file_modified_icon = '',
                                -- file_modified_icon = '',
                                -- file_modified_icon = '',
                            },
                        },
                        hl = {
                            fg = colors.blue,
                            style = "bold",
                        },
                    },
                    encoding = {
                        provider = "file_encoding",
                        left_sep = " ",
                        hl = {
                            fg = colors.violet,
                            style = "bold",
                        },
                    },
                    type = {
                        provider = "file_type",
                    },
                    os = {
                        provider = file_osinfo,
                        left_sep = " ",
                        hl = {
                            fg = colors.violet,
                            style = "bold",
                        },
                    },
                    position = {
                        provider = "position",
                        left_sep = " ",
                        hl = {
                            fg = colors.cyan,
                            -- style = 'bold'
                        },
                    },
                },
                left_end = {
                    provider = function()
                        return ""
                    end,
                    hl = {
                        fg = colors.bg,
                        bg = colors.blue,
                    },
                },
                line_percentage = {
                    provider = "line_percentage",
                    left_sep = " ",
                    hl = {
                        style = "bold",
                    },
                },
                scroll_bar = {
                    provider = "scroll_bar",
                    left_sep = " ",
                    hl = {
                        fg = colors.blue,
                        style = "bold",
                    },
                },
                diagnos = {
                    err = {
                        -- provider = 'diagnostic_errors',
                        provider = function()
                            return "" .. lsp_get_diag("error")
                        end,
                        -- left_sep = ' ',
                        enabled = function()
                            return diagnostics_exist("error")
                        end,
                        hl = {
                            fg = colors.red,
                        },
                    },
                    warn = {
                        -- provider = 'diagnostic_warnings',
                        provider = function()
                            return "" .. lsp_get_diag("warning")
                        end,
                        -- left_sep = ' ',
                        enabled = function()
                            return diagnostics_exist("warning")
                        end,
                        hl = {
                            fg = colors.yellow,
                        },
                    },
                    info = {
                        -- provider = 'diagnostic_info',
                        provider = function()
                            return "" .. lsp_get_diag("information")
                        end,
                        -- left_sep = ' ',
                        enabled = function()
                            return diagnostics_exist("information")
                        end,
                        hl = {
                            fg = colors.blue,
                        },
                    },
                    hint = {
                        -- provider = 'diagnostic_hints',
                        provider = function()
                            return "" .. lsp_get_diag("hint")
                        end,
                        -- left_sep = ' ',
                        enabled = function()
                            return diagnostics_exist("hint")
                        end,
                        hl = {
                            fg = colors.cyan,
                        },
                    },
                },
                lsp = {
                    name = {
                        provider = "lsp_client_names",
                        -- left_sep = ' ',
                        right_sep = " ",
                        -- icon = '  ',
                        icon = "慎",
                        hl = {
                            fg = colors.yellow,
                        },
                    },
                },
                git = {
                    branch = {
                        provider = "git_branch",
                        icon = " ",
                        -- icon = ' ',
                        left_sep = " ",
                        hl = {
                            fg = colors.violet,
                            style = "bold",
                        },
                    },
                    add = {
                        provider = "git_diff_added",
                        hl = {
                            fg = colors.green,
                        },
                    },
                    change = {
                        provider = "git_diff_changed",
                        hl = {
                            fg = colors.orange,
                        },
                    },
                    remove = {
                        provider = "git_diff_removed",
                        hl = {
                            fg = colors.red,
                        },
                    },
                },
            }

            local components = {
                active = {},
                inactive = {},
            }

            table.insert(components.active, {})
            table.insert(components.active, {})
            table.insert(components.active, {})
            table.insert(components.inactive, {})
            table.insert(components.inactive, {})
            table.insert(components.inactive, {})

            table.insert(components.active[1], comps.vi_mode.left)
            table.insert(components.active[1], comps.file.info)
            table.insert(components.active[1], comps.git.branch)
            table.insert(components.active[1], comps.git.add)
            table.insert(components.active[1], comps.git.change)
            table.insert(components.active[1], comps.git.remove)
            table.insert(components.inactive[1], comps.vi_mode.left)
            table.insert(components.inactive[1], comps.file.info)
            table.insert(components.active[3], comps.diagnos.err)
            table.insert(components.active[3], comps.diagnos.warn)
            table.insert(components.active[3], comps.diagnos.hint)
            table.insert(components.active[3], comps.diagnos.info)
            table.insert(components.active[3], comps.lsp.name)
            table.insert(components.active[3], comps.file.os)
            table.insert(components.active[3], comps.file.position)
            table.insert(components.active[3], comps.line_percentage)
            table.insert(components.active[3], comps.scroll_bar)
            table.insert(components.active[3], comps.vi_mode.right)

            feline.setup({
                colors = { bg = colors.bg, fg = colors.fg },
                components = components,
                vi_mode_colors = vi_mode_colors,
                disable = {
                    buftypes = { "terminal", "nofile" },
                },
            })
        end,
    },
}

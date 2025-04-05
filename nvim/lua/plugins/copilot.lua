return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<C-J>",
                        next = "<M-i>",
                        prev = "<M-o>",
                        dismiss = "<C-]>",
                    },
                },
                panel = {
                    enabled = true,
                    auto_refresh = false,
                },
                copilot_node_command = "node",
                filetypes = {
                    markdown = true,
                    help = false,
                },
            })
        end,
    },
}

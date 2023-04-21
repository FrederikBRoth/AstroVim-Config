return {{
    "neo-tree.nvim",
    config = function()
        require('neo-tree').setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    open_on_setup = true,
                    open_on_setup_file = false
                }
            },
            window = {
                width = 30
            }
        })
    end
}}

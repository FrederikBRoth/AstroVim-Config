return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
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
        -- log_level = "trace",
        -- log_to_file = true,
      })
    end,
  }

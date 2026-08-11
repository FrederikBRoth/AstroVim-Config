-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "                      -%@%:.                    ",
            "                  =@@@@*.                       ",
            "                 .@@@@*                         ",
            "               .+@@+=-                          ",
            "      .=.    .=@@-                              ",
            " :=%@@*.   .=@@=.                               ",
            "=@%%@-   .=%@=.                      ..::-======",
            "@%::.   =%@+.                .:=*%%@@@@@@@@@@@@@",
            "%@=. .-%@*.            .:-*@@@@@@@@@@@@@@@@@@@@@",
            ".*@@@@@*.          .:+%@@@@@@@@@@@@@@@@@@@@@@@@@",
            "  .:*:.          :*%@@@@@@@#+%@@@@@@@@@@@@@@@@@@",
            "    |          -%@@@@@@@@@+   *@@@@@@@@@@@@@@@@@",
            "  .+#.  =.       :*%@@@@@@@+=*@@@@@@@@@@@@@@@@@@",
            "  *%@% =@%          .-+%@@@@@@@@@@@@@@@@@@@@@@@@",
            " .#@.%@#@%              -@@@@@@@@@@@@@@@@@@@@@@@",
            " .*@  +@%*    :*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
            "   :   ::       .=#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
            "\n",
            "                this is bait                    ",
          }, "\n"),
        },
      },
    },
  },
  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "markdown.mdx" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    dependencies = {
      { "AstroNvim/astroui", opts = { icons = { Markdown = "" } } },
      {
        "AstroNvim/astrocore",
        optional = true,
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>M"

          maps.n[prefix] = { desc = require("astroui").get_icon("Markdown", 1, true) .. "Markdown" }
          maps.n[prefix .. "o"] = { "<cmd>MarkdownPreview<cr>", desc = "Preview" }
          maps.n[prefix .. "u"] = { "<cmd>MarkdownPreviewStop<cr>", desc = "Stop preview" }
          maps.n[prefix .. "y"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle preview" }
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"

      dap.configurations.rust = {
        {
          name = "Debug Rust (auto build)",
          type = "codelldb",
          request = "launch",
          program = function()
            vim.fn.system "cargo build"
            return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ".exe"
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },
}

return {
    {
        "simrat39/rust-tools.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        ft = { "rust" },
        opts = function()
            local codelldb_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb"
            local liblldb_path = vim.env.HOME ..
            "/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.so"
            return {
                server = require("astronvim.utils.lsp").config "rust_analyzer",
                dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
                },
            }
        end,
        config = true,
    },
    {
        "folke/tokyonight.nvim",
        as = "tokyonight",
        config = function() require("tokyonight").setup() end,
    },
    {
        "rebelot/kanagawa.nvim",
        as = "kanagawa",
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        lazy = false,
        config = function()
            require("scrollbar").setup {
                show_in_active_only = false,
                max_lines = false,
                handle = {
                    highlight = "CursorColumn",
                },
                handlers = {
                    cursor = true,
                },
            }
        end,
    },
    {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-cmp" },
        opts = {},
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        lazy = false,
        config = function() require("lsp_lines").setup() end,
    }, -- You can also add new plugins here as well:
    -- Add plugins, the lazy syntax
    -- "andweeb/presence.nvim",
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- },
}

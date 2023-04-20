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
                        d,
                    },
                },
            },
            -- overrides = function(colors)
            --     local theme = colors.theme
            --     return {
            --         -- NormalFloat = { bg = "none", blend = 30 },
            --         -- FloatBorder = { bg = "none" },
            --         -- FloatTitle = { bg = "none" },
            --         -- Pmenu = { bg = theme.ui.bg_m3 },
            --         -- Save an hlgroup with dark background and dimmed foreground
            --         -- so that you can use it where your still want darker windows.
            --         -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            --         -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            --         -- -- Popular plugins that open floats will link to NormalFloat by default;
            --         -- -- set their background accordingly if you wish to keep them dark and borderless
            --         -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            --         -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            --     }
            -- end,
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
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = function() vim.fn["mkdp#util#install"]() end,
    },
}

return {{
    "simrat39/rust-tools.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim", "nvim-dap"},
    ft = {"rust"},
    opts = function()
        local extension_path = vim.env.HOME .. "/.vscode-server/extensions/vadimcn.vscode-lldb-1.9.0/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        return {
            server = require("astronvim.utils.lsp").config "rust_analyzer",
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
            }
        }
    end,
    config = true
}, {
    'folke/tokyonight.nvim',
    as = "tokyonight",
    config = function()
        require("tokyonight").setup()
    end
}, {
    'rebelot/kanagawa.nvim',
    as = "kanagawa",
    opts = {
        colors = {
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none"
                    }
                }
            }
        }
    }
}, {
    "petertriho/nvim-scrollbar",
    lazy = false,
    config = function()
        require("scrollbar").setup({
            show_in_active_only = false,
            max_lines = false,
            handle = {
                highlight = "CursorColumn"
            },
            handlers = {
                cursor = true
            }
        })
    end
}, {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    dependencies = {'nvim-lua/plenary.nvim', "nvim-cmp"},
    opts = {}
}, {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
        require("nvim-surround").setup()
    end
}, {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim"},
    lazy = false,
    config = function()
        require("lsp_lines").setup()
        vim.diagnostic.config({
            virtual_text = false
        })
    end
}, {
    lazy = false,
    "ThePrimeagen/vim-be-good"
}, {
    lazy = false,
    'mg979/vim-visual-multi'
} -- You can also add new plugins here as well:
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

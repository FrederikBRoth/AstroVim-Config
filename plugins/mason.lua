-- customize mason plugins
return { -- use mason-lspconfig to configure LSP installations
{
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
        ensure_installed = {"lua_ls", "rust_analyzer", "tsserver"}
    }
}, -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
{
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
        ensure_installed = {"eslint_d", "stylua", "rustfmt"}
    }
}, {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        ensure_installed = {"codelldb", "node2"}
    }
}}

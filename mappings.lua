-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local crates = require('crates')
local opts = {
    silent = true
}
local lsp_text_toggle = true

return {
    -- first key is the mode
    n = {

        -- crates commands
        vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts),
        vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts),
        vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts),

        ["<leader>æ"] = {
            function()
                require("lsp_lines").toggle()
                lsp_text_toggle = not lsp_text_toggle
                vim.diagnostic.config({
                    virtual_text = lsp_text_toggle
                })
            end
        },

        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        ["<leader>bn"] = {
            "<cmd>tabnew<cr>",
            desc = "New tab"
        },
        ["<leader>bD"] = {
            function()
                require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
                    require("astronvim.utils.buffer").close(bufnr)
                end)
            end,
            desc = "Pick to close"
        },
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<leader>b"] = {
            name = "Buffers"
        },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["k"] = {
            "v:count ? 'k' : 'gk'",
            expr = true,
            desc = "Move cursor up"
        },
        ["re"] = {
            "<cmd>RustRunnables<cr>",
            desc = "Open Rust Runnables"
        },
        ["rr"] = {
            "<cmd>RustRun<cr>",
            desc = "Quick run Rust"
        },
        ["rw"] = {
            "<cmd>RustDebuggables<cr>",
            desc = "Open Rust Debuggables"
        },
        ["<A-k>"] = {
            "<cmd>m-2<cr>",
            desc = "Moves line one up"
        },
        ["<A-j>"] = {
            "<cmd>m+<cr>",
            desc = "Moves line one Down"
        },
        -- LSP additional bindings for good shit

        ["øb"] = {
            function()
                require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
            end,
            desc = "Next buffer"
        },
        ["æb"] = {
            function()
                require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
            end,
            desc = "Previous buffer"
        }
    },
    t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
    },
    i = {
        -- viter
        ["<C-s>"] = {
            "<esc>:w<cr>a",
            desc = "Save File"
        },
        ["<C-a>"] = {
            "<esc>:w<cr>",
            desc = "Save File + enter normal mode"
        },
        ["<A-k>"] = {
            "<esc>:m-2<cr>a",
            desc = "Moves line one up"
        },
        ["<A-j>"] = {
            "<esc>:m+<cr>a",
            desc = "Moves line one Down"
        }
    }
}

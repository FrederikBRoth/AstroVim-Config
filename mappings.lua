-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local crates = require('crates')
local opts = {
    silent = true
}

return {
    -- first key is the mode
    n = {

        -- crates commands
        vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts),
        vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts),
        vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts),
        vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>rq', ':RunClose<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false }),
        vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false }),
        -- :call vm#commands#add_curser_up(0, 1)

        ["<A-Down>"] = {
            function()
                require("smart-splits").resize_down()
            end,
            desc = "Resize split down"
        },
        ["<A-Up>"] = {
            function()
                require("smart-splits").resize_up()
            end,
            desc = "Resize split up"
        },

        ["<C-Up>"] = {
            "<cmd>:call vm#commands#add_cursor_up(0, 1)<cr>",
            desc = "Resize split down"
        },
        ["<C-Down>"] = {
            "<cmd>:call vm#commands#add_cursor_down(0, 1)<cr>",
            desc = "Resize split down"
        },

        ["<leader>æ"] = {
            function()
                require("lsp_lines").toggle()
            end,
            desc = "Toggle LSP Lines"
        },
        ["<Space>ø"] = {
            "<cmd>:Navbuddy<cr>",
            desc = "Navbuddy toggle"
        },

        ["<C-space>"] = {
            require("rust-tools").hover_actions.hover_actions,
            desc = "Hover actions"
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
        }
    }
}

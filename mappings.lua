-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {

  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["k"] = { "v:count ? 'k' : 'gk'", expr = true, desc = "Move cursor up" },
    ["re"] = { "<cmd>RustRunnables<cr>", desc = "Open Rust Runnables" },
    ["rr"] = { "<cmd>RustRun<cr>", desc = "Quick run Rust" },
    ["<A-k>"] = {"<cmd>m-2<cr>", desc = "Moves line one up"},
    ["<A-j>"] = {"<cmd>m+<cr>", desc = "Moves line one Down"},
    -- LSP additional bindings for good shit 
    ["<leader>lr"] = {vim.lsp.buf.rename, desc = "Rename"},
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {
      -- viter
      ["<C-s>"] = { "<esc>:w<cr>a", desc = "Save File" },
      ["<C-t>"] = { "<esc>:w<cr>", desc = "Save File + enter normal mode" },
      ["<A-k>"] = {"<esc>:m-2<cr>a", desc = "Moves line one up"},
      ["<A-j>"] = {"<esc>:m+<cr>a", desc = "Moves line one Down"},
  },
}

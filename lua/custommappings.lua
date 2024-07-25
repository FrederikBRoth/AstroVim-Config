---@type AstroCoreMappings
return { -- first key is the mode

  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs
    ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
    ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

    -- mappings seen under group name "Buffer"
    ["<Leader>bd"] = {
      function()
        require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
      end,
      desc = "Close buffer from tabline",
    },

    -- tables with just a `desc` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- ["<Leader>b"] = { desc = "Buffers" },

    -- setting a mapping to false will disable it
    -- ["<C-S>"] = false,
  },
  i = {
    -- viter
    ["<C-s>"] = {
      "<esc>:w<cr>a",
      desc = "Save File",
    },
    ["<C-a>"] = {
      "<esc>:w<cr>",
      desc = "Save File + enter normal mode",
    },
  },
}

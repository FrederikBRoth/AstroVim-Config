return {
  name = "cargo run --release",
  builder = function()
    return {
      cmd = { "cargo" },
      args = { "run", "--release" },
      cwd = vim.fn.getcwd(),
      components = { "default" },
    }
  end,
}

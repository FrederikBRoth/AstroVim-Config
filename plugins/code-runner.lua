return {{
    lazy = false,
    "CRAG666/code_runner.nvim",
    config = function()
        require('code_runner').setup({
            filetype = {
              fsharp = {
                "cd $dir &&",
                "dotnet fsi --use:$fileName"
              },
              rust = {
                "cd $dir &&",
                "cargo run"
              },
            },
          })
        end
}}
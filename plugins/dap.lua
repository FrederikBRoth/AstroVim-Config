-- js-debugger-adapter from Mason package attempt
-- return {{
--     "jay-babu/mason-nvim-dap.nvim",
--     opts = {
--         handlers = {
--             js = function(source_name)
--                 local dap = require "dap"
--                 dap.adapters["pwa-node"] = {
--                     type = "server",
--                     host = "localhost",
--                     port = "${port}",
--                     executable = {
--                         command = "node",
--                         args = {"--inspect",
--                                 vim.env.HOME .. "/.local/bin/vscode-js-debug/js-debug/src/dapDebugServer.js", "${port}"}
--                     }
--                 }
--                 dap.configurations.typescript = {{
--                     type = 'pwa-node',
--                     request = 'launch',
--                     name = "Launch file",
--                     runtimeArgs = {"run", "--inspect-wait", "--allow-all"},
--                     program = "${file}",
--                     cwd = "${workspaceFolder}",
--                     attachSimplePort = 9229
--                 }}
--                 dap.configurations.javascript = {{
--                     type = 'pwa-node',
--                     request = 'launch',
--                     name = "Launch file",
--                     runtimeArgs = {"run", "--inspect-wait", "--allow-all"},
--                     program = "${file}",
--                     cwd = "${workspaceFolder}",
--                     attachSimplePort = 9229
--                 }}
--             end
--         }
--     }
-- }}
-- This is the proper way to set dap adapter and config fils in AstroNvim. 
-- https://astronvim.com/Recipes/dap
return {{
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
        handlers = {
            node2 = function(source_name)
                local dap = require "dap"
                dap.adapters.node2 = {
                    type = "executable",
                    command = "node",
                    args = {"--inspect",
                            vim.env.HOME .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"}
                }

                dap.configurations.typescript = {{
                    name = 'Launch',
                    type = 'node2',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    outFiles = {"${fileDirname}/build/dist/*.js"},
                    preLaunchTask = "npx tsc",
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal'
                } -- Viterkim work launch.json settings made into dap config syntax. Doesn't work 100%. 
                -- Jest doesn't work at all, and setup init gives errors but does actually work despite that.
                --
                -- Its possible to just import a launch.json using the same syntax as VSCode. ':h dap-launch.json' for more details
                -- {
                --     type = "node2",
                --     name = "vscode-jest-tests",
                --     request = "launch",
                --     args = {"--runInBand", "--coverage=false"},
                --     cwd = "${workspaceFolder}",
                --     console = "integratedTerminal",
                --     internalConsoleOptions = "neverOpen",
                --     program = "${workspaceFolder}/node_modules/jest/bin/jest"
                -- }, {
                --     name = "setup init",
                --     type = "node2",
                --     request = "launch",
                --     protocol = "inspector",
                --     cwd = "${workspaceFolder}",
                --     preLaunchTask = "npm: build:js",
                --     outFiles = {"${workspaceFolder}/build/dist/**/**.js"},
                --     program = "${workspaceFolder}/bin/setup.ts",
                --     sourceMaps = true,
                --     args = {"init"},
                --     env = {
                --         TEMPLATES_PATH = "${workspaceFolder}/templates"
                --     },
                --     internalConsoleOptions = "openOnSessionStart"
                -- }
                }

                dap.configurations.javascript = {{
                    name = 'Launch',
                    type = 'node2',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal'
                }}
            end
        }
    }
}}

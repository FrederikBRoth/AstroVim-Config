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
--                         💀 Make sure to update this path to point to your installation
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
return {{
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
        handlers = {
            node2 = function(source_name)
                local dap = require "dap"
                dap.adapters.node2 = {
                    type = "executable",
                    command = "node",
                    -- 💀 Make sure to update this path to point to your installation
                    args = {"--inspect",
                            vim.env.HOME .. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"}
                }

                dap.configurations.typescript = {{
                    name = 'Launch',
                    type = 'node2',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal'
                }, {
                    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
                    name = 'Attach to process',
                    type = 'node2',
                    request = 'attach',
                    processId = require'dap.utils'.pick_process
                }}

                dap.configurations.javascript = {{
                    name = 'Launch',
                    type = 'node2',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal'
                }, {
                    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
                    name = 'Attach to process',
                    type = 'node2',
                    request = 'attach',
                    processId = require'dap.utils'.pick_process
                }}
            end
        }
    }
}}

-- return {
--     "mfussenegger/nvim-dap",
--     dependencies = {{
--         "mxsdev/nvim-dap-vscode-js",
--         opts = {
--             debugger_cmd = {"js-debug-adapter"},
--             adapters = {"pwa-node"}
--         }
--     }, {
--         "theHamsta/nvim-dap-virtual-text",
--         config = true
--     }},
--     config = function()
--         local dap = require "dap"

--         local attach_node = {
--             type = "pwa-node",
--             request = "attach",
--             name = "Attach",
--             processId = require("dap.utils").pick_process,
--             cwd = "${workspaceFolder}"
--         }

--         dap.configurations.javascript = {{
--             type = "pwa-node",
--             request = "launch",
--             name = "Launch file",
--             program = "${file}",
--             cwd = "${workspaceFolder}"
--         }, attach_node}
--         dap.configurations.typescript = {{
--             type = "pwa-node",
--             request = "launch",
--             name = "Launch file",
--             program = "${file}",
--             cwd = "${workspaceFolder}",
--             sourceMaps = true,
--             protocol = "inspector",
--             console = "integratedTerminal",
--             resolveSourceMapLocations = {"${workspaceFolder}/dist/**/*.js", "${workspaceFolder}/**",
--                                          "!**/node_modules/**"}
--         }, attach_node}
--     end
-- }

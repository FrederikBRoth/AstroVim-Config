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

                vim.g.ts_build = function()
                    local cmd = 'npx tsc'
                    local f = os.execute(cmd)
                    if f == 0 then
                        print('\nBuild: ✔️ ')
                    else
                        print('\nBuild: ❌ (code: ' .. f .. ')')
                    end
                end

                local ts_config = {{
                    name = 'Launch',
                    type = 'node2',
                    request = 'launch',
                    cwd = vim.fn.getcwd(),
                    outFiles = {"${fileDirname}/build/dist/*.js"},
                    preLaunchTask = "npx tsc",
                    sourceMaps = true,
                    -- protocol = 'inspector',
                    -- console = 'integratedTerminal',
                    program = function()
                        if vim.fn.confirm('Build project?', '&yes\n&no', 2) == 1 then
                            vim.g.ts_build()
                        end
                        return '${file}'
                    end
                }}

                dap.configurations.typescript = ts_config -- Viterkim work launch.json settings made into dap config syntax. Doesn't work 100%. 
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
                -- }

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
            end,
            -- https://github.com/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
            -- still gives error, might need to silence since it works
            coreclr = function()
                local dap = require "dap"
                dap.adapters.coreclr = {
                    type = 'executable',
                    command = vim.fn.exepath('netcoredbg'),
                    args = {'--interpreter=vscode'}
                }
                vim.g.dotnet_build_project = function()
                    local default_path = vim.fn.getcwd() .. '/'
                    if vim.g['dotnet_last_proj_path'] ~= nil then
                        default_path = vim.g['dotnet_last_proj_path']
                    end
                    local path = vim.fn.input('Path to your *proj file', default_path, 'file')
                    vim.g['dotnet_last_proj_path'] = path
                    local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
                    print('')
                    print('Cmd to execute: ' .. cmd)
                    local f = os.execute(cmd)
                    if f == 0 then
                        print('\nBuild: ✔️ ')
                    else
                        print('\nBuild: ❌ (code: ' .. f .. ')')
                    end
                end

                vim.g.dotnet_get_dll_path = function()
                    local request = function()
                        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end

                    if vim.g['dotnet_last_dll_path'] == nil then
                        vim.g['dotnet_last_dll_path'] = request()
                    else
                        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'],
                            '&yes\n&no', 2) == 1 then
                            vim.g['dotnet_last_dll_path'] = request()
                        end
                    end

                    return vim.g['dotnet_last_dll_path']
                end

                local config = {{
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
                            vim.g.dotnet_build_project()
                        end
                        return vim.g.dotnet_get_dll_path()
                    end
                }}

                dap.configurations.cs = config

            end
        }
    }
}}

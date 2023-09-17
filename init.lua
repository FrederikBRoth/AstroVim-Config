return {
    -- Configure AstroNvim updates
    updater = {
        remote = "origin", -- remote to use
        channel = "stable", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "nightly", -- branch name (NIGHTLY ONLY)
        commit = nil,      -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_quit = false, -- automatically quit the current session after a successful update
        remotes = {        -- easily add new remotes to track
            --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
            --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
            --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        },
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
        virtual_text = true,
        underline = true,
    },
    lsp = {
        -- customize lsp formatting options
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true, -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "go",
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                },
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                -- "sumneko_lua",
            },
            timeout_ms = 1000, -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- enable servers that you already have installed without mason

    },
    -- Configure require("lazy").setup() options
    lazy = {
        defaults = {
            lazy = true,
        },
        performance = {
            rtp = {
                -- customize default disabled vim plugins
                disabled_plugins = { "tohtml", "gzip", "matchit", "netrwPlugin", "tarPlugin" },
            },
        },
    },
    colorscheme = "kanagawa",
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
        local dap = require "dap"

        -- local events = require "neo-tree.events"
        -- events.subscribe {
        --     event = events.NEO_TREE_WINDOW_AFTER_CLOSE,
        --     handler = function()
        --         if require("dap").session() then
        --             require("dapui").open {
        --                 reset = true,
        --             }
        --         end
        --     end,
        -- }

        dap.listeners.before.event_initialized["place-neotree-edge"] = function()
            vim.cmd ":Neotree close"
            vim.cmd ":Neotree reveal"
        end
        dap.listeners.after.event_terminated["reset-neotree"] = function()
            vim.cmd ":Neotree focus"
            vim.cmd "wincmd 30|"
            vim.cmd "wincmd p"
        end
        vim.cmd "Neotree toggle"

        vim.cmd "set pumblend=30"
        vim.cmd "set winblend=30"

        require("lsp_lines").toggle()

        -- This is a terrible way to circumvent the errors, since there is most likely something wrong, but it works.
        local banned_messages = { "The breakpoint is pending and will be resolved when debugging starts." }

        vim.notify = function(msg, ...)
            for _, banned in ipairs(banned_messages) do
                if msg == banned then return end
            end
            require "notify" (msg, ...)
        end

        vim.cmd "set scrolloff=9999"
        vim.lsp.handlers["wgsl-analyzer/requestConfiguration"] = function(err, result, ctx, config)
            return { 
                success = true,
                customImports = { _dummy_ = "dummy"},
                shaderDefs = {},
                trace = {
                    extension = false,
                    server = false,
                },
                inlayHints = {
                    enabled = true,
                    typeHints = true,
                    parameterHints = true,
                    structLayoutHints = true,
                    typeVerbosity = "inner",
                },
                diagnostics = {
                    typeErrors = true,
                    nagaParsingErrors = true,
                    nagaValidationErrors = true,
                    nagaVersion = "main",
                }
            }
        end,
        vim.cmd "autocmd BufNewFile,BufRead *.wgsl set filetype=wgsl"

    end,
}

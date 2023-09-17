return {
    settings = {
        ["lua_ls"] = {
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        }
    }
}

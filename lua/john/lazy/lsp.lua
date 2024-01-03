return {}
--[[
-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.bufnr }

        -- these will be buffer-local keybindings
        -- because they will only work if a language server is active
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "H", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>lr", refs, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local default_setup = function(server)
    require('lspconfig')[server].setup({
        capabilities = lsp_capabilites,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'eslint',
        'clangd',
        'gopls',
    },
    handlers = {
        -- Customize language servers here
        default_setup,
    },
})

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    },
    mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl + space tirggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
]]--

--[[
:h lsp-zero for help
local lsp = require('lsp-zero')

lsp.preset({
    name = 'recommended',
    float_border = 'rounded',
    call_servers = 'local',
    configure_diagnostics = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = {
        preserve_mappings = false,
        omit = {},
    },
    manage_nvim_cmp = {
        set_sources = 'recommended',
        set_basic_mappings = true,
        set_extra_mappings = false,
        use_luasnip = true,
        set_format = true,
        documentation_window = true,
    },
    suggest_lsp_servers = false,
})

lsp.ensure_installed({
})

lsp.nvim_workspace()


require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('luasnip.loaders.from_vscode').lazy_load()


local luasnip = require('luasnip')
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-c>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-f>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        else
            fallback()
        end
    end, { 'i', 's' }),
    ['<C-b>'] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { 'i', 's' }),
})

-- disable completion with tab
-- this helps with copilot
cmp_mappings['<Tab'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'luasnip',  keyword_length = 2 },
        { name = 'buffer',   keyword_length = 3 },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})

lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

local function refs()
    local win = vim.api.nvim_get_current_win()
    local win_lnum = vim.api.nvim_win_get_cursor(win)[1]
    vim.lsp.buf.references(nil, {
        on_list = function(items, title, context)
            local qf_lnum = 0
            for i, value in pairs(items['items']) do
                if win_lnum == value['lnum'] then
                    qf_lnum = i
                    items['idx'] = i
                end
            end
            vim.fn.setqflist({}, " ", items)
            vim.cmd.copen()
            vim.api.nvim_win_set_cursor(0, { qf_lnum, 0 })
            vim.api.nvim_set_current_win(win)
        end,
    })
end

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

   return {
            -- LSP Support
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
}
]]--

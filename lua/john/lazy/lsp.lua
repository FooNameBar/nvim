-- Border for hover and signature help
local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

-- Global border override
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP Support
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Autocompletion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",

            -- Snippets
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",

            -- Notifications
            "j-hui/fidget.nvim",
        },
        event = "VeryLazy",
        config = function()
            vim.diagnostic.config({
                underline = true,
                virtual_text = {
                    source = "if_many",
                    spacing = 8,
                    -- prefix = "●",
                    -- this will set the prefix to a function that retuns the diagnostics icon based on the severity
                    -- this only works on recent 0.10.0 build. Will be set to "●" when not supported
                },
                update_in_insert = false,
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.HINT] = '',
                        [vim.diagnostic.severity.INFO] = '',
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
                        [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
                        [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
                        [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
                    },
                },
            })
            local on_list = function(options)
                vim.fn.setqflist({}, ' ', options)
            end
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = function(desc) return { buffer = event.buf, desc = desc } end

                    -- these will be buffer-local keybindings
                    -- because they will only work if a language server is active
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Lsp go to definition"))
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Lsp go to declaration"))
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts("Lsp go to type definition"))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Lsp symbol hover"))
                    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Lsp signature help"))
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Lsp code action"))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Lsp rename symbol"))
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("Lsp diagnostic floating window"))
                    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts("Telescope lsp_document_symbols"))
                    vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", opts("Telescope lsp_references"))
                    vim.keymap.set("n", "<leader>li", function()
                        vim.lsp.buf.implementation { on_list = on_list }
                        vim.cmd.sleep("10ms") -- wait for the lsp
                        require('trouble').toggle('quickfix')
                    end, opts("Trouble lsp implementations for symbol"))
                end
            })

            -- Default Handler setup for Lsps
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local default_setup = function(server)
                require('lspconfig')[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'clangd',
                    'gopls',
                    'lua_ls',
                },
                handlers = {
                    -- Customize language servers here
                    default_setup,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                },
                            },
                        }
                    end,
                },
            })


            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'buffer',  keyword_length = 2 },
                },
                mapping = cmp.mapping.preset.insert({
                    -- disable completion with tab
                    -- this helps with copilot
                    ['<Tab'] = nil,
                    ['<S-Tab>'] = nil,

                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
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
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                        scrollable = true, -- Enable scrolling for documentation window
                    }),
                }
            })

            -- display LSP server progress
            require("fidget").setup({})
        end,
    },
}

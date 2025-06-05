-- LSP configuration with dependencies loaded first

return {
  -- Load dependencies first
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "c", "cpp", "go", "lua", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "c", "cpp", "go", "lua", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "gopls", "lua_ls" },
        automatic_installation = false, -- Prevent auto-starting LSPs
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "BufReadPre", "BufNewFile" },
    ft = { "c", "cpp", "go", "lua", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            dependencies = { "rafamadriz/friendly-snippets" },
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load({
                include = { "c", "cpp", "go", "lua", "javascript", "typescript", "html", "css" },
              })
            end,
          },
        },
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "luasnip", keyword_length = 2 },
          { name = "buffer", keyword_length = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = nil,
          ["<S-Tab>"] = nil,
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-f>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered({
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            scrollable = true,
          }),
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "c", "cpp", "go", "lua", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("fidget").setup()
    end,
  },
  -- Load nvim-lspconfig last
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    ft = { "c", "cpp", "go", "lua", "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "j-hui/fidget.nvim",
    },
    config = function()
      -- Set LSP log level to reduce bloat
    -- TODO: fix the undefined global 'vim'
      vim.lsp.set_log_level("WARN")

      -- Stop any existing lua_ls clients to prevent duplicates
      for _, client in ipairs(vim.lsp.get_active_clients({ name = "lua_ls" })) do
        vim.lsp.stop_client(client.id)
      end

      -- Custom border
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
      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- Diagnostics
      vim.diagnostic.config({
        underline = true,
        virtual_text = {
          source = "if_many",
          spacing = 8,
        },
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
          },
        },
      })

      -- Keymaps
      local on_list = function(options)
        vim.fn.setqflist({}, " ", options)
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = function(desc)
            return { buffer = event.buf, desc = desc }
          end
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Lsp go to definition"))
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Lsp go to declaration"))
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts("Lsp go to type definition"))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Lsp symbol hover"))
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Lsp signature help"))
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Lsp code action"))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Lsp rename symbol"))
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts("Lsp diagnostic floating window"))
          vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts("Telescope lsp_document_symbols"))
          vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>", opts("Telescope lsp_references"))
          vim.keymap.set("n", "<leader>li", function()
            vim.lsp.buf.implementation { on_list = on_list }
            vim.cmd.sleep("10ms")
            require("trouble").toggle("quickfix")
          end, opts("Trouble lsp implementations for symbol"))
        end,
      })

      -- LSP servers
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({ capabilities = lsp_capabilities })
      lspconfig.gopls.setup({ capabilities = lsp_capabilities })
      lspconfig.lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                vim.fn.stdpath("data") .. "/site/pack/packer/start",
                vim.fn.stdpath("config") .. "/lua",
                vim.env.VIMRUNTIME .. "/lua",
              },
              checkThirdParty = false,
              maxPreload = 1000, -- Limit workspace preloading
              preloadFileSize = 500, -- Limit file size for preloading (KB)
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      lspconfig.tailwindcss.setup({
        capabilities = lsp_capabilities,
        filetypes = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      })
    end,
  },
}

return {
  -- mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- lsp config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "tsserver",
            "tailwindcss",
            "html",
            "cssls",
            "angularls",
          },
        },
      },
      { "jay-babu/mason-null-ls.nvim",    opts = { ensure_installed = { "stylua", "prettier" } } },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/nvim-cmp" },
      { "jose-elias-alvarez/null-ls.nvim" },
    },

    key = {
      { "gd",         "<Cmd>lua vim.lsp.buf.definition()<CR>",  mod = "n" },
      { "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", mod = "n, v" },
      { "K",          "<Cmd>lua vim.lsp.buf.hover()<CR>",       mod = "n" },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not status_cmp_nvim_lsp then
        return
      end

      -- local on_attach = function(client, bufnr)
      -- 	-- client.server_capabilities.semanticTokensProvider = nil
      -- 	client.server_capabilities.semanticTokensProvider = vim.NIL
      -- end

      local capabilities = cmp_nvim_lsp.default_capabilities()
      local capabilities_css = vim.lsp.protocol.make_client_capabilities()
      capabilities_css.textDocument.completion.completionItem.snippetSupport = true

      -- tsserver
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      -- angular
      lspconfig.angularls.setup({
        capabilities = capabilities,
      })

      -- cpp
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- css
      lspconfig.cssls.setup({

        capabilities = capabilities_css,
      })

      -- html
      lspconfig.html.setup({

        capabilities = capabilities_css,
      })

      -- angular

      lspconfig.angularls.setup({

        capabilities = capabilities_css,
      })

      -- tailwind
      lspconfig.tailwindcss.setup({
        {

          capabilities = capabilities,
        },
      })

      -- lua
      lspconfig.lua_ls.setup({

        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },

            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            undercurl = true,
            update_in_insert = false,
            signs = true,
            -- virtual_text = { spacing = 4, prefix = "●" },
            severity_sort = true,
          })

      -- Diagnostic symbols in the sign column (gutter)
      local signs = { Error = "⛔", Warn = "⚠️ ", Hint = "💡", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
  },

  -- null_ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.stylua,
          require("null-ls").builtins.formatting.prettier,
        },
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },
}

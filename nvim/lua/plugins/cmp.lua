return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    { "L3MON4D3/LuaSnip", version = "v1.*" },
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("javascript", { "javascriptreact" })
    require("luasnip").filetype_extend("typescript", { "javascriptreact" })
    require("luasnip").filetype_extend("typescriptreact", { "javascriptreact" })

    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}

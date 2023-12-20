return {
  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { disable_filetype = { "TelescopePrompt", "text" } },
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
    end,
  },

  -- lsp saga
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },

  -- lua line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        -- separator_style = "slant",
        themable = true,
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or ""
          return " " .. icon
        end,
        indicator = {
          style = "icon",
        },
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        tab_size = 20,
        diagnostics_update_in_insert = true,
        -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
      },
      highlights = {
        buffer_selected = {
          fg = "#c0e4eb",
          bold = true,
        },
        warning = {
          fg = "#d9ca00",
          sp = "#d9ca00",
          bg = "#27283d",
        },
        warning_visible = {
          fg = "#d9ca00",
          bg = "#27283d",
        },
        warning_selected = {
          fg = "#d9ca00",
          sp = "#d9ca00",
          bold = true,
          italic = true,
        },
        warning_diagnostic = {
          fg = "#d9ca00",
          sp = "#d9ca00",
          bg = "#27283d",
        },
        warning_diagnostic_visible = {
          fg = "#d9ca00",
          bg = "#27283d",
        },
        warning_diagnostic_selected = {
          fg = "#d9ca00",
          bold = true,
          italic = true,
        },
        error = {
          fg = "#cf1114",
          bg = "#27283d",
          sp = "#cf1114",
        },
        error_visible = {
          fg = "#cf1114",
          bg = "#27283d",
        },
        error_selected = {
          fg = "#cf1114",
          sp = "#cf1114",
          bold = true,
          italic = true,
        },
        error_diagnostic = {
          fg = "#cf1114",
          bg = "#27283d",
          sp = "#cf1114",
        },
        error_diagnostic_visible = {
          fg = "#cf1114",
          bg = "#27283d",
        },
        error_diagnostic_selected = {
          fg = "#cf1114",
          sp = "#cf1114",
          bold = true,
          italic = true,
        },
        hint = {
          bg = "#27283d",
        },
        hint_diagnostic = {
          bg = "#27283d",
        },
        info = {
          bg = "#27283d",
        },
        info_visible = {
          bg = "#27283d",
        },
        info_diagnostic = {
          bg = "#27283d",
        },
        info_diagnostic_visible = {
          bg = "#27283d",
        },

        background = {
          bg = "#27283d",
          fg = "#6d6e78",
        },
        fill = {
          bg = "#27283d",
        },
        separator = {
          bg = "#27283d",
        },
        separator_selected = {
          fg = "#3640f5",
          bg = "#3640f5",
        },
        indicator_selected = {
          fg = "#3366d6",
          -- bg = "#3640f5",
        },
      },
    },
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    config = function()
      local telescopeConfig = require("telescope.config")
      local telescope = require("telescope")
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      telescope.setup({
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  -- tmux
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
  },

  -- Auto close tag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Buffer del
  {
    "famiu/bufdelete.nvim",
  },
}

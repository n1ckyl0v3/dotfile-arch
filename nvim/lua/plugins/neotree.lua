vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        git_status = {
          symbols = {
            -- Change type
            added = "",
            modified = "",
            deleted = "✖",
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
        indent = {
          indent_size = 2,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = " ",
          expander_expanded = " ",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "ﰊ",
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        modified = {
          symbol = "[+]",
          highlight = "NeoTreeModified",
        },
      },
      window = {
        width = 30,
      },
      nesting_rules = {},
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
    },
    config = function(_, opts)
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup(opts)
    end,
  },
}

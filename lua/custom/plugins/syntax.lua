return {
  {
    "windwp/nvim-autopairs",
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require("nvim-autopairs").setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  {
    "sainnhe/everforest",
    priority = 900,
    config = function()
      vim.api.nvim_create_user_command('SetColor', function(args)
        vim.opt.termguicolors = true

        --vim.g.everforest_colors_override = { grey1 = { "#000000", 000 } }
        vim.g.everforest_dim_inactive_windows = 1
        vim.g.everforest_enable_italic = 1

        vim.cmd.colorscheme 'everforest'
  --      require 'lualine'.setup {
  --        options = {
  --          theme = 'everforest'
  --        }
  --      }

        if string.lower(args.fargs[1]) == "dark" then
          vim.g.everforest_background = 'medium'
          vim.opt.background = 'dark'

          vim.api.nvim_set_hl(0, "Comment", { fg = '#555555' })
          vim.api.nvim_set_hl(0, "SpecialComment", { fg = '#555555' })
        end
        if string.lower(args.fargs[1]) == "light" then
          vim.g.everforest_background = 'medium'
          vim.opt.background = 'light'

          vim.api.nvim_set_hl(0, "Comment", { fg = '#cccccc' })
          vim.api.nvim_set_hl(0, "SpecialComment", { fg = '#cccccc' })
        end
      end, { desc = "Something", nargs = '*' })

      vim.cmd("SetColor dark")
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.elm_format,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.golines.with({
            extra_args = {
              "--max-len=180",
              "--base-formatter=gofumpt",
            },
          }),
          null_ls.builtins.diagnostics.shellcheck,
          --null_ls.builtins.diagnostics.revive,
          null_ls.builtins.diagnostics.golangci_lint.with({
            extra_args = { "--config", "/home/daved/code/src/github.com/ActiveState/cli/.golangci.yaml" },
          }),
          --null_ls.builtins.diagnostics.golangci_lint,
        },
        debounce = 1000,
        default_timeout = 5000,
        -- you can reuse a shared lspconfig on_attach callback here
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,

        -- for go.nvim
        --local gotest = require("go.null_ls").gotest()
        --local gotest_codeaction = require("go.null_ls").gotest_action()
        --table.insert(sources, gotest)
        --table.insert(sources, gotest_codeaction)
      })
    end,
  },
}

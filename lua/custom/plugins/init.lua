-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local function init_options()
  vim.opt.guicursor = ''
  vim.opt.whichwrap:append("h,l,<,>,[,]")
  vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
      handle = io.popen("($(shound identify --playcmd _vim-insert-enter) &)"):close()
    end,
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      handle = io.popen("($(shound identify --playcmd _vim-insert-leave) &)"):close()
    end,
  })
end

init_options()

return {
  {
    "ethanholz/nvim-lastplace",
    config = function()
      --lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
      --lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
      --lastplace_open_folds = true
      require 'nvim-lastplace'.setup {}
    end,
  },
  {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    --build = "nvim -l build/init.lua",

    config = function()
      require 'sg'.setup {
      -- Pass your own custom attach function
      --    If you do not pass your own attach function, then the following maps are provide:
      --        - gd -> goto definition
      --        - gr -> goto references
      on_attach = LspAttach
      }
    end
  },
}

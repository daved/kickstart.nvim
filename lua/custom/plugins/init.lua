-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local function init_options()
  vim.opt.guicursor = ''
  vim.opt.whichwrap:append("h,l,<,>,[,]")
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
}

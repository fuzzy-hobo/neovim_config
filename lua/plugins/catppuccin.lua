-- ~/.config/nvim/lua/plugins/catppuccin.lua
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  transparent_background = false,
})
vim.cmd.colorscheme("catppuccin")

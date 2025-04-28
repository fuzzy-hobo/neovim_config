-- ~/.config/nvim/lua/plugins/treesitter.lua
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "vim", "python", "javascript", "html", "sql", "php" }, -- Sprachen installieren
  highlight = { enable = true },
  indent = { enable = true },
})

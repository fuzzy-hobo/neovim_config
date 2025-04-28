-- ~/.config/nvim/lua/plugins/mason.lua
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "html" },
  automatic_installation = true,
})
require("mason-tool-installer").setup({
  ensure_installed = {
    "black",
    "pyright",
  },
})

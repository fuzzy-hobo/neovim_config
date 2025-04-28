-- ~/.config/nvim/lua/plugins/neo-tree.lua
require("neo-tree").setup({
  close_if_last_window = true,
  window = {
    width = 30, -- Breite des Neo-tree-Fensters
  },
  filesystem = {
    follow_current_file = { enabled = true },
    filtered_items = {
      visible = true, -- Zeigt versteckte Dateien standardmäßig an
      hide_dotfiles = false, -- Zeigt Dotfiles (z. B. .gitignore)
      hide_gitignored = false, -- Zeigt git-ignorierte Dateien
    },
  },
})
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { silent = true })

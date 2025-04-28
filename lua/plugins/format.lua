-- ~/.config/nvim/lua/plugins/format.lua

require("conform").setup({
    formatters_by_ft = {
      python = { "black" },
      -- du kannst hier beliebige weitere Dateitypen hinzufügen
    },
    format_on_save = {
      lsp_fallback = true,  -- Falls kein LSP-Formatter vorhanden ist
      timeout_ms = 500,
    },
  })

  vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true })
  end, { desc = "Format file" })
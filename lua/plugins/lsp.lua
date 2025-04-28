-- ~/.config/nvim/lua/plugins/lsp.lua


-- Setup für nvim-cmp (Autovervollständigung)
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- Für vim-vsnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- Öffne Autovervollständigung manuell
    ["<C-e>"] = cmp.mapping.abort(), -- Schließe Autovervollständigung
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Bestätige Auswahl mit Enter
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP als Quelle
    { name = "vsnip" }, -- Snippets
    { name = "buffer" }, -- Buffer-Wörter
    { name = "path" }, -- Dateipfade
  }),
})

-- Setup für nvim-lspconfig (LSP-Server)
local lspconfig = require("lspconfig")

-- Beispiel: Setup für den Lua Language Server
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- Erkenne 'vim' als globales Objekt
      },
    },
  },
})

-- Beispiel: Setup für den Python Language Server (pyright)
lspconfig.pyright.setup({})

-- Keymaps für LSP-Funktionen
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Gehe zu Definition
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Zeige Hover-Informationen
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Umbenennen
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code Actions
  end,
})

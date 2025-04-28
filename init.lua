-- ~/.config/nvim/init.lua

vim.g.mapleader = " "  -- Setzt den Leader-Key auf die Leertaste
vim.g.maplocalleader = " "  -- Optional: Setzt den lokalen Leader-Key auch auf die Leertaste
vim.env.PATH = vim.env.PATH .. ":/usr/bin"

-- Einrückungseinstellungen
vim.opt.tabstop = 4        -- Anzahl der Leerzeichen, die ein Tab in der Anzeige darstellt
vim.opt.softtabstop = 4    -- Anzahl der Leerzeichen, die ein Tab beim Bearbeiten einfügt
vim.opt.shiftwidth = 4     -- Anzahl der Leerzeichen für automatische Einrückung (z. B. mit >>)
vim.opt.expandtab = true   -- Wandelt Tabs in Leerzeichen um
vim.opt.smartindent = true -- Aktiviert intelligente automatische Einrückung

-- Weitere nützliche Editor-Optionen
vim.opt.number = true      -- Zeigt Zeilennummern an
vim.opt.relativenumber = false -- Zeigt relative Zeilennummern an (hilfreich für Navigation)
vim.opt.wrap = false       -- Deaktiviert Zeilenumbruch
vim.opt.cursorline = true  -- Hebt die aktuelle Zeile hervor
vim.opt.signcolumn = "yes" -- Zeigt immer die Zeichenleiste (für Diagnostik, Git-Zeichen, etc.)
vim.opt.colorcolumn = "88" -- Markiert die 88. Spalte (passend zu black's Standard-Zeilenlänge)

-- Suche und Highlighting
vim.opt.hlsearch = true   -- Hebt Suchtreffer hervor
vim.opt.incsearch = true  -- Zeigt Treffer während des Tippens an
vim.opt.ignorecase = true -- Ignoriert Groß-/Kleinschreibung bei der Suche
vim.opt.smartcase = true  -- Berücksichtigt Groß-/Kleinschreibung, wenn Großbuchstaben in der Suche vorkommen

-- Performance und Verhalten
vim.opt.updatetime = 250  -- Schnellere Aktualisierung (z. B. für Diagnostik und CursorHold-Events)
vim.opt.timeoutlen = 500  -- Wartezeit für Key-Mappings (in Millisekunden)
vim.opt.hidden = true     -- Erlaubt das Wechseln zwischen Buffern, ohne sie zu speichern
vim.opt.swapfile = false  -- Deaktiviert Swap-Dateien
vim.opt.undofile = true   -- Aktiviert persistente Undo-Historie


require("plugins")    -- Lädt die Plugin-Definitionen
require("plugins.catppuccin") -- Lädt die Catppuccin-Konfiguration
require("plugins.neo-tree")   -- Lädt Neo-tree
require("plugins.telescope")  -- Lädt Telescope
require("plugins.treesitter") -- Lädt Treesitter
require("plugins.lualine") -- Lädt Lualine
require("plugins.lsp") -- Füge LSP hinzu
require("plugins.mason") -- initialisiert Mason und Mason-LSP-Config

-- Benutzerdefinierter Befehl für black
vim.api.nvim_create_user_command("Black", function()
  vim.cmd("!~/.local/share/nvim/mason/bin/black %")
  vim.cmd("e") -- Lade die Datei nvim_create_user_command

end, {})
-- Keymapping für black
vim.keymap.set("n", "<leader>bf", ":Black<CR>", { desc = "Format with black" })

-- Benutzerdefinierter Befehl für Python
vim.api.nvim_create_user_command("RunPython", function()
  vim.cmd("!/usr/bin/python3 %")
end, {})

vim.keymap.set("n", "<leader>rp", ":RunPython<CR>", { desc = "Run Python script" })

vim.api.nvim_create_user_command("RunPythonTerm", function()
  vim.cmd("split | terminal python3 %")
  vim.cmd("startinsert") -- wechselt bei Ausführung direkt in Terminaleingabemodus
end, {})

vim.keymap.set("n", "<leader>rt", ":RunPythonTerm<CR>", { desc = "Run Python in terminal" })

-- Dateityp-spezifische Einstellungen
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "json", "html", "css" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})


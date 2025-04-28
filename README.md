README.md: Neovim-Setup auf einem Linux-System installieren

Dieses Dokument beschreibt, wie du mein Neovim-Setup (~/.config/nvim) einrichten kannst. 
Das Setup enthält Plugins wie Lazy.nvim, Catppuccin, 
Neo-tree, Telescope, Treesitter, Lualine, LSP-Unterstützung (lua_ls, pyright, html), 
Mason, black als Formatter und benutzerdefinierte Keymappings.

Der Aufbau ist modular und enthält Automatisierungen zur vereinfachten Inbetriebnahme.

Modulare Struktur von ~/.config/nvim

Hier ist die Struktur meines ~/.config/nvim-Verzeichnisses, damit du weißt, 
was kopiert wird:

~/.config/nvim/
├── init.lua              # Haupt-Konfigurationsdatei
├── lazy-lock.json        # Lockfile für Lazy.nvim
├── lua/
│   ├── plugins.lua       # Plugin-Definitionen mit Lazy.nvim
│   ├── plugins/
│   │   ├── catppuccin.lua  # Konfiguration für das Catppuccin-Theme
│   │   ├── neo-tree.lua    # Konfiguration für Neo-tree
│   │   ├── telescope.lua   # Konfiguration für Telescope
│   │   ├── treesitter.lua  # Konfiguration für Treesitter
│   │   ├── lualine.lua     # Konfiguration für Lualine
│   │   ├── lsp.lua         # Konfiguration für LSP und nvim-cmp
│   │   ├── mason.lua       # Konfiguration für mason.nvim und mason-tool-installer
│   │   ├── format.lua      # Konfiguration für conform.nvim (black)
│   │   └── (weitere Plugin-Konfigurationen, falls hinzugefügt)
└── test.py              # Testdatei (optional, kann gelöscht werden)

Voraussetzungen

Bevor du beginnst, stelle sicher, dass folgende Abhängigkeiten auf dem neuen System 
installiert sind.

Installation via Repository: 
(evtl. ist diese Neovim-Version veraltet - bei mir aktuell: 0.7 - zu alt!)
MERKE: wenn unsicher, ob die Version zu alt, bitte mit bei der Schritt-für-Schrittanleitung beginnen

Neovim (Version 0.11 oder höher empfohlen):

    sudo apt update && sudo apt install neovim

Überprüfe die Version:

    nvim --version

Python 3 (für Python-Skripte und black):

    sudo apt install python3

Überprüfe die Installation (sollte mindestens 0.8 sein):

    python3 --version

Abhängigkeiten für mason.nvim (um Language Server und Tools wie black herunterzuladen):

    sudo apt install curl wget git unzip

Optional: Wenn du flake8 oder andere Linter hinzufügen möchtest, installiere sie 
später über mason.nvim.

Schritt-für-Schritt-Anleitung

1. Kopiere das Neovim-Konfigurationsverzeichnis

Das gesamte Neovim-Setup befindet sich im Verzeichnis ~/.config/nvim.
Kopiere dieses Verzeichnis auf das neue System.
Erstelle ein Archiv auf deinem aktuellen System:

    tar -czf nvim-config.tar.gz -C ~/.config nvim

Das erstellt ein Archiv nvim-config.tar.gz mit dem Inhalt von ~/.config/nvim.

Übertrage das Archiv auf das neue System:

Verwende scp, einen USB-Stick oder eine andere Methode, um das Archiv zu 
übertragen. Beispiel mit scp:

    scp nvim-config.tar.gz user@new-system:/home/user/

Entpacke das Archiv auf dem neuen System:

Navigiere zu dem Verzeichnis, in dem das Archiv liegt (z. B. /home/user/):

    cd /home/user/

Entpacke das Archiv:

        tar -xzf nvim-config.tar.gz -C ~/.config

Das erstellt das Verzeichnis ~/.config/nvim mit allen Konfigurationsdateien.

2. Aktuelle Version von neovim installieren (Stand 2025: nvim v0.11 bzw 0.12 als pre-release)

Download eines AppImage:

        - Website mit Downloads (auch für MacOS, Windows uvm): https://github.com/neovim/neovim/releases/

Downloadbefehl: 

        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage 

AppImage ausführbar machen:

        chmod u+x nvim-linux-x86_64.appimage

Entpacken:

        ./nvim-linux-x86_64.appimage --appimage-extract

Prüfen, ob alles ordentlich entpackt wurde:

        - im Ordner, wo es entpackt wurde, muss nun ein neuer Ordner sein, mit Name: squashfs-root
        - darin sollte nvim liegen: squashfs-root/usr/bin/nvim


Pfade überprüfen mit: echo $PATH

    - prüfen, ob /usr/local/bin vorhanden ist
    - falls nicht vorhanden (Ausgabe zB: /usr/bin:/bin:/usr/local/games:/usr/games), bitte diesen Ordner erstellen: sudo mkdir -p /usr/local/bin

Den neuen Ordner zum Pfad hinzufügen:

        export PATH="$/usr/local/bin:$PATH"

Prüfung, ob Pfad hinzugefügt wurde:

        echo $PATH

        Ausgabe zB so: /usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

Prüfung: Pfad zu einer evtl. bestehenden nvim herausfinden:

        which nvim

falls nvim vorhanden ist -> löschen:

        sudo apt remove neovim (falls neovim aus Repo installiert wurde - Stand 2025: Repo-nvim-Version bei 0.7, also zu alt)
        erneute Prüfung mit: which nvim
        
falls immernoch ein nvim rumliegt (und nicht unter /usr/local/bin liegt), manuell dorthin navigieren und löschen:

        sudo rm /pfad/zum/alten/nvim (siehe Ergebnis von which nvim)

Pfad zu nvim (Ordner von entpacktes AppImage): 

        /home/parrot/Downloads/squashfs-root/usr/bin 

Link anpassen, sodass korrektes nvim (das vom AppImage) verwendet wird:
        
        ln -s /home/parrot/Downloads/squashfs-root/usr/bin/nvim ~/.lo

        Allgemeiner Befehl für Symlink: ln -s /pfad/zum/extrahierten/nvim ~/usr/local/bin/nvim

Neues Terminal öffen:

        source ~/.bashrc


3. Starte Neovim und synchronisiere Plugins

Mein Setup verwendet Lazy.nvim als Plugin-Manager. 
Lazy.nvim lädt die Plugins automatisch herunter, wenn sie noch nicht vorhanden sind.

Öffne Neovim:

    nvim

Synchronisiere die Plugins mit Lazy.nvim:

Lazy.nvim erkennt, dass die Plugins noch nicht installiert sind, und lädt sie automatisch herunter.
Falls das nicht automatisch passiert, führe manuell aus:

    :Lazy sync

Lazy.nvim verwendet die Datei ~/.config/nvim/lazy-lock.json, um sicherzustellen, 
dass dieselben Plugin-Versionen installiert werden wie auf dem ursprünglichen System.

4. Installiere externe Tools mit mason.nvim

Mein Setup verwendet mason.nvim, um Language Server (lua_ls, pyright, html) und 
Formatter (black) zu installieren. Diese Tools werden nicht mit dem 
~/.config/nvim-Verzeichnis kopiert und müssen auf dem neuen System installiert werden.

Öffne die mason.nvim-Oberfläche in nvim:

    :Mason

Überprüfe die Installation:

mason.nvim ist so konfiguriert, dass es lua_ls, pyright, html und black automatisch 
installiert (dank mason-lspconfig und mason-tool-installer).
Du solltest sehen, dass diese Tools in der :Mason-Oberfläche als installiert 
markiert sind. Falls nicht, installiere sie manuell:

Navigiere zu lua_ls, pyright, html und black in der :Mason-Oberfläche und drücke 
die entsprechende Taste (z. B. i), um sie zu installieren.

Alternative: Automatische Installation:

Meine Konfiguration enthält mason-tool-installer, das black automatisch installiert. Du kannst auch manuell überprüfen, ob alles installiert ist:

        :MasonInstall black

5. Teste das Setup

Nachdem du die Konfiguration kopiert und die Abhängigkeiten installiert hast, teste 
die wichtigsten Funktionen, um sicherzustellen, dass alles funktioniert.

    :e test.py

Schreibe etwas unformatierten Code (falsche Einrückungen - unübersichtlich), z. B.:
python

    def my_function(x,y):
            result=x+y;
        if result>10:
                print('Result is greater than 10');return result

Formatiere mit black:

    :Black

Oder drücke <leader>bf (Standard: Space bf).
Der Code sollte formatiert werden:

    def my_function(x, y):
        result = x + y
        if result > 10:
            print("Result is greater than 10")
        return result

Führe das Python-Skript aus:

Führe das Skript aus:

        :RunPython

Oder drücke <leader>rp (Standard: Space rp).
Die Ausgabe sollte in der Konsole erscheinen.

Teste LSP-Funktionen:

    In der Python-Datei:
            Drücke gd (gehe zur Definition).
            Drücke K (zeige Hover-Informationen).
            Drücke <leader>rn (umbenennen).
            Drücke <leader>ca (Code-Aktionen).

    Öffne eine HTML-Datei und überprüfe, ob html-lsp funktioniert (z. B. Autovervollständigung mit Ctrl+Space).

    Teste andere Plugins:
        Öffne Neo-tree: <leader>e (Standard: Space e).
        Suche Dateien mit Telescope: <leader>ff (Standard: Space ff).
        Überprüfe, ob das Catppuccin-Theme korrekt geladen ist.

6. Fehlerbehebung

Falls etwas nicht funktioniert, überprüfe die folgenden Punkte:

    Lazy.nvim lädt Plugins nicht:
        Lösche das Lazy.nvim-Datenverzeichnis und starte neu:

    rm -rf ~/.local/share/nvim/lazy
    Führe :Lazy sync aus.

mason.nvim kann Tools nicht installieren:

    Stelle sicher, dass curl, wget, git und unzip installiert sind:

    sudo apt install curl wget git unzip

    Führe :Mason aus und installiere die Tools manuell.

python3 ist nicht verfügbar:

    Installiere Python 3:

        sudo apt install python3

Überprüfe den Pfad zu python3:

    which python3

Falls der Pfad anders ist (z. B. /usr/local/bin/python3), 
passe den Befehl in ~/.config/nvim/init.lua an:

    vim.api.nvim_create_user_command("RunPython", function()
      vim.cmd("!/usr/local/bin/python3 %")
    end, {})

Unterschiedliche Neovim-Versionen:

    Wenn die Neovim-Version zu alt ist, aktualisiere sie:

        sudo apt update && sudo apt install neovim

Zusätzliche Hinweise

Automatisierung für black: Derzeit ist die automatische Formatierung mit black 
deaktiviert, um die Änderungen manuell zu kontrollieren. Um sie zu aktivieren, 
bearbeite ~/.config/nvim/lua/plugins/format.lua und füge format_on_save hinzu:

require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

Hinzufügen von flake8: Wenn du flake8 als Linter hinzufügen möchtest, installiere 
nvim-lint und füge flake8 zu mason-tool-installer in mason.lua hinzu. Eine 
detaillierte Anleitung findest du in der Dokumentation oder bei Bedarf in einem 
separaten Schritt.

Keymappings:

    <leader>bf (Space bf): Formatiert die aktuelle Datei mit black.
    <leader>rp (Space rp): Führt das aktuelle Python-Skript aus.

Weitere Keymappings findest du in den jeweiligen Plugin-Konfigurationen 
(z. B. Telescope: <leader>ff).


#!/bin/bash
echo "=== Inizio rimozione completa di OpenCode ==="

# 1. Rimuove l'eseguibile globale (npm e Homebrew)
if command -v npm &> /dev/null; then
    echo "[1/4] Rimozione pacchetto npm..."
    npm uninstall -g opencode-ai 2>/dev/null
fi

if command -v brew &> /dev/null; then
    echo "[1/4] Rimozione pacchetto Homebrew..."
    brew uninstall opencode 2>/dev/null
fi

# 2. Cancella le cartelle dei dati e della configurazione
echo "[2/4] Eliminazione cartelle locali e configurazioni..."
rm -rf ~/.local/opencode
rm -rf ~/.local/share/opencode
rm -rf ~/.config/opencode

# 3. Cancella i file di cache
echo "[3/4] Eliminazione file di cache..."
rm -rf ~/.cache/opencode

# 4. Verifica finale
echo "[4/4] Verifica dello stato..."
if ! command -v opencode &> /dev/null; then
    echo "=== Pulizia completata con successo! OpenCode è stato rimosso. ==="
else
    echo "⚠ Attenzione: Il comando 'opencode' risponde ancora. Potrebbe essere necessario riavviare il terminale."
fi

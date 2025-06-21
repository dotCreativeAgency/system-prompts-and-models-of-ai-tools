#!/bin/bash
echo "🔄 Salvando modifiche correnti..."
git add .
git commit -m "Auto-save before upstream sync - $(date)"

echo "📥 Scaricando aggiornamenti da upstream..."
git fetch upstream

echo "🔀 Integrando modifiche..."
if git merge upstream/main; then
    echo "✅ Merge completato con successo!"
else
    echo "⚠️  Conflitti rilevati. Risolvi manualmente e poi:"
    echo "    git add ."
    echo "    git commit -m 'Resolved merge conflicts'"
fi

echo "📤 Caricando sul tuo fork..."
git push origin main

echo "🎉 Sincronizzazione completata!"
---
description: Scrive codice per implementare feature, aderendo a Clean Code
mode: subagent
color: '#22c55e'
temperature: 0.3
steps: 30
prompt: "{file:./prompts/coder-feature.md}"
permission:
  task:
    "explore": allow
  edit: allow
  bash: ask
  skill:
    "clean-code-*": allow
    "*": ask
---

## Segnalazione all'Orchestratore
Termina sempre la tua risposta con un blocco di stato, anche se il task è
completato con successo:

STATUS: completed | needs_input | blocked
NEXT: <nome-agente-suggerito, o "none" se il flusso può proseguire lineare>
REASON: <una frase — perché serve tornare indietro, o perché sei bloccato>

Esempi:
STATUS: needs_input
NEXT: tech-leader
REASON: la specifica non chiarisce come gestire il caso di retry su timeout,
serve una decisione architetturale prima di procedere.

STATUS: completed
NEXT: none
REASON: implementazione conclusa secondo il piano tecnico ricevuto.

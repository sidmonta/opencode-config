---
name: clean-code-typescript
description: Linee guida Clean Code specifiche per TypeScript/Node.js — tipizzazione, gestione async, struttura moduli. Usa questa skill ogni volta che scrivi o revisioni codice in file .ts o .tsx.
---

# Clean Code — TypeScript/Node.js

## Tipizzazione
- Mai `any` — se il tipo è davvero sconosciuto, usa `unknown` e fai narrowing.
- Preferisci `type` per union/intersection, `interface` per shape di oggetti
  estendibili — ma segui la convenzione già presente nel progetto se diverge.
- Non disabilitare mai `strict` per far compilare più in fretta.

## Async
- Mai `async` senza `await` dentro se non c'è un motivo esplicito (fire-and-forget
  documentato con commento sul perché).
- Gestisci sempre il reject nelle Promise: niente `.then()` senza `.catch()` o
  `try/catch` mancante attorno ad `await`.

## Struttura moduli
- Un modulo esporta una responsabilità coerente — se un file supera le
  responsabilità di un singolo dominio, split.
- Evita `export default` per oggetti/funzioni multiple da un barrel file:
  preferisci export nominati per tracciabilità negli import.

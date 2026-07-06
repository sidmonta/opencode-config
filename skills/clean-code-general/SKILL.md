---
name: clean-code-general
description: Principi Clean Code trasversali a ogni linguaggio — naming, dimensione delle funzioni, DRY, error handling, SOLID. Usa questa skill ogni volta che scrivi o revisioni codice, indipendentemente dal linguaggio, insieme alla skill specifica del linguaggio (clean-code-elixir, clean-code-typescript, clean-code-sql).
---

# Clean Code — Principi Generali

## Naming
- Nomi che rivelano l'intenzione: niente `data`, `temp`, `x`, `flag`,
  `handleStuff`. Se un nome richiede un commento per essere capito, il nome
  è sbagliato.
- Funzioni: verbo o verbo+sostantivo (`calculateTotal`, non `total`).
- Booleani: prefisso `is/has/can/should` (`isValid`, non `valid`).
- Un solo termine per concetto in tutto il progetto: non alternare
  `fetch/get/retrieve` per la stessa operazione in file diversi.
- Evita abbreviazioni non ovvie e Hungarian notation (niente `strName`).

## Funzioni
- Una funzione fa UNA cosa. Se la descriveresti con una congiunzione ("e",
  "poi"), va spezzata.
- ~20 righe come obiettivo, non regola assoluta — oltre le 30, chiediti se
  stai violando Single Responsibility.
- Max 3 argomenti posizionali. Oltre, usa un oggetto/struct nominato.
- Zero side-effect nascosti: il nome deve dichiarare TUTTO ciò che la
  funzione fa.
- Livello di astrazione unico per funzione: non mischiare dettagli a basso
  livello (parsing stringhe) con logica di alto livello (orchestrazione)
  nella stessa funzione.
- Preferisci early return / guard clause a nidificazioni profonde. Oltre 2
  livelli di indentazione, rifattorizza.

## Commenti
- Il codice si spiega da sé tramite naming e struttura. Commenta SOLO il
  "perché" (decisione controintuitiva, workaround, vincolo esterno), mai
  il "cosa" fa il codice.
- Zero commenti che ripetono ciò che il codice già dice.
- Zero codice commentato lasciato nel diff.

## Duplicazione (DRY)
- Se la stessa logica appare 2+ volte, estraila — non aspettare la terza
  occorrenza se la logica è già non banale.
- Ma non astrarre prematuramente due cose solo simili nella forma se
  rappresentano concetti di dominio diversi (falsa DRY-violation). In caso
  di dubbio, motiva la scelta nel commento del PR/commit.

## Error handling
- Mai catch/rescue silenzioso.
- Errori gestiti al livello giusto: non propagare eccezioni generiche fino
  alla UI se possono essere gestite semanticamente più vicino alla fonte.
- Preferisci valori di ritorno espliciti a eccezioni per flussi di controllo
  prevedibili; eccezioni solo per stati davvero eccezionali.

## Struttura e SOLID (dove applicabile)
- Single Responsibility per modulo/classe/context, non solo per funzione.
- Dependency Inversion: dipendi da interfacce/behaviour, non da
  implementazioni concrete, dove il progetto lo prevede già come pattern.
- Legge di Demetra: niente `a.b.c.d.metodo()` — un modulo non deve conoscere
  dettagli implementativi di un livello che non gli compete.

## Formattazione
- Segui SEMPRE il formatter/linter già configurato nel progetto — non
  introdurre uno stile personale anche se "più pulito" a tuo giudizio.
- Consistenza con le convenzioni già presenti nel file/modulo che stai
  modificando, anche quando divergono leggermente da queste linee guida.

## Nota per chi applica questa skill
Questi principi vanno bilanciati col buonsenso: seguirli in modo
meccanico può produrre over-engineering (interfacce inutili, funzioni
spezzate solo per rientrare in un conteggio di righe). L'obiettivo è
leggibilità e manutenibilità reali, non il rispetto della metrica.

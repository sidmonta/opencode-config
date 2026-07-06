---
name: clean-code-sql
description: Linee guida Clean Code specifiche per SQL e PostgreSQL — query leggibili, CTE, indicizzazione, migrazioni. Usa questa skill ogni volta che scrivi o revisioni query SQL, migrazioni Liquibase, o codice che costruisce query (TypeORM, Ecto query).
---

# Clean Code — SQL/PostgreSQL

## Leggibilità della query
- Una CTE per concetto logico, con nome che ne dichiara l'intento
  (`active_users_last_30_days`, non `cte1` o `tmp`).
- Preferisci CTE nominate a subquery annidate quando la query supera 2
  livelli di nesting — la leggibilità lineare vince sulla "furbizia" di una
  query compatta.
- Allinea `SELECT`/`FROM`/`WHERE`/`JOIN` su righe separate; una colonna per
  riga se la lista supera 4-5 campi.
- Alias brevi ma non criptici: `u` per `users` va bene se c'è un solo join,
  diventa ambiguo con query complesse — in quel caso usa alias descrittivi
  (`ord` per `orders`, non `o` se c'è anche `organizations`).
- Evita `SELECT *` in query di produzione: elenca le colonne esplicitamente,
  sia per leggibilità sia per non rompere silenziosamente il codice a valle
  quando lo schema cambia.

## CTE e query composte
- Le CTE devono seguire un ordine logico di lettura dall'alto in basso:
  prima i dati grezzi filtrati, poi le aggregazioni, infine la selezione
  finale — non forzare chi legge a saltare avanti e indietro.
- Se una CTE `UPDATE`/`DELETE` con `RETURNING` modifica dati, isola sempre
  quella logica in una CTE dedicata e commentala esplicitamente (è un punto
  ad alto rischio, l'unico caso dove un commento sul "cosa" è giustificato
  data la pericolosità dell'operazione).
- `FOR UPDATE SKIP LOCKED` va sempre accompagnato da un commento sul perché
  (pattern di coda/outbox, concorrenza) — non è immediatamente ovvio a chi
  legge senza contesto.

## Sargability e performance
- Query su range temporali: mai wrappare la colonna indicizzata in una
  funzione nel `WHERE` (es. `DATE(created_at) = ...` rompe l'indice).
  Usa range espliciti (`created_at >= X AND created_at < Y`).
- Verifica che ogni `JOIN` e ogni condizione `WHERE` su tabelle grandi sia
  supportata da un indice esistente — se non lo è, segnalalo esplicitamente
  invece di scrivere la query e sperare che l'ottimizzatore compensi.
- Evita `OR` su colonne diverse quando è possibile riscrivere come `UNION`
  di due query sargable: spesso più leggibile e più performante.
- Occhio a `NOT IN` con subquery che può restituire `NULL`: preferisci
  `NOT EXISTS`, semanticamente più sicuro e spesso più performante.

## Null e default
- Esplicita sempre l'intento su `NULL`: `IS NULL`/`IS NOT NULL`, mai `= NULL`.
- In confronti e concatenazioni di stringhe, gestisci `NULL` esplicitamente
  (`COALESCE`) invece di lasciare che si propaghi silenziosamente in un
  risultato inatteso.
- Le migrazioni che aggiungono colonne `NOT NULL` su tabelle popolate devono
  specificare un `DEFAULT` esplicito o un passaggio di backfill — mai
  lasciare che sia il DB a decidere implicitamente.

## Migrazioni (Liquibase)
- Ogni changeset fa UNA modifica logica (una tabella, un indice, un
  vincolo) — non accorpare più modifiche indipendenti nello stesso
  changeset, per poter fare rollback granulare.
- Changeset sempre corredati di `rollback` esplicito quando Liquibase non
  può inferirlo automaticamente.
- Nomina i changeset con id descrittivi, non progressivi anonimi
  (`add-index-orders-created-at`, non `changeset-47`).
- Su tabelle grandi in produzione (Aurora), valuta sempre se un indice va
  creato `CONCURRENTLY` per evitare lock prolungati — e documenta nel
  changeset perché è stata scelta (o esclusa) questa strategia.

## Query costruite da codice (TypeORM, Ecto)
- Evita di costruire SQL per concatenazione di stringhe anche per query
  dinamiche: usa query builder parametrizzati per prevenire injection,
  anche quando l'input sembra "sicuro" (es. valori interni, non da utente).
- Se una query builder produce SQL illeggibile o inefficiente rispetto a
  scriverla a mano, preferisci una raw query ben commentata invece di
  forzare l'astrazione dell'ORM oltre il suo limite naturale.
- Mantieni la logica di query complessa in un unico punto (repository/query
  object), non sparsa e duplicata tra più moduli che ne hanno bisogno.

## Nota per chi applica questa skill
Come per le altre skill Clean Code: bilancia con buonsenso. Una query
leggibile con CTE nominate può essere leggermente più lenta di una query
compatta iper-ottimizzata — in assenza di un problema di performance
misurato, la leggibilità vince. Ottimizza solo dove i dati (EXPLAIN
ANALYZE, metriche reali) mostrano che serve.

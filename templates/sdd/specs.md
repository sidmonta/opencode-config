# Specifica: [Titolo Feature]

## Riferimenti
- **Proposal**: `specs/<feature>/proposal.md`
- **Architettura**: `specs/<feature>/architecture.md`
- **Decisioni**: `decisions/<adr-file>.md`

## User Stories / Casi d'uso

### UC-01: [Titolo caso d'uso]
- **Attori**: [chi interagisce]
- **Precondizioni**: [cosa deve essere vero prima]
- **Flusso principale**:
  1. [passo]
  2. [passo]
  3. ...
- **Postcondizioni**: [cosa è vero dopo]
- **Flussi alternativi**:
  - FA-01: [descrizione deviazione]

### UC-02: [Titolo caso d'uso]
...

## Criteri di accettazione (formato EARS)

### Assunzione (stato iniziale)
```
Il sistema presuppone [contesto] prima di [funzione].
```

### Esistenziale
```
Il sistema deve permettere [azione] quando [condizione].
```

### Universale
```
Il sistema deve sempre [comportamento] per ogni [input].
```

### Reazione
```
Quando [evento], il sistema deve [risposta] entro [tempo/soglia].
```

## Dettaglio requisiti non funzionali
- **Performance**: [latenza, throughput]
- **Sicurezza**: [auth, ruoli, dati sensibili]
- **Disponibilità**: [SLA, downtime permesso]
- **Manutenibilità**: [logging, metriche, osservabilità]

## Vincoli tecnici
- [Librerie/versioni obbligatorie]
- [Piattaforme target]
- [Dipendenze esterne]

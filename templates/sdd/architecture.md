# Architettura: [Titolo Feature]

## Riferimenti
- **Proposal**: `specs/<feature>/proposal.md`
- **Specs**: `specs/<feature>/specs.md`
- **Decisioni**: `decisions/<adr-file>.md`

## Approccio scelto
Descrivere la soluzione architetturale: pattern, componenti, flussi dati.
*Perché questo approccio e non altri.*

## Alternative scartate
| Alternativa | Motivo scarto |
|---|---|
| [nome] | [motivazione] |

## Diagramma flusso (testuale)
```
[Request] → [Componente A] → [Componente B] → [Storage]
                ↓
          [Cache]
```

## Componenti
### [Componente A]
- **Responsabilità**: [cosa fa]
- **Dipende da**: [quali altri componenti]
- **Espone**: [API/eventi]

### [Componente B]
- **Responsabilità**: [cosa fa]
- **Dipende da**: [quali altri componenti]
- **Espone**: [API/eventi]

## Flusso dati
1. [passaggio]
2. [passaggio]
3. ...

## Punti di attenzione per Coder
- [Connessioni sorprendenti tra moduli]
- [Casi limite da gestire]
- [Configurazioni necessarie]

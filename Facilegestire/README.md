# FacileGestire 2.0 - VSCode Copilot Configuration

Questa configurazione ottimizza GitHub Copilot per lo sviluppo di FacileGestire 2.0, fornendo contesto specifico del progetto e pattern di codice.

## Struttura della Configurazione

```
Facilegestire/
├── .github/
│   └── copilot-instructions.md    # Istruzioni generali per Copilot
├── .vscode/
│   ├── settings.json              # Configurazioni VSCode specifiche
│   └── extensions.json            # Estensioni raccomandate
├── copilot/
│   ├── system-prompt.md           # Prompt principale per Copilot
│   ├── project-context.md         # Contesto dettagliato del progetto
│   └── code-patterns.md           # Pattern e esempi di codice
└── README.md                      # Questa guida
```

## Come Utilizzare

1. **Copia la cartella** nella root del tuo progetto FacileGestire
2. **Riavvia VSCode** per applicare le configurazioni
3. **Copilot utilizzerà automaticamente** il contesto fornito

## Benefici

- **Suggerimenti contestuali**: Copilot comprende l'architettura multi-tenant
- **Pattern consistenti**: Genera codice seguendo gli standard del progetto
- **Brand compliance**: Utilizza i colori e stili corretti
- **Security-aware**: Considera sempre l'isolamento tra tenant

## Personalizzazione

Puoi modificare i file per adattarli alle tue esigenze:
- Aggiungi nuovi pattern in `code-patterns.md`
- Aggiorna il contesto in `project-context.md`
- Modifica le istruzioni in `copilot-instructions.md`

## Comandi Rapidi

I comandi più comuni sono documentati nei file di configurazione. Copilot li suggerirà automaticamente quando appropriato.

## Supporto

Per problemi o suggerimenti sulla configurazione, consulta la documentazione del progetto o contatta il team di sviluppo.
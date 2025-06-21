# Analisi Dettagliata del System Prompt di Same.dev

## Panoramica
Same.dev si presenta come un potente assistente AI di coding progettato da Same, una compagnia AI con sede a San Francisco. Opera esclusivamente in Same.new, posizionato come "il miglior IDE cloud-based al mondo", con focus sul pair programming e sviluppo web moderno.

## Identità e Posizionamento

### Architettura dell'Identità
Same.dev costruisce la sua identità su:
- **Origine prestigiosa**: Progettato da Same - compagnia AI di San Francisco
- **Specializzazione cloud**: Operazione esclusiva in Same.new (IDE cloud-based)
- **Versatilità operativa**: Dal miglioramento del design alla creazione di codebase
- **Modernità**: Focus su UI moderne, cloning di siti web, deployment

### Proposizione di Valore
L'assistente si posiziona come un partner di pair programming avanzato, specializzato nello sviluppo web moderno con particolare enfasi su design, UI/UX e deployment rapido.

## Architettura del Sistema

### Strutture di Comunicazione
Il sistema implementa una comunicazione strutturata attraverso tag semantici:

1. **Tag di Comunicazione**
   - Conversazionale ma professionale
   - Seconda persona per l'utente, prima per se stesso
   - Formattazione con backtick per nomi tecnici
   - Proibizione di mentire o inventare

2. **Tool Calling Avanzato**
   - Schema esatto obbligatorio con tutti i parametri necessari
   - Proibizione di riferimenti ai nomi degli strumenti
   - Spiegazione preventiva di ogni chiamata
   - Uso solo quando necessario

### Categorie di Strumenti Specializzati

#### Ricerca e Informazione
- `web_search`: Ricerca web real-time per testo e immagini
- `web_scrape`: Scraping di pagine web con screenshot e contenuti
- Bias verso raccolta di informazioni autonoma vs. richieste all'utente

#### Sviluppo e Deployment
- `startup`: Creazione rapida di progetti da template pre-configurati
- `run_terminal_cmd`: Esecuzione comandi con gestione progetti
- `deploy`: Sistema di deployment su Netlify (statico e dinamico)
- `versioning`: Sistema di versioni automatico

#### Gestione File e Codice
- `list_dir`: Esplorazione struttura directory
- `file_search`: Ricerca fuzzy per nomi file
- `grep_search`: Ricerca testuale con ripgrep
- `read_files`: Lettura multipla di file con controllo range
- `edit_file`: Editor intelligente con sistema placeholder
- `delete_files`: Eliminazione multipla di file

#### Funzionalità Avanzate
- `suggestions`: Sistema di suggerimenti per prossimi passi
- `versioning`: Gestione versioni con changelog automatico

## Metodologie Operative Distinctive

### Sviluppo Web Avanzato
1. **Preferenza per Bun**: Uso di Bun sopra npm per tutti i progetti
2. **Configurazione automatica**: Modifica automatica di package.json per esposizione porte
3. **Framework moderni**: Preferenza per shadcn/ui, Next.js con configurazioni ottimali
4. **Gestione asset**: Download e gestione intelligente di immagini
5. **Versioning proattivo**: Creazione versioni automatica al completamento feature

### Website Cloning Avanzato
1. **Limitazioni etiche**: Rigide regole contro cloning di siti con problemi etici/legali
2. **Processo strutturato**: Screenshot → Analisi → Pianificazione → Implementazione
3. **Attenzione ai dettagli**: Focus su font, colori, spacing, animazioni
4. **Conferma utente**: Richiesta di conferma per pagine e sezioni da clonare
5. **Asset optimization**: Uso diretto di asset "same-assets.com"

### Sistema di Editing Intelligente
- **Placeholder system**: `// ... existing code ... <description>`
- **Editing atomico**: Una modifica per file per volta
- **Intelligent apply**: Sistema di riapplicazione intelligente per correzioni
- **Gestione errori**: Massimo 3 tentativi per correzione errori

## Capacità Tecniche Distintive

### Gestione Template e Framework
- **Template preconfigurati**: html-ts-css, vue-vite, react-vite, nextjs-shadcn
- **Configurazione automatica**: TypeScript, ESLint, Prettier, Netlify
- **Tema management**: Sistema di temi integrato (zinc, blue, green, ecc.)
- **Shadcn integration**: Uso del nuovo CLI shadcn con flag corretti

### Sistema di Deployment Sofisticato
1. **Deployment statico**: Build e zip automatico
2. **Deployment dinamico**: Configurazione completa per app server-side
3. **Netlify integration**: Configurazione automatica netlify.toml
4. **Immagini remote**: Gestione automatica di immagini remote
5. **Fallback intelligente**: Tentativo statico → dinamico in caso di fallimento

### Web Scraping e Analisi
- **Screenshot integration**: Cattura visuale per analisi design
- **Tema support**: Scraping in modalità light/dark
- **Content extraction**: Estrazione strutturata di contenuti
- **Design analysis**: Analisi automatica di layout e styling

## Limitazioni e Vincoli

### Vincoli Etici per Cloning
- **Proibizione assoluta**: Mai clonare siti con problemi etici, legali o privacy
- **No phishing**: Mai clonare login page o form potenzialmente fraudolenti
- **Verifica contenuti**: Analisi preliminare per identificare contenuti problematici

### Limitazioni Tecniche
- **File non modificabili**: Lista estesa di file proibiti alla modifica
- **Dependency management**: Solo attraverso tool dedicato, non modifica diretta package.json
- **Formato file**: Supporto limitato per certi formati di file

### Vincoli Operativi
- **Singolo tool block**: Tutte le modifiche devono essere in un unico blocco `<lov-code>`
- **Completezza obbligatoria**: Ogni modifica deve risultare in codice immediatamente eseguibile
- **No modifiche parziali**: Proibizione di implementazioni incomplete

## Innovazioni Architetturali

### Sistema di Comunicazione Strutturata
- **Tag semantici**: Organizzazione chiara di comunicazione e azioni
- **Response format**: Struttura rigida per consistenza
- **Tool hiding**: Nascondere nomi degli strumenti all'utente

### Workflow di Sviluppo Integrato
1. **Analisi preliminare**: Verifica se la richiesta è già implementata
2. **Pianificazione dettagliata**: Lista di file da modificare prima dell'implementazione
3. **Implementazione atomica**: Tutte le modifiche in un singolo blocco
4. **Verifica finale**: Controllo che tutto sia funzionante

### Sistema di Versioning Automatico
- **Auto-increment**: Incremento automatico di versioni
- **Changelog strutturato**: 1-5 punti chiave per ogni versione
- **Version title**: Titoli descrittivi per navigazione
- **Timing**: Versioning prima del deployment

## Guidelines di Codifica Avanzate

### Principi di Organizzazione
- **File piccoli**: Componenti sotto 50 linee di codice
- **Separazione concerns**: File separato per ogni componente/hook
- **Refactoring proattivo**: Suggerimento di refactoring per file troppo grandi
- **Immediate component creation**: Creazione immediata di nuovi file per componenti

### Gestione Errori e Qualità
- **No try/catch**: Evitare gestione errori a meno che non richiesta specificamente
- **Error bubbling**: Permettere agli errori di emergere per debugging
- **Logging estensivo**: Console log per debugging del flusso di codice
- **Responsive by default**: Design sempre responsive

## Confronto con Altri Sistemi

### Differenze Architetturali
- **Cloud-native**: Approccio completamente cloud vs. IDE desktop
- **Web-focused**: Specializzazione specifica per sviluppo web
- **Template-driven**: Sistema di template preconfigurati vs. setup manuale
- **Deployment-integrated**: Pipeline di deployment nativo vs. setup esterno

### Vantaggi Competitivi
- Workflow di sviluppo web completamente integrato
- Sistema di cloning etico e avanzato
- Template preconfigurati per produttività immediata
- Versioning e deployment automatizzati
- Web scraping e analisi design integrate

## Conclusioni

Same.dev rappresenta un approccio altamente specializzato per lo sviluppo web moderno, con un'architettura pensata specificatamente per la produttività e la qualità nel development web. Il sistema combina strumenti avanzati di web scraping, template preconfigurati, deployment automatizzato e un workflow di sviluppo strutturato.

L'enfasi sulla comunicazione strutturata, l'etica nel cloning di siti web e l'integrazione completa di tutti gli aspetti dello sviluppo web rendono Same.dev particolarmente adatto per progetti web professionali che richiedono rapidità di sviluppo senza compromettere la qualità. Il sistema di versioning automatico e le guidelines di codifica rigorose garantiscono maintainability e scalabilità del codice prodotto.
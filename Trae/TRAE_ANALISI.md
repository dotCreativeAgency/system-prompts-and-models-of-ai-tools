# Analisi Dettagliata del System Prompt di Trae AI

## Panoramica
Trae AI si presenta come un potente assistente di coding agentico che opera sul paradigma rivoluzionario "AI Flow". Enfatizza la collaborazione in pair programming e un approccio metodico alla risoluzione di problemi di coding.

## Identità e Posizionamento
- **Trae AI**: Nome distintivo per assistente agentico
- **AI Flow paradigm**: Paradigma rivoluzionario per operazione
- **Pair programming**: Collaborazione attiva con l'utente
- **IDE agentico**: Operazione in ambiente IDE fantastico

## Architettura del Sistema

### Processo Decisionale
- **Tool requirement analysis**: Decidere se servono tool aggiuntivi
- **Flag-based operation**: Impostare flag per tipo di risposta
- **Structured output**: Tool input parameters o response text

### Tool Management
- **No tools available**: Attualmente nessun tool disponibile
- **Schema compliance**: Seguire rigorosamente definizioni schema
- **Tool existence verification**: Non chiamare mai tool non esistenti
- **Explanation first**: Analizzare prima di agire

### Guidelines Operative
- **Project analysis**: Analizzare informazioni su progetto corrente
- **Available tools listing**: Elencare tool disponibili per obiettivo
- **Tool comparison**: Confrontare e selezionare tool appropriato
- **Parameter accuracy**: Non inventare valori o chiedere parametri opzionali

## Comunicazione e Formattazione

### Reply Guidelines
- **Structured format**: Uso di placeholder specifici per unchanged code
- **Exact placeholder**: "// ... existing code ..." (formato rigido)
- **Code context**: Include codice unchanged prima e dopo modifiche
- **Brief explanations**: Spiegazioni prima degli aggiornamenti

### Code Block Standards
- **Language specification**: Specificare language ID e file path
- **Relative paths**: Quando path assoluto non determinabile
- **Method/class context**: Restare il contesto quando modifichi
- **Terminal commands**: Un comando per code block

### Web Citation Guidelines
- **Citation format**: Formato specifico per risultati web search
- **Line-by-line citations**: Prima di ogni line break
- **Multiple sources**: Citazioni multiple quando applicabile
- **Index-based**: Usare numeri indice per riferimenti

## Reference Management

### Code References
- **File reference**: Formato XML per file
- **Symbol reference**: Formato XML per simboli con startline
- **URL reference**: Formato XML per link
- **Folder reference**: Formato XML per cartelle

### Reference Separation
- **Web citations**: Separati da reference code
- **Context-appropriate**: Formato appropriato per contesto
- **Index numbers**: Solo per web search results
- **XML format**: Per code, symbol, URL, folder references

## Limitazioni e Vincoli

### Current Limitations
- **No tools**: Attualmente nessun tool disponibile
- **No toolcalls**: Non generare toolcall
- **Analysis only**: Focus su analisi e risposta diretta
- **Context dependency**: Dipendenza da contesto fornito

### Response Constraints
- **Markdown format**: Formattazione in markdown
- **Accuracy requirement**: Non mentire o inventare fatti
- **User context dependency**: Chiedere contesto quando mancante
- **Expertise limitation**: Solo argomenti software development

## Workflow Methodology

### Task Approach
1. **Context analysis**: Analizzare richiesta e contesto
2. **Tool assessment**: Valutare necessità di tool
3. **Response planning**: Pianificare tipo di risposta
4. **Structured delivery**: Consegnare risposta strutturata

### Code Modification Process
- **Unchanged code placeholder**: Uso rigido di placeholder
- **Context preservation**: Mantenere contesto existing code
- **Complete implementations**: Evitare implementazioni parziali
- **Bug fixing**: Output di code blocks corretti

## Confronto con Altri Sistemi
- **No tools currently**: Unico nel non avere tool disponibili
- **Structured communication**: Forte enfasi su formattazione
- **Citation system**: Sistema di citazione avanzato
- **Reference management**: Gestione sofisticata dei riferimenti

## Conclusioni
Trae AI rappresenta un approccio strutturato all'assistenza AI per coding, con forte enfasi sulla comunicazione chiara e formattazione precisa. Nonostante attualmente non abbia tool disponibili, mantiene un framework robusto per future espansioni.
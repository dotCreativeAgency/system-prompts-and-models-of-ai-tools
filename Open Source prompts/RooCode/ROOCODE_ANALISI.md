# Analisi di RooCode

## Panoramica
RooCode (Roo) è un ingegnere software altamente qualificato con ampie conoscenze in molti linguaggi di programmazione, framework, pattern di design e best practice. Si distingue per completare i compiti con modifiche minime al codice e un focus sulla manutenibilità.

## Caratteristiche Principali

### 1. Sistema di Modalità
- **Code Mode**: Modalità principale per sviluppo e modifiche al codice
- **Architect Mode**: Leader tecnico esperto per pianificazione e architettura
- **Ask Mode**: Assistente tecnico per rispondere a domande
- **Debug Mode**: Esperto di debug per diagnosi sistematica
- **Boomerang Mode**: Orchestratore di workflow che delega a modalità specializzate
- **Modalità personalizzabili**: Possibilità di creare nuove modalità per il progetto

### 2. Strumenti Avanzati
- **read_file**: Lettura con supporto per range di linee (start_line, end_line)
- **fetch_instructions**: Recupera istruzioni per creare MCP server o modalità
- **search_files**: Ricerca regex con pattern glob per filtrare file
- **list_files**: Elenca file e directory (ricorsivo o top-level)
- **list_code_definition_names**: Analizza definizioni di codice (classi, funzioni, ecc.)
- **apply_diff**: Sostituzioni precise con blocchi SEARCH/REPLACE e numeri di riga
- **write_to_file**: Scrittura completa di file con conteggio linee
- **search_and_replace**: Operazioni search/replace con preview diff
- **execute_command**: Esecuzione comandi con directory di lavoro opzionale
- **use_mcp_tool/access_mcp_resource**: Integrazione con server MCP
- **ask_followup_question**: Domande con suggerimenti di risposta
- **attempt_completion**: Presentazione risultati con comando demo opzionale
- **switch_mode**: Cambio modalità operativa
- **new_task**: Creazione nuovo task con modalità e messaggio iniziale

### 3. Sistema apply_diff Avanzato
- **Numeri di riga precisi**: Richiede start_line e end_line per ogni blocco
- **Multi-edit in un comando**: Supporta più blocchi SEARCH/REPLACE
- **Formato strutturato**:
  ```
  <<<<<<< SEARCH
  :start_line:1
  :end_line:5
  -------
  [contenuto esatto da trovare]
  =======
  [nuovo contenuto]
  >>>>>>> REPLACE
  ```

### 4. Restrizioni per Modalità
- **File restrictions**: Alcune modalità possono modificare solo certi pattern di file
- **Architect mode**: Solo file .md
- **Errori specifici**: FileRestrictionError quando si tenta di modificare file non permessi

### 5. Integrazione MCP
- **Server locali (Stdio)**: Girano sulla macchina locale via stdin/stdout
- **Server remoti (SSE)**: Girano su macchine remote via Server-Sent Events
- **Creazione dinamica**: Può creare nuovi server MCP su richiesta

### 6. Custom Instructions
- **Istruzioni per modalità**: File in .roo/rules-code/ per modalità Code
- **Istruzioni globali**: File in .roo/rules/ per tutte le modalità
- **Override system prompt**: .roo/system-prompt-code per sostituire completamente

### 7. Features Speciali
- **Support prompts**: Enhance prompt, explain code, fix issues, improve code
- **Terminal integration**: Add terminal content to context, fix/explain commands
- **Workspace awareness**: Conosce sempre la directory base del progetto
- **Multi-tool batching**: Può chiamare più strumenti in una singola risposta quando appropriato

## Punti di Forza
1. **Modalità specializzate**: Approcci diversi per task diversi
2. **Editing preciso**: Sistema apply_diff con numeri di riga per modifiche accurate
3. **Estensibilità**: Creazione di modalità e server MCP personalizzati
4. **Flessibilità configurazione**: Override completo tramite file di configurazione
5. **Context awareness**: Mantiene sempre consapevolezza del workspace e struttura

## Limitazioni
1. **Restrizioni modalità**: Alcune modalità possono modificare solo certi tipi di file
2. **Un tool alla volta**: Generalmente usa un tool per messaggio (con alcune eccezioni)
3. **Dipendenza da conferma**: Deve attendere conferma utente dopo tool use

## Casi d'Uso Ideali
- Progetti che richiedono approcci specializzati per diversi tipi di task
- Development con necessità di modalità architettura e debug separate
- Progetti che beneficiano di configurazioni personalizzate per team
- Sviluppo che richiede precisione nelle modifiche con tracking dei numeri di riga
- Team che vogliono standardizzare approcci tramite custom instructions
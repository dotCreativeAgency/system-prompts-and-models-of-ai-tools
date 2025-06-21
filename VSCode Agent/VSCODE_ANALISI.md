# Analisi Dettagliata del System Prompt di VSCode Agent

## Panoramica
VSCode Agent (GitHub Copilot) si presenta come un assistente di programmazione AI sofisticato con conoscenza esperta across molti linguaggi e framework. Integrato in VS Code, enfatizza ricerca approfondita e raccolta di contesto.

## Identità e Posizionamento
- **GitHub Copilot**: Nome ufficiale quando richiesto
- **Assistente sofisticato**: Conoscenza esperta multi-linguaggio
- **Ricerca-oriented**: Enfasi su ricerca e contesto
- **VS Code native**: Integrazione completa con VS Code

## Architettura del Sistema

### Metodologia di Ricerca
- **Ricerca semantica**: Preferita per contesto generale
- **Ricerca specifica**: Per string/filename patterns esatti
- **Raccolta contesto**: Responsabilità di completezza
- **Esplorazione creativa**: Approccio completo al workspace

### Tool Management
- **Schema rigoroso**: Seguire JSON schema precisamente
- **Esistenza verificata**: Usare solo tool esplicitamente forniti
- **Parallel execution**: Chiamate parallele quando possibile
- **No repetition**: Non ripetere dopo chiamate tool

### Editing Philosophy
- **No codeblock output**: Usare insert_edit_into_file invece
- **Tool-first approach**: Preferire tool a output manuale
- **Validation requirement**: get_errors dopo ogni edit
- **Context reading**: Leggere file prima di modificare

## Capacità Tecniche

### Gestione del Codice
- **Editor integration**: insert_edit_into_file con placeholder system
- **Error checking**: get_errors per validation
- **Context gathering**: Responsabilità di contesto completo
- **Best practices**: External libraries quando appropriato

### File e Workspace Management
- **Semantic search**: Per ricerca generale di codice
- **List usages**: Per funzioni, classi, metodi
- **File search**: Pattern-based file finding
- **Grep search**: Exact string matching

### VS Code Integration
- **API access**: get_vscode_api per extension development
- **Workspace creation**: create_new_workspace per setup
- **Extension installation**: install_extension quando necessario
- **Project setup**: get_project_setup_info per configurazione

## Policy e Limitazioni

### Content Policy
- **Microsoft compliance**: Seguire policy Microsoft
- **Copyright respect**: Evitare violazioni copyright
- **Harmful content**: Rifiutare contenuti dannosi
- **Brief responses**: Mantenere risposte concise

### Security Guidelines
- **No tool names**: Non menzionare nomi tool agli utenti
- **Permission-based**: Usare tool quando appropriato
- **Schema compliance**: Seguire rigorosamente gli schemi
- **Error handling**: get_errors per validation

## Workflow Metodologico

### Task Approach
1. **Ricerca preliminare**: Gathering di contesto necessario
2. **Analisi requirements**: Comprensione completa del task
3. **Implementation**: Uso di tool appropriati
4. **Validation**: Error checking e testing
5. **Documentation**: Update user preferences se necessario

### Communication Style
- **Conciseness**: Risposte brevi e impersonali
- **Tool-hiding**: Non rivelare meccaniche interne
- **Action-oriented**: Implementare piuttosto che suggerire
- **Context-aware**: Adattarsi al project type

## Confronto con Altri Sistemi
- **VS Code native**: Integrazione unica con VS Code
- **Research-heavy**: Enfasi sulla raccolta di contesto
- **Multi-modal**: Support per diversi tipi di workspace
- **Extension-aware**: Capacità di gestire estensioni VS Code

## Conclusioni
VSCode Agent rappresenta un approccio maturo all'assistenza AI in environment di sviluppo, con forte enfasi su ricerca, contesto e integrazione nativa con VS Code. La metodologia research-first garantisce soluzioni informate e appropriate.
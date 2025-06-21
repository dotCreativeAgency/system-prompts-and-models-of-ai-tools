# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a research repository containing system prompts, tools, and model configurations from major AI coding assistants and platforms. It serves as a comprehensive collection for analyzing and understanding how different AI tools are architected and configured.

## No Build System Required

This repository contains only text files (prompts and configurations) and requires no build, test, lint, or compilation processes. There are no package managers, dependencies, or development commands to run.

## Repository Structure

The repository is organized by AI platform/vendor:

### Commercial AI Platforms
- **v0 Prompts and Tools/** - Vercel's v0 AI assistant (includes Model.md with architecture details)
- **Cursor Prompts/** - Cursor IDE with multiple prompt versions and tool definitions
- **Manus Agent Tools & Prompt/** - Modular agent system with separate modules and agent loop
- **Devin AI/** - Autonomous software engineer prompts
- **Same.dev/** - AI development platform
- **Lovable/** - AI-powered development platform
- **Replit/** - Replit Agent with integrated tools
- **Windsurf/** - IDE-integrated AI agent
- **VSCode Agent/** - VSCode Copilot integration
- **Trae/** - AI chat and development assistant
- **dia/** - Browser-based AI assistant
- **Junie/** - AI system prompts

### Open Source Alternatives
- **Open Source prompts/Bolt/** - StackBlitz's open-source AI coding assistant
- **Open Source prompts/Cline/** - VSCode extension for AI-assisted coding
- **Open Source prompts/Codex CLI/** - Command-line AI coding tool
- **Open Source prompts/RooCode/** - Open-source AI coding platform

## Key Architecture Insights

### Prompt Evolution Patterns
- **Cursor** maintains versioned prompts (v1.0 vs base versions) showing prompt iteration
- **Manus** uses modular architecture with separate agent loop and modules files
- **v0** includes detailed model architecture documentation alongside prompts

### Tool Integration Approaches
- **Replit** and **Windsurf** include comprehensive tool definitions (Tools.json)
- **Cursor** separates agent tools from chat prompts for different interaction modes
- **Manus** provides detailed tool specifications in tools.json with capability descriptions

### Multi-Modal Capabilities
- **Trae** distinguishes between chat and development-focused prompts
- **Cursor** includes memory management and rating systems for context handling
- **v0** integrates with Next.js runtime and includes asset handling capabilities

## Research and Analysis Focus

When working with this repository, typical tasks involve:

### Comparative Analysis
- Analyzing prompt engineering techniques across platforms
- Comparing tool integration strategies and capabilities
- Identifying security constraints and safety measures

### Content Analysis
- Extracting specific architectural patterns from prompts
- Cataloging tool capabilities and API structures
- Understanding context management and memory systems

### Security Research
- Examining safety constraints and content filtering
- Identifying potential prompt injection vulnerabilities
- Analyzing defensive measures implemented by different platforms

## Important Files for Deep Analysis

- **v0 Prompts and Tools/Model.md** - Contains architectural details about v0's model configuration
- **Manus Agent Tools & Prompt/Agent loop.txt** - Describes the agent execution loop architecture
- **Manus Agent Tools & Prompt/Modules.txt** - Modular capability breakdown
- **Cursor Prompts/Agent Tools v1.0.json** - Comprehensive tool definitions for analysis
- **Replit/Tools.json** and **Windsurf/Tools.json** - Platform-specific tool implementations

## Navigation Tips

- Use search tools to find specific capability descriptions across platforms
- Most core functionality is defined in `Prompt.txt` files within each folder
- Tool definitions are in `Tools.json` or `tools.json` files where available
- Version differences can be found by comparing files like `Agent Prompt.txt` vs `Agent Prompt v1.0.txt`
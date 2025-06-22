# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FacileGestire 2.0 is a multi-tenant real estate management application built with:
- **Backend**: Laravel 12 with PHP 8.2+
- **Frontend**: React 19 with TypeScript and Vite
- **Multi-tenancy**: Stancl/Tenancy with separate databases per tenant
- **Authentication**: Laravel Passport (OAuth2) with central authentication
- **Architecture**: Modular design using nwidart/laravel-modules
- **UI**: Material-UI 7 with CSS Variables, Radix UI components, TailwindCSS 4
- **Frontend Architecture**: Separated contexts (Central/Tenant/Shared) with dedicated layouts and themes

## Brand Guidelines

### Official Colors
- **"Facile" (Orange)**: `#ff9800`
- **"Gestire" (Blue)**: `#02a9f4`
- **Navbar Background**: `#f5f5f5` (Light Gray for optimal contrast)
- **Logo Location**: `/resources/js/images/Logo.svg`

Use these colors consistently across all components and interfaces to maintain brand coherence.

## Application Architecture

### Dual Authentication System
The application uses a **dual authentication approach**:

1. **Web Authentication** (Traditional Laravel):
   - **Registration/Login**: Users register and login via traditional web routes (`/auth/register`, `/auth/login`)
   - **Email Verification**: Standard Laravel email verification process
   - **Session-based**: Uses Laravel sessions for web interface authentication
   - **Purpose**: Initial user onboarding and email verification flow

2. **API Authentication** (OAuth2/Passport):
   - **SPA Access**: React SPA uses OAuth2 PKCE flow for secure API access
   - **Token-based**: All API operations use Passport Bearer tokens
   - **Multi-tenant**: API tokens include tenant context via X-Tenant header
   - **Purpose**: Main application functionality and data operations

### Authentication Flow
1. User registers via web form → Email verification required
2. User verifies email → Account activated
3. User accesses SPA → OAuth2 PKCE flow initiated
4. SPA receives token → API access enabled with tenant context

## Development Commands

### Laravel Sail (Docker Environment)
```bash
# Start/Stop environment
./vendor/bin/sail up         # Start all services (Laravel, MySQL, Redis, etc.)
./vendor/bin/sail up -d      # Start in detached mode
./vendor/bin/sail down       # Stop all services

# Development server with all services
./vendor/bin/sail composer dev  # Runs serve, queue, logs, and vite concurrently

# Individual services
./vendor/bin/sail artisan serve              # Start Laravel server
./vendor/bin/sail artisan queue:listen       # Process queues
./vendor/bin/sail artisan pail              # Real-time logs

# Database operations
./vendor/bin/sail artisan migrate           # Run migrations (central)
./vendor/bin/sail artisan tenants:migrate   # Run tenant migrations
./vendor/bin/sail artisan db:seed           # Seed central database
./vendor/bin/sail artisan tenants:seed      # Seed all tenant databases

# Complete fresh migration with OAuth setup
./vendor/bin/sail artisan migrate:fresh-complete --seed  # Fresh + Passport + Postman update

# Passport OAuth setup (manual)
./vendor/bin/sail artisan passport:install  # Generate OAuth keys
./vendor/bin/sail artisan passport:client --personal  # Create personal access client

# Postman integration
./vendor/bin/sail artisan postman:update-client-id      # Update Postman environment files
./vendor/bin/sail artisan postman:update-client-id --check  # Check if update needed

# Testing
./vendor/bin/sail artisan test             # Run PHPUnit tests
./vendor/bin/sail composer test           # Same as above

# Code quality
./vendor/bin/sail bin pint                # Laravel Pint (PHP CS Fixer)

# Container management
./vendor/bin/sail shell                   # Access Laravel container shell
./vendor/bin/sail mysql                   # Access MySQL container
./vendor/bin/sail redis                   # Access Redis container
```

### Frontend (React/Vite)
```bash
# Development
npm run dev                 # Start Vite dev server
npm run build              # Production build
npm run types              # TypeScript type checking

# Code quality
npm run lint               # ESLint with auto-fix
npm run format             # Prettier formatting
npm run format:check       # Check Prettier formatting

# Material-UI v7 Tools
npm run mui:check          # Check MUI v7 compliance
npm run mui:migrate        # Auto-migrate Grid props to v7
npm run check:imports      # Verify all import paths are valid

# API Testing
npm run test               # Quick API tests with Newman
npm run test:dev           # Development environment tests
npm run test:staging       # Staging environment tests
npm run test:all          # Comprehensive test suite
```

## MCP (Model Context Protocol) Configuration

FacileGestire 2.0 includes MCP servers for enhanced Claude Code integration.

### Available MCP Servers

1. **MySQL Database Server** (`mcp_server_mysql`) - PRIMARY
   - Multi-database access (central + all tenants)
   - Database schema inspection
   - Read-only SQL queries
   - Table structure analysis
   - Safe data exploration

2. **Laravel Application Server** (`laravel`)
   - Artisan command execution
   - Tenant management operations
   - Laravel-specific tools
   - Application introspection

### MCP Setup

MCP servers are installed directly using the Claude Code CLI, not through configuration files.

#### Quick Installation
```bash
# Run the installation script
./scripts/install-mcp-servers.sh
```

#### Manual Installation
```bash
# 1. Install MySQL MCP Server (Primary)
claude mcp add-json mcp_server_mysql '{
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "@benborla29/mcp-server-mysql"],
  "env": {
    "MYSQL_HOST": "127.0.0.1",
    "MYSQL_PORT": "3306",
    "MYSQL_USER": "sail",
    "MYSQL_PASS": "password",
    "MYSQL_DB": "",
    "ALLOW_INSERT_OPERATION": "false",
    "ALLOW_UPDATE_OPERATION": "false",
    "ALLOW_DELETE_OPERATION": "false",
    "PATH": "/path/to/node/bin:/usr/bin:/bin",
    "NODE_PATH": "/path/to/node/lib/node_modules"
  },
  "cwd": "/path/to/project"
}'

# 2. Install Laravel MCP Server
claude mcp add-json laravel '{
  "type": "stdio",
  "command": "./vendor/bin/sail",
  "args": ["artisan", "mcp:serve"],
  "cwd": "/path/to/project"
}'
```

### Available MCP Tools

#### MySQL Server (Primary)
- `mysql_query` - Execute SQL queries (read-only)
- Multi-database access (central + tenant databases)
- Database schema inspection
- Table structure analysis

#### Laravel Server
- `artisan_command` - Execute Laravel Artisan commands
- `tenant_management` - Tenant CRUD operations
- `database_query` - Laravel-aware database queries
- Application resource access

### Security Features

- **Read-Only Database Access**: All modification operations disabled
- **Multi-Database Support**: Access to all databases (MYSQL_DB blank)
- **Environment Isolation**: Respects current environment settings
- **Server Priority**: MySQL server takes precedence for database operations

### Setup Requirements

- Claude Code CLI installed
- Docker/Sail environment running
- Node.js and npm available in PATH

For detailed setup instructions, see: **doc/mcp/setup.md**

## Architecture

### Multi-Tenant Structure
- **Central Domain**: Manages tenants, users, and global resources
- **Tenant Context**: Each tenant has isolated database and functionality
- **SSO System**: Users authenticate centrally, access multiple tenants

### Database Architecture
- **Central DB**: Stores tenants, central users, regions, provinces, municipalities
- **Tenant DBs**: Separate database per tenant with tenant-specific data
- **Migrations**: Separate migration paths for central vs tenant contexts

### Module System
Located in `Modules/` directory:
- **Property**: Property management functionality
- **Roles**: RBAC system with Spatie permissions
- Each module has its own routes, controllers, models, migrations, tests

### API Structure
- **Central API** (`/api/v1/`): Authentication, tenant management, geographical data
- **Tenant API** (`/api/v1/tenant/`): Tenant-specific operations requiring X-Tenant header
- **OAuth Flow**: PKCE implementation for secure authentication
- **Rate Limiting**: Tenant-specific rate limiting with Redis

### Frontend Architecture
- **SPA Mode**: React application with TypeScript
- **Separated Contexts**: Central/Tenant/Shared organization for better maintainability
- **Component Structure**: 
  - `resources/js/components/central/` - Central context components
  - `resources/js/components/tenant/` - Tenant context components  
  - `resources/js/components/shared/` - Shared/reusable components
- **Layout System**: Dedicated layouts for Central (simple) and Tenant (sidebar) contexts
- **Routing**: React Router with context-aware protected routes
- **State Management**: TanStack Query for server state
- **Theming**: Separate themes for Central and Tenant contexts with CSS Variables
- **UI Framework**: Material-UI v7 with Grid v2, Radix UI components, TailwindCSS 4

## Material-UI v7 Guidelines

### Key Features Used
- **CSS Variables**: Enabled in both themes for better performance (`cssVariables: true`)
- **Grid v2**: Modern grid system without `item` prop, uses `size` prop instead
- **Separate Themes**: `centralTheme.ts` and `tenantTheme.ts` with context-specific styling
- **Zero Runtime**: Optimized for performance with CSS variable extraction

### Component Patterns

#### Grid Usage (v7 Standard)
```typescript
// ✅ CORRECT - CSS Grid for simple layouts
<Box sx={{ 
  display: 'grid', 
  gridTemplateColumns: { xs: '1fr', md: 'repeat(3, 1fr)' }, 
  gap: 3 
}}>
  {items.map(item => <Card key={item.id}>{item.content}</Card>)}
</Box>

// ✅ CORRECT - Grid v2 for complex layouts  
<Grid container spacing={3}>
  <Grid size={{ xs: 12, md: 6 }}>
    <Paper>Content</Paper>
  </Grid>
</Grid>

// ❌ AVOID - Grid legacy syntax
<Grid item xs={12} md={6}>  // 'item' prop removed in v7
```

#### Theme Usage with CSS Variables
```typescript
// ✅ Theme with CSS Variables enabled
export const theme = createTheme({
  cssVariables: true, // Essential for MUI v7
  palette: {
    primary: { main: '#02a9f4' }, // "Gestire" Blue
    secondary: { main: '#ff9800' }, // "Facile" Orange
  }
});

// ✅ Using CSS variables in components
sx={{
  backgroundColor: 'var(--mui-palette-primary-main)',
  color: theme.vars.palette.text.primary // Preferred method
}}
```

#### Import Patterns
```typescript
// ✅ CORRECT - Top-level imports only
import { Button, Card, Typography } from '@mui/material';
import { createTheme } from '@mui/material/styles';

// ❌ AVOID - Deep imports (not supported in v7)
import createTheme from '@mui/material/styles/createTheme';
```

### MUI X Data Grid
- **Version Strategy**: MUI X packages maintain independent versioning
- **Current Version**: Keep existing `@mui/x-data-grid` version (not v7)
- **Compatibility**: Fully compatible with Material-UI v7 core

### Development Tools
- **Compliance Check**: `npm run mui:check` - Scans for v7 compliance issues
- **Auto Migration**: `npm run mui:migrate` - Automatic Grid props migration
- **Documentation**: See `doc/frontend/MUI-V7-GUIDE.md` for complete guide

### Context-Specific Themes
```
themes/
├── central/
│   └── centralTheme.ts    # Light theme for dashboard/admin
└── tenant/
    └── tenantTheme.ts     # Slightly different styling for tenant app
```

Dynamic theme selection based on URL context in `App.tsx`:
```typescript
const isTenantContext = window.location.pathname.startsWith('/tenant');
const currentTheme = isTenantContext ? tenantTheme : centralTheme;
```

## Key Configuration Files

### Environment Setup
- `.env.local.computer1.example` - Development computer 1
- `.env.local.computer2.example` - Development computer 2  
- `.env.local.computer3.example` - Development computer 3
- Use `ENVIRONMENT_SETUP.md` for multi-computer development

### Vite Configuration
- Development mode serves from `dist-dev/` directory
- Production mode builds to `public/build/`
- Proxy configuration for API calls to Laravel backend
- Module federation support for multi-computer development

## Testing

### Backend Testing
- **Framework**: Pest PHP with Laravel integration
- **Test Types**: Feature tests in `tests/Feature/`, Unit tests in `tests/Unit/`
- **Database**: Uses separate testing database
- **Tenancy Testing**: Special test cases for multi-tenant functionality

### API Testing
- **Tool**: Newman (Postman CLI) with comprehensive test suites
- **Collections**: `doc/api/FacileGestire-API-Complete.postman_collection.json`
- **Environments**: Separate configs for dev/staging/production
- **Docker Support**: Containerized Newman testing with `docker-compose.newman.yml`

### Test Commands Reference
```bash
# Backend tests
./vendor/bin/sail artisan test --filter=SSOTest  # Run specific test
./vendor/bin/sail artisan test --coverage       # With coverage

# API tests
npm run test:quick                # Quick smoke tests
npm run test:dev                  # Full development suite
npm run api:docker:test          # Dockerized API tests

# Frontend tests
npm run lint                     # ESLint validation
npm run types                    # TypeScript checking
```

## Multi-Tenant Development

### Tenant Context Switching
- Central operations use default database connection
- Tenant operations require tenant initialization via middleware
- Use `X-Tenant` header for API requests to tenant endpoints
- SSO system allows users to access multiple tenants

### Database Seeding
- **Central**: Run `./vendor/bin/sail artisan db:seed` for regions, provinces, municipalities
- **Tenant**: Automatic seeding on tenant creation via JobPipeline
- **Module Seeders**: Each module handles its own seeding logic

### Queue System
- Tenant-aware queue processing with separate Redis contexts
- Background jobs for tenant database setup and seeding
- Rate limiting per tenant to prevent abuse

## Common Development Patterns

### Adding New Modules
1. Generate module: `./vendor/bin/sail artisan module:make ModuleName`
2. Configure in `module.json` with proper service providers
3. Add routes in module's `routes/` directory
4. Implement tenant/central specific controllers as needed

### API Development
- Follow RESTful conventions with proper HTTP status codes
- Use Resource transformers for consistent API responses
- Implement proper validation with FormRequest classes
- Add comprehensive test coverage for all endpoints

### Frontend Development
- **TypeScript**: Use for type safety and better developer experience
- **Component Organization**: Separate by context (central/tenant/shared)
- **Material-UI v7**: Follow Grid v2 patterns, use CSS variables, avoid deep imports
- **Layout System**: Use appropriate layout (CentralLayout vs TenantLayout)
- **Theme Context**: Ensure correct theme usage based on URL context
- **Component Patterns**: 
  - Use Radix UI for complex interactive components
  - Material-UI for basic UI elements and theming
  - CSS Grid for simple layouts, Grid v2 for complex responsive layouts
- **Error Boundaries**: Implement proper error boundaries and loading states
- **State Management**: Use TanStack Query for server state, React state for UI state
- **Routing**: Use context-aware routing (`/dashboard` for central, `/tenant` for tenant)
- **Compliance**: Run `npm run mui:check` before commits to ensure MUI v7 compliance

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.

## Material-UI v7 Specific Reminders

### CRITICAL: Component Usage
- **Grid**: ALWAYS use Grid v2 syntax with `size` prop, NEVER use `item` prop
- **Imports**: ONLY use top-level imports from `@mui/material`, NEVER deep imports
- **Themes**: ALWAYS enable `cssVariables: true` in createTheme()
- **Context**: Use appropriate theme (centralTheme for `/dashboard`, tenantTheme for `/tenant`)

### Data Grid Exception
- **MUI X packages** (Data Grid, Date Pickers, etc.) maintain INDEPENDENT versioning
- **DO NOT** upgrade MUI X packages to v7 - keep existing versions
- **Example**: `@mui/material: "^7.1.0"` but `@mui/x-data-grid: "^6.x.x"`

### Development Workflow
1. Run `npm run mui:check` to verify compliance
2. Use `npm run mui:migrate` for automatic Grid migrations
3. Test both Central and Tenant contexts after changes
4. Verify CSS variables are working in browser dev tools
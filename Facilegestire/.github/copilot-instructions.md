# GitHub Copilot Instructions for FacileGestire 2.0

You are an AI programming assistant working on FacileGestire 2.0, a multi-tenant real estate management application.

## Project Architecture

### Technology Stack
- **Backend**: Laravel 12 with PHP 8.2+
- **Frontend**: React 19 with TypeScript and Vite
- **Multi-tenancy**: Stancl/Tenancy with separate databases per tenant
- **Authentication**: Laravel Passport (OAuth2) with central authentication
- **Architecture**: Modular design using nwidart/laravel-modules
- **UI**: Material-UI 7, Radix UI components, TailwindCSS 4
- **Frontend Architecture**: Separated contexts (Central/Tenant/Shared)

### Brand Guidelines
- **"Facile" (Orange)**: `#ff9800`
- **"Gestire" (Blue)**: `#02a9f4`
- **Navbar Background**: `#f5f5f5`
- **Logo Location**: `/resources/js/images/Logo.svg`

## Development Guidelines

### Laravel Best Practices
- Use modular architecture with nwidart/laravel-modules
- Follow Laravel 12 conventions and patterns
- Implement proper multi-tenancy separation
- Use Laravel Passport for OAuth2 authentication
- Follow PSR-12 coding standards

### React/TypeScript Guidelines
- Use functional components with TypeScript
- Implement proper type definitions
- Follow React 19 best practices
- Use Material-UI 7 components consistently
- Maintain separation between Central/Tenant/Shared contexts

### Authentication Flow
1. Web registration/login for initial onboarding
2. Email verification required
3. OAuth2 PKCE flow for SPA access
4. Tenant context maintained in API calls

### Code Quality
- Write comprehensive error handling
- Add proper logging for debugging
- Follow SOLID principles
- Implement proper validation
- Use dependency injection

### Git Workflow
- Use feature branches
- Write descriptive commit messages
- Follow conventional commits format
- Test before committing

## Common Commands

### Laravel Sail
```bash
./vendor/bin/sail up -d      # Start environment
./vendor/bin/sail down       # Stop environment
./vendor/bin/sail artisan    # Run artisan commands
./vendor/bin/sail composer   # Run composer
./vendor/bin/sail npm        # Run npm commands
```

### Development
```bash
./vendor/bin/sail npm run dev    # Start Vite dev server
./vendor/bin/sail artisan migrate # Run migrations
./vendor/bin/sail artisan module:make <ModuleName> # Create module
```

## File Organization
- Backend modules in `/Modules/`
- Frontend components in `/resources/js/`
- Maintain clear separation between contexts
- Use consistent naming conventions

## Security Considerations
- Validate all inputs
- Use Laravel's built-in security features
- Implement proper CORS configuration
- Follow OWASP guidelines
- Sanitize user data

When suggesting code, always consider the multi-tenant architecture and ensure proper isolation between tenants.
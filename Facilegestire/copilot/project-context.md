# FacileGestire 2.0 Project Context

## Business Domain
FacileGestire is a comprehensive real estate management platform designed for:
- Property managers
- Real estate agencies
- Property owners
- Tenants

## Core Features

### Property Management
- Property listings with detailed information
- Image galleries and virtual tours
- Maintenance tracking
- Document management

### Contract Management
- Rental agreements
- Sales contracts
- Digital signatures
- Payment tracking

### Financial Management
- Rent collection
- Expense tracking
- Financial reporting
- Invoice generation

### Communication Hub
- Tenant-landlord messaging
- Maintenance requests
- Announcements
- Email notifications

## Technical Architecture Details

### Backend Structure
```
/Modules/
├── Auth/           # Central authentication
├── Property/       # Property management
├── Contract/       # Contract handling
├── Finance/        # Financial operations
├── Communication/  # Messaging system
└── Shared/         # Common utilities
```

### Frontend Structure
```
/resources/js/
├── Central/        # Central admin features
├── Tenant/         # Tenant-specific features
├── Shared/         # Shared components
├── hooks/          # Custom React hooks
├── services/       # API service layer
├── types/          # TypeScript definitions
└── utils/          # Utility functions
```

### Database Schema Highlights
- `central` database: users, tenants, oauth tables
- `tenant_*` databases: properties, contracts, transactions
- Automatic tenant identification via subdomain

### API Endpoints Pattern
```
/api/v1/properties          # List properties
/api/v1/properties/{id}     # Get property details
/api/v1/contracts           # Manage contracts
/api/v1/finance/invoices    # Financial operations
```

### Authentication Flow
1. User registers at `app.facilegestire.com/auth/register`
2. Email verification required
3. Login redirects to tenant subdomain
4. OAuth2 token obtained for API access
5. All API calls include tenant context

### UI/UX Patterns
- Material-UI components for consistency
- Orange (#ff9800) for primary actions
- Blue (#02a9f4) for secondary elements
- Responsive design mobile-first
- Accessibility compliance

### Development Workflow
1. Create feature branch
2. Develop with Laravel Sail
3. Test locally with tenant isolation
4. Run linters and tests
5. Submit PR for review

### Common Tasks

#### Creating a New Module
```bash
./vendor/bin/sail artisan module:make ModuleName
```

#### Adding a New API Endpoint
1. Create route in module's `routes/api.php`
2. Create controller with proper middleware
3. Implement service layer logic
4. Add TypeScript types in frontend
5. Create React components

#### Testing Multi-Tenancy
1. Create test tenant
2. Switch between tenants
3. Verify data isolation
4. Test cross-tenant security

### Performance Optimization
- Redis caching for frequent queries
- Queue jobs for heavy operations
- Image optimization for properties
- Lazy loading for large lists
- API response pagination

### Monitoring and Logging
- Laravel Telescope for debugging
- Custom logging per tenant
- Error tracking with context
- Performance metrics

This context helps understand the full scope of FacileGestire 2.0 and guides development decisions.
# FacileGestire 2.0 Code Patterns and Examples

## Laravel Patterns

### 1. Multi-Tenant Model
```php
namespace Modules\Property\Models;

use Illuminate\Database\Eloquent\Model;
use Stancl\Tenancy\Database\Concerns\BelongsToTenant;

class Property extends Model
{
    use BelongsToTenant;
    
    protected $fillable = [
        'title', 'description', 'address', 'price',
        'bedrooms', 'bathrooms', 'square_meters'
    ];
    
    protected $casts = [
        'price' => 'decimal:2',
        'available_from' => 'date',
        'features' => 'array'
    ];
    
    public function images()
    {
        return $this->hasMany(PropertyImage::class);
    }
    
    public function contracts()
    {
        return $this->hasMany(Contract::class);
    }
}
```

### 2. Repository Pattern
```php
namespace Modules\Property\Repositories;

use Modules\Property\Models\Property;
use Modules\Property\Contracts\PropertyRepositoryInterface;

class PropertyRepository implements PropertyRepositoryInterface
{
    public function findByFilters(array $filters): Collection
    {
        return Property::query()
            ->when($filters['min_price'] ?? null, function ($query, $minPrice) {
                $query->where('price', '>=', $minPrice);
            })
            ->when($filters['bedrooms'] ?? null, function ($query, $bedrooms) {
                $query->where('bedrooms', '>=', $bedrooms);
            })
            ->with(['images' => fn($q) => $q->where('is_primary', true)])
            ->paginate(20);
    }
    
    public function createWithImages(array $data, array $images): Property
    {
        return DB::transaction(function () use ($data, $images) {
            $property = Property::create($data);
            
            foreach ($images as $image) {
                $property->images()->create([
                    'path' => Storage::disk('tenant')->put('properties', $image),
                    'is_primary' => $image['is_primary'] ?? false
                ]);
            }
            
            return $property->fresh('images');
        });
    }
}
```

### 3. Service Layer with Dependency Injection
```php
namespace Modules\Property\Services;

use Modules\Property\Repositories\PropertyRepository;
use Modules\Property\Events\PropertyCreated;
use Illuminate\Support\Facades\Cache;

class PropertyService
{
    public function __construct(
        private PropertyRepository $repository,
        private ImageService $imageService
    ) {}
    
    public function createProperty(array $data, ?array $images = null): Property
    {
        $property = $this->repository->createWithImages($data, $images ?? []);
        
        event(new PropertyCreated($property));
        
        Cache::tags(['properties', "tenant:{$property->tenant_id}"])
            ->forget('properties.index');
        
        return $property;
    }
    
    public function getAvailableProperties(): Collection
    {
        return Cache::tags(['properties', "tenant:" . tenant('id')])
            ->remember('properties.available', 3600, function () {
                return $this->repository->findByFilters(['available' => true]);
            });
    }
}
```

### 4. API Controller with Validation
```php
namespace Modules\Property\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Modules\Property\Services\PropertyService;
use Modules\Property\Http\Requests\StorePropertyRequest;
use Modules\Property\Http\Resources\PropertyResource;

class PropertyController extends Controller
{
    public function __construct(
        private PropertyService $propertyService
    ) {}
    
    public function index(Request $request)
    {
        $properties = $this->propertyService->getAvailableProperties();
        
        return PropertyResource::collection($properties);
    }
    
    public function store(StorePropertyRequest $request)
    {
        $property = $this->propertyService->createProperty(
            $request->validated(),
            $request->file('images')
        );
        
        return new PropertyResource($property);
    }
}
```

### 5. Form Request Validation
```php
namespace Modules\Property\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StorePropertyRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', Property::class);
    }
    
    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'max:255'],
            'description' => ['required', 'string'],
            'address' => ['required', 'string', 'max:500'],
            'price' => ['required', 'numeric', 'min:0'],
            'bedrooms' => ['required', 'integer', 'min:0'],
            'bathrooms' => ['required', 'integer', 'min:0'],
            'square_meters' => ['required', 'numeric', 'min:0'],
            'available_from' => ['required', 'date', 'after:today'],
            'images' => ['array', 'max:10'],
            'images.*' => ['image', 'max:5120'] // 5MB max
        ];
    }
}
```

## React/TypeScript Patterns

### 1. Type Definitions
```typescript
// types/property.ts
export interface Property {
  id: number;
  title: string;
  description: string;
  address: string;
  price: number;
  bedrooms: number;
  bathrooms: number;
  squareMeters: number;
  availableFrom: string;
  images: PropertyImage[];
  createdAt: string;
  updatedAt: string;
}

export interface PropertyImage {
  id: number;
  url: string;
  isPrimary: boolean;
}

export interface PropertyFilters {
  minPrice?: number;
  maxPrice?: number;
  bedrooms?: number;
  bathrooms?: number;
}
```

### 2. API Service Layer
```typescript
// services/propertyService.ts
import { apiClient } from '@/utils/apiClient';
import { Property, PropertyFilters } from '@/types/property';

export const propertyService = {
  async getProperties(filters?: PropertyFilters): Promise<Property[]> {
    const { data } = await apiClient.get('/api/v1/properties', {
      params: filters
    });
    return data.data;
  },
  
  async getProperty(id: number): Promise<Property> {
    const { data } = await apiClient.get(`/api/v1/properties/${id}`);
    return data.data;
  },
  
  async createProperty(property: Partial<Property>): Promise<Property> {
    const { data } = await apiClient.post('/api/v1/properties', property);
    return data.data;
  },
  
  async updateProperty(id: number, updates: Partial<Property>): Promise<Property> {
    const { data } = await apiClient.put(`/api/v1/properties/${id}`, updates);
    return data.data;
  }
};
```

### 3. Custom Hooks
```typescript
// hooks/useProperties.ts
import { useState, useEffect } from 'react';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { propertyService } from '@/services/propertyService';
import { Property, PropertyFilters } from '@/types/property';
import { useToast } from '@/hooks/useToast';

export const useProperties = (filters?: PropertyFilters) => {
  return useQuery({
    queryKey: ['properties', filters],
    queryFn: () => propertyService.getProperties(filters),
    staleTime: 5 * 60 * 1000, // 5 minutes
  });
};

export const useCreateProperty = () => {
  const queryClient = useQueryClient();
  const { showSuccess, showError } = useToast();
  
  return useMutation({
    mutationFn: propertyService.createProperty,
    onSuccess: (property) => {
      queryClient.invalidateQueries({ queryKey: ['properties'] });
      showSuccess('Proprietà creata con successo!');
    },
    onError: (error) => {
      showError('Errore nella creazione della proprietà');
    }
  });
};
```

### 4. React Components with Material-UI
```typescript
// components/PropertyCard.tsx
import React from 'react';
import {
  Card,
  CardMedia,
  CardContent,
  Typography,
  Chip,
  Box,
  IconButton
} from '@mui/material';
import { Bedroom, Bathroom, SquareFoot, Edit } from '@mui/icons-material';
import { Property } from '@/types/property';

interface PropertyCardProps {
  property: Property;
  onEdit?: (property: Property) => void;
}

export const PropertyCard: React.FC<PropertyCardProps> = ({ property, onEdit }) => {
  const primaryImage = property.images.find(img => img.isPrimary) || property.images[0];
  
  return (
    <Card sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
      {primaryImage && (
        <CardMedia
          component="img"
          height="200"
          image={primaryImage.url}
          alt={property.title}
        />
      )}
      <CardContent sx={{ flexGrow: 1 }}>
        <Box display="flex" justifyContent="space-between" alignItems="center" mb={1}>
          <Typography variant="h6" component="h2" noWrap>
            {property.title}
          </Typography>
          {onEdit && (
            <IconButton size="small" onClick={() => onEdit(property)}>
              <Edit fontSize="small" />
            </IconButton>
          )}
        </Box>
        
        <Typography variant="h5" color="primary" gutterBottom>
          €{property.price.toLocaleString('it-IT')}
        </Typography>
        
        <Box display="flex" gap={2} mb={2}>
          <Chip
            icon={<Bedroom />}
            label={`${property.bedrooms} camere`}
            size="small"
          />
          <Chip
            icon={<Bathroom />}
            label={`${property.bathrooms} bagni`}
            size="small"
          />
          <Chip
            icon={<SquareFoot />}
            label={`${property.squareMeters} m²`}
            size="small"
          />
        </Box>
        
        <Typography variant="body2" color="text.secondary" noWrap>
          {property.address}
        </Typography>
      </CardContent>
    </Card>
  );
};
```

### 5. Form Handling with React Hook Form
```typescript
// components/PropertyForm.tsx
import React from 'react';
import { useForm, Controller } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import {
  TextField,
  Button,
  Grid,
  InputAdornment
} from '@mui/material';
import { DatePicker } from '@mui/x-date-pickers';
import { Property } from '@/types/property';

const propertySchema = z.object({
  title: z.string().min(1, 'Titolo richiesto'),
  description: z.string().min(1, 'Descrizione richiesta'),
  address: z.string().min(1, 'Indirizzo richiesto'),
  price: z.number().min(0, 'Prezzo deve essere positivo'),
  bedrooms: z.number().int().min(0),
  bathrooms: z.number().int().min(0),
  squareMeters: z.number().min(0),
  availableFrom: z.date()
});

type PropertyFormData = z.infer<typeof propertySchema>;

interface PropertyFormProps {
  property?: Property;
  onSubmit: (data: PropertyFormData) => void;
}

export const PropertyForm: React.FC<PropertyFormProps> = ({ property, onSubmit }) => {
  const {
    control,
    handleSubmit,
    formState: { errors, isSubmitting }
  } = useForm<PropertyFormData>({
    resolver: zodResolver(propertySchema),
    defaultValues: property || {
      bedrooms: 1,
      bathrooms: 1,
      availableFrom: new Date()
    }
  });
  
  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Grid container spacing={3}>
        <Grid item xs={12}>
          <Controller
            name="title"
            control={control}
            render={({ field }) => (
              <TextField
                {...field}
                label="Titolo"
                fullWidth
                error={!!errors.title}
                helperText={errors.title?.message}
              />
            )}
          />
        </Grid>
        
        <Grid item xs={12}>
          <Controller
            name="description"
            control={control}
            render={({ field }) => (
              <TextField
                {...field}
                label="Descrizione"
                fullWidth
                multiline
                rows={4}
                error={!!errors.description}
                helperText={errors.description?.message}
              />
            )}
          />
        </Grid>
        
        <Grid item xs={12} md={6}>
          <Controller
            name="price"
            control={control}
            render={({ field }) => (
              <TextField
                {...field}
                label="Prezzo"
                type="number"
                fullWidth
                InputProps={{
                  startAdornment: <InputAdornment position="start">€</InputAdornment>
                }}
                error={!!errors.price}
                helperText={errors.price?.message}
              />
            )}
          />
        </Grid>
        
        <Grid item xs={12}>
          <Button
            type="submit"
            variant="contained"
            fullWidth
            disabled={isSubmitting}
            sx={{ mt: 2 }}
          >
            {property ? 'Aggiorna Proprietà' : 'Crea Proprietà'}
          </Button>
        </Grid>
      </Grid>
    </form>
  );
};
```

### 6. Context for Tenant Management
```typescript
// contexts/TenantContext.tsx
import React, { createContext, useContext, ReactNode } from 'react';
import { useTenant } from '@/hooks/useTenant';

interface TenantContextValue {
  tenantId: string;
  tenantName: string;
  tenantDomain: string;
  switchTenant: (tenantId: string) => Promise<void>;
}

const TenantContext = createContext<TenantContextValue | undefined>(undefined);

export const TenantProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const tenant = useTenant();
  
  return (
    <TenantContext.Provider value={tenant}>
      {children}
    </TenantContext.Provider>
  );
};

export const useTenantContext = () => {
  const context = useContext(TenantContext);
  if (!context) {
    throw new Error('useTenantContext must be used within TenantProvider');
  }
  return context;
};
```

These patterns demonstrate best practices for FacileGestire 2.0 development, including proper typing, error handling, multi-tenancy awareness, and clean architecture.
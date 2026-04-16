# 01 - Core Architecture

## TL;DR

```
Layer Flow: Domain (pure) → Data (Supabase/Drift) → Application → Controller (Riverpod) → Presentation (UI)

Golden Rules:
- Domain = Pure Dart (no Flutter, no Riverpod, no external deps)
- Data = Supabase API + Drift database implementations
- Controller = ALL providers centralized in ONE file per sub-feature
- UI = Dumb (no business logic)
- File naming: name.type.dart (e.g., wine.model.dart)
- Drift = source of truth, Supabase = sync backend
```

## Checklist

- [ ] Domain layer has no `import 'package:flutter'` or `flutter_riverpod`
- [ ] No `AsyncValue` in domain entities
- [ ] All providers in `controller/feature.provider.dart`
- [ ] Repository interface in `domain/`, implementation in `data/`
- [ ] Use cases in `domain/CRUD/`
- [ ] UI only calls controllers, never repositories

---

## Layer Responsibilities

```
features/<feature>/
├── domain/                    ← Pure Business Logic (Dart only)
│   ├── entities/              ← Business objects (Freezed)
│   ├── repositories/          ← Interface definitions (abstract)
│   └── CRUD/                  ← Use cases (single responsibility)
├── data/                      ← External Data Handling
│   ├── models/                ← JSON serialization (Freezed + json_serializable)
│   ├── data_sources/          ← Supabase client, Drift DAOs
│   └── repositories/          ← Repository implementations (local-first)
├── application/               ← Business Workflow (Optional)
├── controller/                ← State Management (Riverpod)
└── presentation/              ← UI Layer
    ├── modules/               ← Screens + routes
    └── widgets/               ← Reusable UI components
```

## Data Flow (Local-First)

```
User taps "Load Wines"
         ↓
WineListScreen calls ref.read(wineControllerProvider.notifier).loadWines()
         ↓
WineController calls GetWinesUseCase
         ↓
GetWinesUseCase calls WineRepository.getWines()
         ↓
WineRepositoryImpl:
  1. Fetch from Supabase
  2. Save to Drift (local DB)
  3. Return from Drift (source of truth)
         ↓
WineController updates state (AsyncValue<List<WineEntity>>)
         ↓
UI rebuilds with new data
```

## Dependency Rules

```
Allowed:
Domain    → (nothing)
Data      → Domain
Application → Domain, Data
Controller → Domain, Data, Application
Presentation → Domain, Controller

Forbidden:
Domain → Data, Controller, Presentation, Riverpod
```

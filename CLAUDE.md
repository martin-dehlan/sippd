# CLAUDE.md — Sippd

**Version**: 1.0  
**Last Updated**: 2026-04-16

---

## Architecture

```
Domain (pure) → Data (API/DB) → Application → Controller (Riverpod) → Presentation (UI)
```

---

## Golden Rules

1. **Feature-based**: Self-contained features (wines, auth, groups)
2. **Local-first**: Drift = source of truth, Supabase = sync backend
3. **No fixed spacing**: `MediaQuery` everywhere
4. **Freezed**: Models, entities, states
5. **Naming**: `name.type.dart` (e.g., `wine.model.dart`)
6. **Centralized providers**: ALL in `controller/feature.provider.dart`
7. **Lean UI**: NO gradients, glassmorphism, heavy shadows
8. **Widget extraction**: NO `_build*()` methods → separate classes

---

## Forbidden

```dart
// NEVER
const spacing = 16;                    // Use MediaQuery
SizedBox(height: 24)                   // Use h * 0.02
Widget _buildHeader() {...}            // Extract to class
gradient: LinearGradient(...)          // Solid colors only
Colors.blue                            // Use colorScheme
import 'package:flutter' in domain/    // Domain = pure Dart
print('debug')                         // Use debugPrint or logger
AsyncValue<T> in domain entities       // Only in Controller
```

---

## Standard Patterns

```dart
// Widget structure
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    
    return Container(
      padding: EdgeInsets.all(w * 0.04),
      child: Column(
        children: [
          Text('Title'),
          SizedBox(height: h * 0.02),
          Text('Content'),
        ],
      ),
    );
  }
}

// Spacing formulas
xs: h * 0.005 | s: h * 0.01 | m: h * 0.02 | l: h * 0.03 | xl: h * 0.04

// Colors: ONLY from Theme colorScheme
final cs = Theme.of(context).colorScheme;
```

---

## Commands

```bash
# Generate code
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch --delete-conflicting-outputs

# Format & analyze
dart format . && flutter analyze
```

---

## On-Demand Rules

| Task | File |
|------|------|
| **UI Work** | `RULES/09_design_principles.md` |
| **Architecture** | `RULES/01_core_architecture.md` |
| **Database** | `RULES/04_drift_database_rules.md` |
| **State** | `RULES/05_riverpod_patterns.md` |
| **Spacing** | `RULES/03_responsive_ui_rules.md` |
| **Code Gen** | `RULES/06_code_generation.md` |
| **Errors** | `RULES/07_error_handling.md` |
| **Navigation** | `RULES/08_navigation_structure.md` |
| **Testing** | `RULES/10_testing_rules.md` |
| **Naming** | `RULES/02_file_naming_conventions.md` |

---

## Structure

```
lib/
├── common/           Cross-feature (database, theme, utils, widgets)
├── core/             Routes, config
├── features/
│   ├── wines/        Wine ranking, photos, filtering
│   ├── auth/         Supabase auth
│   └── groups/       Group wine lists, shared ratings
└── main.dart
```

Each feature:
```
features/<feature>/
├── data/         Models, API, DAO, Repo impl
├── domain/       Entities, Repo interfaces, Use cases
├── controller/   ALL providers (centralized)
└── presentation/ Screens, widgets
```

---

## File Size Limits

```
Widget files: 300 lines max
Controller/Provider files: 400 lines max
Service/Repository files: 300 lines max
```

---

## File Naming

```
Pattern: name.type.dart

wine.entity.dart       (domain)
wine.model.dart        (data)
wine.repository.dart   (interface)
wine.repository.impl.dart (implementation)
wine.dao.dart          (Drift)
wine.provider.dart     (ALL providers)
wine_list.screen.dart  (UI)
wine_card.widget.dart  (UI)
```

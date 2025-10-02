# Memory Maths: Accessible Educational Technology
## Research Software Engineer Application – University of Nottingham
### Repository‑Verified Presentation (Speculative claims removed)

> This version only includes facts observable in the codebase plus clearly marked potential future directions. All prior unverified metrics (user base, performance timings, coverage %, clinical usage, AI, publications, analytics) have been removed or reframed.

---
## Slide 1: Title
**Memory Maths: Accessible Educational Technology**  
**Role:** Research Software Engineer (Level 4)  
**School:** School of Medicine, University of Nottingham  
**Date:** October 2025  
**Tagline:** "Modular math & logic game suite with accessibility and adaptive scaffolding foundations"

---
## Slide 2: Current Scope (Repository Facts)
- Flutter/Dart application (local, client‑only)  
- 18 enumerated game categories (`GameCategoryType`)  
- Per‑game in‑memory repositories (no I/O / network)  
- Accessibility foundation: dyslexic theme + OpenDyslexic fonts  
- Adaptive scaffold: rolling accuracy & response time (heuristic)  
- Reporting & profile model shells present (no export logic yet)  
- State management: Provider (ChangeNotifier) + GetIt service locator  
- Shared UI widget library (buttons, dialogs, neumorphic containers, number pads)  

---
## Slide 3: Game Portfolio (Enum Driven)
Categories (18): CALCULATOR, GUESS_SIGN, SQUARE_ROOT, MATH_PAIRS, CORRECT_ANSWER, MAGIC_TRIANGLE, MENTAL_ARITHMETIC, QUICK_CALCULATION, FIND_MISSING, TRUE_FALSE, MATH_GRID, PICTURE_PUZZLE, NUMBER_PYRAMID, DUAL_GAME, COMPLEX_CALCULATION, CUBE_ROOT, CONCENTRATION, NUMERIC_MEMORY  
**Pattern:** enum + model + repository + UI screen (scalable template)  
**Benefit:** Adding a new game does not require refactoring existing modules.

---
## Slide 4: Architecture (Observed Patterns)
```
UI Layer        : Per-game views + shared common widgets
State Layer     : GameProvider<T>, TimeProvider, (potential coin/theme providers)
Data Layer      : Static repositories (pure generators)
Core            : app_constant, adaptive_difficulty, theming (standard + dyslexic)
Utilities       : math_util (expression builder), sizing & formatting helpers
Routing         : app_routes (static mapping)
```
**Not Implemented:** networking, persistence, analytics, auth, cloud services.  
**Implication:** Clean baseline; minimal coupling; easy to layer services later.

---
## Slide 5: Accessibility Foundations
Implemented:  
- Dyslexic theme tokens (`dyslexic_theme.dart`)  
- OpenDyslexic + other font assets  
- High‑contrast styled shared components  
- Central spacing & sizing helpers  
Gaps / Next Steps:  
- Semantic labels & screen reader hints  
- Runtime contrast & font scaling toggles  
- Persisted accessibility preferences  
- Automated a11y regression tests (golden / contrast checks)

---
## Slide 6: Adaptive Difficulty (Heuristic Scaffold)
File: `adaptive_difficulty.dart`  
Tracks: rolling accuracy (List<double>), response times (List<int>)  
Current Use: Passive metrics collection (manual integration via provider)  
Not Present: persistence, ML models, advanced heuristics, auto difficulty feedback loop  
Future Extension (Potential): difficulty trajectory, decay weighting, cross‑session profiling.

---
## Slide 7: Data & Reporting (Present vs Potential)
Present:  
- Models for user profile & report (`user_profile.dart`, `user_report.dart`)  
- `pdf` dependency in `pubspec.yaml`  
- No implemented exporter / serializer in repository snapshot  
Potential (Future):  
- Session aggregation → report generation  
- PDF / JSON export service  
- FAIR alignment once metadata + persistence layer added.

---
## Slide 8: Scalability Characteristics
Strengths:  
- Pure functional repository generation (fast, testable)  
- Enum registry → predictable extension workflow  
- Shared UI primitives reduce duplication  
- No hidden side effects (no implicit remote calls)  
Constraints / Debt:  
- Large multi‑responsibility GameProvider  
- Static lists in some repositories (shared mutable risk if sessions overlap)  
- No abstraction for future remote data sources  
- Adaptive logic not centrally driving generation ranges.

---
## Slide 9: Testing (Observed)
Test files (15) covering: repository logic, arithmetic generation, integration style list assembly.  
Not Verified (Therefore Not Claimed): coverage %, performance benchmarks, CI automation.  
Recommended Additions: provider state transition tests, golden UI tests, deterministic seed injection for reproducibility.

---
## Slide 10: Extensibility & Refactor Plan
Short‑Term (Low Risk):  
1. Split GameProvider: session / scoring / timer / adaptive / dialog  
2. Introduce `GameRepository<T>` interface + registry map  
3. Deterministic RNG seeding for test reproducibility  
Mid‑Term:  
4. Local persistence (session logs)  
5. Export pipeline (PDF builder using existing models)  
6. Event instrumentation (structured domain events)  
Long‑Term (Potential):  
7. Remote/FHIR adapter  
8. Secure profiles + consent/governance layer  
9. Enhanced adaptive engine (trend & anomaly detection)

---
## Slide 11: Research / Clinical Alignment (Potential Path)
Current Code Element → Possible Extension:  
- Adaptive scaffold → calibrated cognitive load metrics  
- Diverse game set → cognitive domain tagging (memory, speed, reasoning)  
- Report models → standardized outcome battery export  
- Dyslexic theme → expanded accessibility (semantics, spacing controls)  
- Repositories → swappable remote / evidence‑driven content sources  
Prerequisites: governance, persistence, data validation, audit logging.

---
## Slide 12: Integrity & Safe Language
Fact Language: “The repository currently provides…”, “Structure enables…”, “Next step would be…”.  
Avoid: adoption claims, clinical efficacy, performance numbers, AI/ML claims (none present), coverage percentages (not measured).  
Value Statement: Solid modular foundation prepared for responsible layering (persistence, analytics, research instrumentation) without architectural upheaval.

---
## Slide 13: Summary (Current vs Ready For)
Current (Verified): 18 game categories, heuristic adaptive tracker, dyslexic theme, 15 test files, modular repository pattern.  
Ready For: persistence layer, export implementation, accessibility expansion, adaptive sophistication.  
Immediate Wins: provider decomposition, repository interface, export service, semantics & a11y improvements.

---
## Slide 14: Closing (Fact‑Based)
“Memory Maths is a modular, testable Flutter codebase with accessibility and adaptive learning foundations. While intentionally local and generation‑focused today, its seams (repositories, providers, adaptive scaffold, reporting models) offer a clear, low‑risk path to evolve into a research‑grade platform.”

---
## Appendix (Representative Files)
Core: `app_constant.dart`, `adaptive_difficulty.dart`, `dyslexic_theme.dart`  
Models: `calculator.dart`, `magic_triangle.dart`, `math_pairs.dart`, `user_report.dart`  
Repositories: `calculator_repository.dart`, `magic_triangle_repository.dart`, etc.  
State: `game_provider.dart`, `time_provider.dart`  
Utilities: `math_util.dart`, `global_constants.dart`  
UI Examples: `ui/calculator/`, `ui/magicTriangle/`, `ui/common/`

---
## Appendix (Observed Strengths / Gaps)
| Aspect | Strength | Gap |
|--------|----------|-----|
| Modularity | Enum + per‑repo pattern | No unified repo contract |
| Accessibility | Theme + fonts | Missing semantics & runtime toggles |
| Adaptivity | Rolling stats scaffold | No persistence / feedback loop |
| Testing | Logic & repository tests | No coverage metrics / provider tests |
| Extensibility | Pure generation logic | No pluggable data source layer |

---
## Speaker Notes (Condensed)
Emphasize: factual scope, modularity, accessibility start, adaptive scaffold, clean path to expansion.  
De‑emphasize: any claims not backed by code (AI, clinical use, performance, adoption).  
Answer Strategy: map every question to “current vs next step” framing.

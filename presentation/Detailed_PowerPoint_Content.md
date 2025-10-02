# Memory Maths - Research Software Engineer Interview Presentation
## University of Nottingham - School of Medicine
### Detailed Slide Content with Speaker Notes (Repository-Verified Version)

> NOTE: All quantitative statements below are limited strictly to what is observable in the provided repository. Any former speculative performance, user, adoption, clinical or research impact figures have been removed or reframed as potential future directions.

---

## Slide 1: Title Slide
**Visual:** Clean title with university colors, professional layout

**Title:** Memory Maths: Accessible Educational Technology
**Subtitle:** Research Software Engineer Application - University of Nottingham
**Presenter:** [Your Name]
**Date:** October 2025
**Tagline:** "Bridging Software Engineering Practices with Inclusive Learning Design"

**Speaker Notes:**
- Introduce self and purpose
- Clarify this is an existing Flutter codebase (not a conceptual mockup)
- Focus today: architecture, extensibility, accessibility foundations, potential health-informatics alignment

---

## Slide 2: Problem Context (Framed Without External Metrics)
**Visual:** Contrast of generic interface vs accessibility-aware interface

**Context (Repository-Relevant):**
- Codebase includes custom theme (`dyslexic_theme.dart`) suggesting intent to support readability challenges
- Presence of font assets (e.g. OpenDyslexic variants) indicates focus on accessible typography
- Multiple game modes imply cognitive practice / variety rather than single-task drilling
- No external data collection or clinical integration implemented in current code

**Design Motivations (Inferred from Structure):**
- Diversity of game types for attention, memory, symbol recognition, arithmetic fluency
- Abstraction of game models + repositories suggests planned scalability
- Inclusion of adaptive difficulty manager file points toward personalization goals

**Speaker Notes:**
- Emphasize distinction: current scope = local, self‑contained educational / brain-training set
- Avoid unverified health outcome claims
- Position this as a solid foundation ready for responsible extension

---

## Slide 3: Solution Overview - Current Codebase Snapshot
**Visual:** Collage of existing screenshot assets in `lib/screenshots/`

**Implemented Components (Verified):**
- Flutter application targeting multiple math & logic mini-games
- 18 game category enums in `GameCategoryType` (calculator, magic triangle, numeric memory, etc.)
- Separate data models under `src/data/models/`
- Per-category repository generators under `src/data/repositories/`
- Shared UI utilities & common widgets under `src/ui/common/`
- Adaptive difficulty manager (`adaptive_difficulty.dart`)
- Accessibility-focused theme (`dyslexic_theme.dart`)
- Reporting domain models (`user_report.dart`, `user_profile.dart`, `report_constants.dart`) – modelling only; no persistence / network layer present

**Quantifiable (From Repo):**
- Game Types: 18 (enum entries)
- Test Files Present: 15 (in `/test` directory) – mixture of repository & logic tests
- State Management: Provider + GetIt (service locator) patterns

**Speaker Notes:**
- Avoid stating runtime performance or adoption (not verifiable here)
- Focus on structural readiness & modularity

---

## Slide 4: Game Portfolio (Enum-Backed)
**Visual:** Grid listing each enum name with brief model file link

**Categories (from `GameCategoryType`):**
1. CALCULATOR
2. GUESS_SIGN
3. SQUARE_ROOT
4. MATH_PAIRS
5. CORRECT_ANSWER
6. MAGIC_TRIANGLE
7. MENTAL_ARITHMETIC
8. QUICK_CALCULATION
9. FIND_MISSING
10. TRUE_FALSE
11. MATH_GRID
12. PICTURE_PUZZLE
13. NUMBER_PYRAMID
14. DUAL_GAME
15. COMPLEX_CALCULATION
16. CUBE_ROOT
17. CONCENTRATION
18. NUMERIC_MEMORY

**Structural Traits:**
- Each linked to: model + repository generator logic + UI folder (most categories)
- Supports extension (add enum + model + repository + screen)

**Speaker Notes:**
- Highlight consistent pattern enabling scalable addition
- Mention some categories likely share logic (e.g. arithmetic derived expressions) reducing duplication

---

## Slide 5: Technical Architecture (Observed Patterns)
**Visual:** Layer diagram (Models → Repositories → Providers → UI)

**Patterns in Use:**
```
UI Layer: Stateless/Stateful Widgets + common UI helpers
State Management: Provider (ChangeNotifier), plus GetIt for locator
Data Generation: Repository classes (pure in‑memory logic, no I/O)
Domain Models: Plain data classes (Hive annotations present in some legacy files – but Hive not wired currently)
Adaptive Logic: AdaptiveDifficultyManager (local, stateless calc + history lists)
Theming: Standard + Dyslexic theme variants
Routing: `app_routes.dart`
```

**Not Present (Avoid Claims):**
- No networking layer
- No remote persistence
- No authentication logic tied to external services (only local modeling)
- No explicit analytics exporting implementation

**Speaker Notes:**
- Emphasize clarity & separation despite absence of back-end
- Suggest ease of layering a service interface later

---

## Slide 6: Accessibility Foundations (Code Evidence)
**Visual:** Snippets of `dyslexic_theme.dart` & font asset names

**Implemented Elements:**
- Custom dyslexia-friendly color & spacing tokens (`dyslexic_theme.dart`)
- Font assets including OpenDyslexic variants in `assets/fonts/`
- Large, high-contrast themed widgets (in common UI utilities)
- Consistent spacing helpers (`global_constants.dart` / sizing utilities)

**Not Yet Implemented:**
- Runtime user toggles for all adaptive spacing parameters (only theme scaffold)
- Semantic labels / screen-reader instrumentation (not visible in reviewed snippets)

**Potential Next Steps:**
- Central accessibility service (contrast toggle, font scaling persistence)
- Automated golden tests for accessible color contrast

**Speaker Notes:**
- Reinforce: foundation exists; refinement & instrumentation = future work

---

## Slide 7: Adaptive Difficulty (Implemented Logic Scope)
**Visual:** Core method excerpt from `adaptive_difficulty.dart`

```dart
// Example (abridged for slide):
class AdaptiveDifficultyManager {
  final List<double> _accuracyHistory = [];
  final List<int> _responseTimeHistory = [];
  void recordSample({required bool isCorrect, required int responseMillis}) { /* stores sample */ }
  double get rollingAccuracy => _accuracyHistory.isEmpty
      ? 0
      : _accuracyHistory.reduce((a,b)=>a+b)/_accuracyHistory.length;
  // Additional suggestion / heuristic methods follow...
}
```

**Current Capability:**
- Maintains rolling accuracy & response collections
- Provides heuristic adjustment potential (lightweight personalization)

**Not Present:**
- ML models / external training
- Persisted history across sessions
- Difficulty back-propagation into all repositories uniformly (depends on manual integration)

**Speaker Notes:**
- Frame as scaffolding ready for advanced analytics

---

## Slide 8: Data & Reporting (Current vs Potential)
**Visual:** `user_report.dart` structure + `pdf` dependency mention

**Current State (Code):**
- Data model classes for user profiles & reports
- No implemented persistence (only in-memory modeling)
- Dependency `pdf` present in `pubspec.yaml` (indicates planned reporting) – actual PDF generation logic not shown in provided context

**Potential Extensions (Explicitly Future):**
- Map in-game events → aggregated performance objects
- Export flows (PDF / JSON) wired to sharing intents
- Introduce FAIR-aligned metadata (identifiers, provenance fields)

**Speaker Notes:**
- Stress honesty: reporting layer is structural, not yet operational

---

## Slide 9: Scalability Characteristics (Observable)
**Visual:** Diagram of adding new game module steps

**Strengths (Evidenced):**
- Enumerated categories enable compile-time discovery
- Repositories are pure & side-effect free (fast, testable)
- Modular folder structure per game (`/ui/<gameName>/`) improves isolation
- Common UI utilities prevent repetitive widget code

**Technical Debt / Risks:**
- Some provider classes accumulate multiple responsibilities
- Certain repositories rely on static lists (risk of shared mutable state in future session-based designs)
- No abstraction layer for future remote / hybrid data sources yet

**Low-Risk Improvements:**
- Introduce base `GameRepository` interface
- Decompose large providers (timer vs scoring vs progression)
- Add dependency inversion for adaptive difficulty consumption

**Speaker Notes:**
- Keep tone constructive & transparent

---

## Slide 10: Research & Clinical Alignment (Framed as Potential)
**Visual:** Table: Current Code Element → Possible Health Informatics Mapping

| Current Element | Verified Purpose | Potential Extension (Future Work) |
|-----------------|------------------|-----------------------------------|
| AdaptiveDifficultyManager | Local performance tracking | Calibrated cognitive load metrics |
| Multiple Game Categories | Varied task structures | Domain tagging (memory, processing speed) |
| User Report Models | Structural aggregation | Standardized outcome battery export |
| Dyslexic Theme | Readability improvement | Broader accessibility (contrast APIs, screen reader) |
| Repository Pattern | Pure generators | Swappable clinical data-backed sources |

**Speaker Notes:**
- Emphasize *pathway* instead of *claims*
- Show readiness for collaborative research build-out

---

## Slide 11: Testing & Quality (Repository View)
**Visual:** List of filenames from `/test`

**Observed Test Files (15):**
- `advanced_games_test.dart`
- `app_constants_test.dart`
- `calculator_model_test.dart`
- `calculator_repository_test.dart`
- `correct_answer_test.dart`
- `dashboard_models_test.dart`
- `magic_triangle_test.dart`
- `math_pairs_test.dart`
- `math_util_test.dart`
- `missing_features_test.dart`
- `provider_state_test.dart`
- `puzzle_games_test.dart`
- `repository_integration_test.dart`
- `root_operations_test.dart`
- `sign_repository_test.dart`

**Strengths:**
- Coverage of arithmetic logic & repository generation patterns
- Inclusion of integration-style test (`repository_integration_test.dart`)

**Not Verified (Therefore Not Claimed):**
- Overall coverage percentage
- Performance benchmarking
- Automated CI configuration (not shown)

**Speaker Notes:**
- Offer to run or extend tests; suggest adding golden tests & snapshot baselines

---

## Slide 12: Collaboration & Extensibility Readiness
**Visual:** Dependency graph (Providers ↔ Repositories ↔ UI)

**Collaboration-Ready Aspects:**
- Clear folder topology (`core/`, `data/`, `ui/`, `utility/`)
- Distinct model naming improves code searchability
- Service locator (GetIt) centralizes shared services

**Refactor Opportunities:**
- Formalize interfaces to ease onboarding (e.g. `IGameScorer`, `ITimerService`)
- Add README per game folder documenting generation rules

**Speaker Notes:**
- Position codebase as a solid starting platform for a research engineering team

---

## Slide 13: Integration Potential (Future-Focused, No Present Claims)
**Visual:** Roadmap arrow: Local → Instrumented → Connected → Analytical

**Potential Alignment Paths:**
- Add persistence (SQLite / REST / FHIR gateway) for longitudinal study data
- Instrument anonymized event logging for cognitive pattern detection
- Implement export adapters (PDF already feasible via dependency)
- Tag gameplay events with standardized cognitive domain metadata

**Prerequisites (Not Yet Done):**
- Data governance / consent layer
- Authentication & role separation
- Secure storage / encryption

**Speaker Notes:**
- Reinforce responsible sequencing before health data usage

---

## Slide 14: Roadmap (Proposed – Based on Current Gaps)
**Stage 1 (Short-Term):**
- Interface extraction for repositories & services
- Provider decomposition (score, timer, difficulty)
- Add unit tests for adaptive difficulty edge cases

**Stage 2 (Mid-Term):**
- Persistence layer (local first) + serialization of sessions
- Event instrumentation & structured log schema
- Reporting pipeline (generate real PDF from models)

**Stage 3 (Long-Term):**
- External API / FHIR adapter
- Secure multi-user profiles
- Advanced analytics (trend & anomaly detection)

**Speaker Notes:**
- Tie each stage to risk-managed expansion

---

## Slide 15: Value Summary (Current Facts + Future Readiness)
**Current (Verified):**
- 18 modular game categories implemented
- Adaptive difficulty scaffold present
- Accessibility theme & specialized fonts included
- Test suite with 15 logical/integration test files
- Clear separation of concerns via repositories & providers

**Ready For:**
- Extension to persistence, analytics, standardized exports
- Integration into broader research software stack
- Collaborative iteration (patterns & naming consistent)

**Next Concrete Enhancements:**
1. Formal contract interfaces
2. Persist adaptive metrics
3. Implement real report exporter
4. Strengthen accessibility semantics (a11y labels)

**Speaker Notes:**
- Stay concise; invite deep-dive questions

---

## Appendix A: Representative Files
| Layer | Example Files |
|-------|---------------|
| Core  | `app_constant.dart`, `adaptive_difficulty.dart`, `dyslexic_theme.dart` |
| Models | `calculator.dart`, `magic_triangle.dart`, `math_pairs.dart`, `user_report.dart` |
| Repositories | `calculator_repository.dart`, `math_pairs_repository.dart`, etc. |
| UI | `ui/calculator/`, `ui/magicTriangle/`, `ui/common/` |
| Utility | `math_util.dart`, `global_constants.dart` |

---

## Appendix B: Observed Strengths / Weaknesses Table
| Aspect | Strength (Verified) | Limitation / Gap |
|--------|---------------------|------------------|
| Modularity | Distinct repos & models | Some cross-cutting provider complexity |
| Accessibility | Dyslexic theme & fonts | Missing semantic annotations & runtime toggles |
| Adaptivity | Rolling accuracy mechanism | No persistence / advanced heuristics yet |
| Testing | Multiple logic test files | No reported coverage metric present |
| Extensibility | Enum-driven game registry | Lacks plugin registration / DI abstraction |

---

## Appendix C: Safe Language Guidance (Interview)
Use: "The repository currently provides…" / "The structure enables…" / "Potential next step would be…"  
Avoid: Unverified claims about users, clinical outcomes, adoption, performance benchmarks.

---

## Speaker Preparation Notes (Updated)
**Key Messages:**
1. Real, inspectable modular codebase
2. Accessibility & adaptivity foundations present
3. Honest boundaries: no persistence, no analytics yet
4. Clear, low-risk path to research instrumentation
5. Architecture supports incremental evolution

**Anticipated Questions (Answer Scope):**
- Performance? → Not benchmarked; architecture allows profiling insertion
- Data export? → Models + `pdf` dep ready; exporter missing
- Clinical use? → Not implemented; requires governance & data layer first
- Scaling? → Enum + repository pattern lowers friction to add more categories

**Closing Statement (Fact-Based):**
"Memory Maths demonstrates a clean, extensible Flutter architecture with 18 modular game categories, adaptive scaffolding, and accessibility-aware theming. While currently local and generation-focused, its structure is well positioned for responsible expansion into data persistence, analytics, and research-aligned reporting."

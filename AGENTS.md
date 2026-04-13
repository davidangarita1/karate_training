# AGENTS.md — Karate Training Project

## Project Overview

API test automation project built with **Karate DSL** (v1.5.0) + **JUnit 5** + **Maven**.
All tests are `.feature` files (Gherkin) executed via JUnit 5 runners.

## Tech Stack

| Tool | Version | Purpose |
|---|---|---|
| Java | 17 | Runtime |
| Karate DSL | 1.5.0 | API testing framework |
| JUnit 5 | bundled | Test runner |
| Maven | 3.8+ | Build tool |
| dotenv-java | 2.3.2 | Load `.env` variables |

## Build & Test Commands

```bash
# Run all tests (parallel, 5 threads)
mvn test

# Run a specific feature via its runner
mvn test -Dtest=UsersRunner

# Run with a specific environment
mvn test -Dkarate.env=e2e
```

## Project Structure

```
src/test/java/
├── karate-config.js              # Global config — loads env vars, sets baseUrl, apiKey
├── logback-test.xml              # Logging
└── examples/
    ├── ExamplesTest.java         # Parallel runner — entry point for all features
    └── <domain>/
        ├── <domain>.feature      # Gherkin scenarios (BDD)
        └── <Domain>Runner.java   # JUnit 5 runner for the feature
```

## Code Conventions

### Feature Files (`<domain>.feature`)
- One `Feature` per file, one file per domain/resource
- `Background` holds shared setup: `url`, `header`, model schemas
- Use `* def <model>` in Background to define reusable JSON schemas with Karate fuzzy matchers (`#number`, `#string`, etc.)
- Group by HTTP verb order: GET list → GET single → POST → PUT → PATCH → DELETE
- Tags: `@smoke` for critical paths, `@regression` for full suite
- NEVER hardcode secrets — use config variables from `karate-config.js`
- NEVER add implementation details in step descriptions — keep business language

### Runner Classes (`<Domain>Runner.java`)
- Package: `examples.<domain>`
- Import: `com.intuit.karate.junit5.Karate`
- One `@Karate.Test` method named after the feature
- Use `Karate.run("<domain>").relativeTo(getClass())`
- No logic in runners — they are pure wiring

### karate-config.js
- All environment-specific values live here
- Priority for secrets: `System.getenv()` → `dotenv.get()` → hardcoded default
- Return a flat config object consumed by all features

## Security Rules

- `.env` is gitignored — never commit credentials
- API keys always via `apiKey` config variable, never inline
- Use `.env.example` to document required variables without values

## BDD / Gherkin Principles

- **Single responsibility**: one scenario = one behaviour
- **Declarative over imperative**: describe WHAT, not HOW
- **No technical jargon** in step descriptions
- **Reuse** schemas via `Background` or shared `.feature` files called with `call read(...)`
- **Assertions** always use `match` — never raw Java assertions in feature files

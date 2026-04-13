---
name: karate-feature-generator
description: Generates Karate .feature files and JUnit 5 Runner classes from user stories or test case descriptions. Creates files in examples/<domain>/ following BDD, Gherkin, clean code, and SOLID principles.
argument-hint: "<domain> — e.g. pets, orders, payments"
---

# Karate Feature Generator Skill

## When to invoke this skill

Load this skill when the user provides:
- A **User Story** (HU/US)  
- A list of **test cases or acceptance criteria**
- A **domain name** for a new API resource
- A request to scaffold a new feature with its runner

## Process — execute in order

1. **Parse input** — identify: domain name, resource path, HTTP verbs needed, fields/model, business rules
2. **Read existing patterns** — `read_file` on `src/test/java/examples/users/users.feature` and `UsersRunner.java` to match code style exactly
3. **Read templates** — load `.github/skills/karate-feature-generator/templates/feature.template.md` and `runner.template.md`
4. **Generate feature file** → `src/test/java/examples/<domain>/<domain>.feature`
5. **Generate runner class** → `src/test/java/examples/<domain>/<Domain>Runner.java`
6. **Confirm output** — show the user both files and the paths created

## Mapping User Story → Feature scenarios

| HU element | Karate element |
|---|---|
| Acceptance criteria (happy path) | `Scenario` with `@smoke` tag |
| Validation / error rule | `Scenario` with `@error-path` tag |
| Data variations | `Scenario Outline` + `Examples` table |
| Preconditions | `Background` steps |
| Domain entity fields | `* def <domain>Model` schema in Background |

## Scenario order (always follow this order)

1. List all resources — `GET /<domain>`
2. Get single resource — `GET /<domain>/{id}`
3. Create resource — `POST /<domain>`
4. Full update — `PUT /<domain>/{id}`
5. Partial update — `PATCH /<domain>/{id}`
6. Delete — `DELETE /<domain>/{id}`
7. Error / edge cases (404, 400, 422)

## Karate DSL rules — non-negotiable

```
ALLOWED matchers:
  '#number'     → any number
  '#string'     → any string
  '#boolean'    → any boolean
  '#null'       → null value
  '#notnull'    → not null
  '#ignore'     → skip this field
  '#array'      → any array
  '#[n]'        → array of exactly n items
  '#regex ...'  → regex match

FORBIDDEN in .feature files:
  × Hardcoded API keys
  × Java code or imports
  × Implementation details in step text
  × Raw assertEquals — always use 'match'
  × Business logic (calculations, conditions)
  × Comments in code (# inline comments, // or /* */ in Java) — self-documenting
    code is preferred; scenario names and tag names must be expressive enough
```

## Background — always include

```gherkin
Background:
    * url baseUrl                                          # from karate-config.js
    * header Authorization = 'Bearer ' + apiKey           # if auth needed
    * def <domain>Model = { id: '#number', <field>: '#string', ... }
```

## Schema definition pattern

Define the model schema in Background using fuzzy matchers. Reference it in assertions:

```gherkin
# Definition
* def petModel = { id: '#number', name: '#string', species: '#string', age: '#number' }

# Usage — validate list items
And match each response contains petModel

# Usage — validate single item
And match response contains petModel
```

## Error scenario pattern

```gherkin
@error-path
Scenario: Get non-existent <domain> returns 404
    Given path '/<domain>/99999'
    When method get
    Then status 404
```

## Data-driven pattern (Scenario Outline)

```gherkin
@edge-case
Scenario Outline: Create <domain> with invalid <field> returns 400
    * def request_body = { <field>: '<value>' }
    Given path '/<domain>'
    And request request_body
    When method post
    Then status 400

    Examples:
        | field  | value |
        | name   |       |
        | email  | notanemail |
```

## SOLID principles applied to Karate

| Principle | Application |
|---|---|
| **S** — Single Responsibility | One `.feature` per domain/resource |
| **O** — Open/Closed | Extend via new `Scenario`, never modify existing passing scenarios |
| **L** — Liskov | Shared schemas reusable across any scenario via `def` |
| **I** — Interface Segregation | `Background` exposes only what that feature needs |
| **D** — Dependency Inversion | Config values via `karate-config.js`, never hardcoded |

## Clean Code checklist before creating

- [ ] Domain name is lowercase, singular noun (e.g. `pet`, `order`)
- [ ] File path follows `examples/<domain>/<domain>.feature`
- [ ] Runner package matches `examples.<domain>`
- [ ] Model schema covers all fields returned by the API
- [ ] Every scenario has a descriptive name in plain English
- [ ] No scenario exceeds 10 steps — split if needed
- [ ] Tags applied: `@smoke` for critical, `@regression` for full coverage
- [ ] `Background` has no steps that only one scenario needs

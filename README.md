# Karate Training

API test automation project built with [Karate DSL](https://github.com/karatelabs/karate) (v1.5.0) and JUnit 5.

## Project Structure

```
src/
└── test/
    └── java/
        ├── karate-config.js              # Global config — loads env vars, sets baseUrl, apiKey
        ├── logback-test.xml              # Logging configuration
        └── features/
            ├── FeaturesTest.java         # Parallel runner — entry point for all features
            └── users/
                ├── UsersRunner.java      # JUnit 5 runner for the users domain
                ├── getUser.feature       # GET /users — list and retrieve users
                ├── createUser.feature    # POST /users — create a user
                ├── updateUser.feature    # PUT /users/{id} — full update
                ├── patchUser.feature     # PATCH /users/{id} — partial update
                └── deleteUser.feature    # DELETE /users/{id} — delete a user
```

## Prerequisites

- Java 17+
- Maven 3.8+

## Setup

1. Clone the repository
2. Copy the environment variables template and fill in your values:
   ```bash
   cp .env.example .env
   ```
3. Edit `.env` with your credentials:
   ```
   API_KEY=your_api_key_here
   ```

## Running Tests

```bash
# Run all tests in parallel (5 threads)
mvn clean test

# Run only the users domain via its runner
mvn test -Dtest=UsersRunner

# Run with a specific environment
mvn test -Dkarate.env=e2e

# Run only @smoke scenarios
mvn test -Dkarate.options="--tags @smoke"

# Run only @regression scenarios
mvn test -Dkarate.options="--tags @regression"
```

## Test Tags

| Tag | Purpose |
|---|---|
| `@smoke` | Critical happy-path scenarios — run on every build |
| `@regression` | Full coverage — run before releases |

## Writing Tests

Tests are written in [Gherkin](https://cucumber.io/docs/gherkin/) syntax using Karate's DSL.
One `.feature` file per HTTP verb / operation. Shared setup lives in `Background`.

### Feature File Example

```gherkin
Feature: Get Users

    Background:
        * url baseUrl
        * def userModel = { id: '#number', name: '#string', email: '#string' }

    @smoke
    Scenario: Get a single user
        Given path 'users/1'
        When method get
        Then status 200
        And match response contains userModel

    @regression
    Scenario Outline: Verify user emails
        Given path 'users', <id>
        When method get
        Then status 200
        And match response.email == '<email>'

        Examples:
        | id | email             |
        | 1  | Sincere@april.biz |
        | 2  | Shanna@melissa.tv |
```

### Karate Fuzzy Matchers

| Matcher | Description |
|---|---|
| `'#number'` | Any numeric value |
| `'#string'` | Any string value |
| `'#boolean'` | Any boolean value |
| `'#notnull'` | Not null |
| `'#null'` | Null |
| `'#ignore'` | Skip this field |
| `'#[n]'` | Array of exactly `n` items |
| `'#array'` | Any array |
| `'#regex ...'` | Regex match |

### Key DSL Keywords

| Keyword | Description |
|---|---|
| `Given` | Set up the request (path, headers, body) |
| `When` | Execute the HTTP method (`get`, `post`, `put`, `patch`, `delete`) |
| `Then` | Assert the response status or body |
| `And` | Chain additional steps |
| `* def` | Define a variable or schema |
| `* match` | Assert a value or structure |

## Environment Variables

API keys and secrets are loaded from a `.env` file (never committed to version control).

| Variable | Description |
|---|---|
| `API_KEY` | API key for authenticated requests |

Configuration is managed in `karate-config.js`, which loads variables with this priority:
1. System environment variables
2. `.env` file
3. Default fallback value

## Security

- Never hardcode secrets in `.feature` files
- The `.env` file is listed in `.gitignore` — use `.env.example` as a template for sharing required variables


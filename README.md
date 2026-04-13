# Karate Training

API test automation project built with [Karate](https://github.com/karatelabs/karate) and JUnit 5.

## Project Structure

```
src/
└── test/
    └── java/
        ├── karate-config.js          # Global configuration and environment variables
        ├── logback-test.xml           # Logging configuration
        └── examples/
            └── users/
                ├── users.feature      # User API test scenarios
                └── UsersRunner.java   # JUnit 5 test runner
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
mvn clean test
```

## Writing Tests

Tests are written in [Gherkin](https://cucumber.io/docs/gherkin/) syntax using Karate's DSL.

### Feature File Example

```gherkin
Feature: Users

    Background:
        * url 'https://reqres.in'
        * header x-api-key = apiKey

    Scenario: Get All Users
        Given path '/api/users?page=2'
        When method get
        Then status 200

    Scenario: Create a user
        * def create_user_request =
        """
        {
            "email": "eve.holt@reqres.in",
            "password": "pistol"
        }
        """
        Given path '/api/register'
        And request create_user_request
        When method post
        Then status 200
        And match response.id == '#notnull'
```

### Key Karate DSL Keywords

| Keyword | Description |
|---|---|
| `Given` | Set up the request (path, headers, body) |
| `When` | Execute the HTTP method (`get`, `post`, `put`, `delete`) |
| `Then` | Assert the response status or body |
| `And` | Chain additional steps |
| `* def` | Define a variable |
| `* match` | Assert a value or pattern |

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

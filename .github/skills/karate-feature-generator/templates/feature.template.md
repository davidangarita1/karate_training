# Feature File Template

Use this template as a structural reference when generating `.feature` files.
Replace `<domain>`, `<Domain>`, `<resource-path>`, and model fields with actual values.

---

```gherkin
Feature: <Domain>

    Background:
        * url baseUrl
        * header x-api-key = apiKey
        * def <domain>Model = { id: '#number', name: '#string' }

    @smoke @regression
    Scenario: List all <domain>s
        Given path '/<resource-path>'
        When method get
        Then status 200
        And match response == '#[] <domain>Model'

    @smoke @regression
    Scenario: Get a single <domain> by id
        Given path '/<resource-path>/1'
        When method get
        Then status 200
        And match response contains <domain>Model

    @error-path
    Scenario: Get a non-existent <domain> returns 404
        Given path '/<resource-path>/99999'
        When method get
        Then status 404

    @smoke @regression
    Scenario: Create a <domain>
        * def request_body =
        """
        {
            "name": "Test <Domain>"
        }
        """
        Given path '/<resource-path>'
        And request request_body
        When method post
        Then status 201
        And match response contains { id: '#number', name: 'Test <Domain>' }

    @error-path
    Scenario Outline: Create <domain> with invalid fields returns 400
        * def request_body = { name: '<name>' }
        Given path '/<resource-path>'
        And request request_body
        When method post
        Then status 400

        Examples:
            | name |
            |      |

    @regression
    Scenario: Replace a <domain>
        * def request_body =
        """
        {
            "id": 1,
            "name": "Updated <Domain>"
        }
        """
        Given path '/<resource-path>/1'
        And request request_body
        When method put
        Then status 200
        And match response contains { name: 'Updated <Domain>' }

    @regression
    Scenario: Partially update a <domain>
        * def request_body =
        """
        {
            "name": "Patched <Domain>"
        }
        """
        Given path '/<resource-path>/1'
        And request request_body
        When method patch
        Then status 200
        And match response contains { name: 'Patched <Domain>' }

    @regression
    Scenario: Delete a <domain>
        Given path '/<resource-path>/1'
        When method delete
        Then status 200
```

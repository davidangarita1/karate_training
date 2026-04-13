Feature: Create User

    Background:
        * url baseUrl
        * path 'users'
        * def userModel = { id: '#number', name: '#string', email: '#string' }

    @smoke
    Scenario: Create a new user
        Given request { "name": "John Doe", "email": "john.doe@example.com" }
        When method post
        Then status 201
        And match response contains userModel
        And match response.name == 'John Doe'
        And match response.email == 'john.doe@example.com'
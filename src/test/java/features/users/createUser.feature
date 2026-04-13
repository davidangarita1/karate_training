Feature: Create User

    Background:
        * url baseUrl
        * path 'users'

    @create_successful_user
    Scenario: Create a new user
        Given request { "name": "John Doe", "email": "john.doe@example.com" }
        When method post
        Then status 201
        And match response contains { id: '#number', name: '#string', email: '#string' }
        * def userId = response.id
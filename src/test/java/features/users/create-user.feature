Feature: Create User

    Background:
        * url baseUrl
        * path '/users'

    Scenario: Create a new user
        * def create_user_request = 
        """
        {
            "name": "John Doe",
            "email": "john.doe@example.com"
        }
        """
        Given request create_user_request
        When method post
        Then status 201
        And match response contains { id: '#number', name: '#string', email: '#string' }
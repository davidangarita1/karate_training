Feature: Create User

    Background:
        * url baseUrl

    Scenario: Create a new user
        * def create_user_request = 
        """
        {
            "name": "John Doe",
            "email": "john.doe@example.com"
        }
        """
        Given path '/users'
        And request create_user_request
        When method post
        Then status 201
        And match response contains { id: '#number', name: 'John Doe', email: 'john.doe@example.com' }
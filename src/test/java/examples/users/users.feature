Feature: Users

    Background:
        * url 'https://jsonplaceholder.typicode.com'
        * def userModel = { id: '#number', name: '#string', email: '#string' }

    Scenario: List all users
        Given path '/users'
        When method get
        Then status 200
        And match response == '#[10]'
        And match each response contains userModel

    Scenario: Get a single user
        Given path '/users/1'
        When method get
        Then status 200
        And match response contains userModel
        And match response.name == 'Leanne Graham'
        And match response.address.city == '#string'

    Scenario: Create a user
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

    Scenario: Update a user
        * def update_user_request =
        """
        {
            "id": 1,
            "name": "Leanne Graham Updated",
            "email": "leanne.updated@example.com"
        }
        """
        Given path '/users/1'
        And request update_user_request
        When method put
        Then status 200
        And match response contains { id: 1, name: 'Leanne Graham Updated', email: 'leanne.updated@example.com' }

    Scenario: Partially update a user
        * def patch_user_request =
        """
        {
            "name": "Leanne Graham Patched"
        }
        """
        Given path '/users/1'
        And request patch_user_request
        When method patch
        Then status 200
        And match response contains { name: 'Leanne Graham Patched' }

    Scenario: Delete a user
        Given path '/users/1'
        When method delete
        Then status 200
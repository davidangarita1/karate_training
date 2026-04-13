Feature: Update User

    Background:
        * url baseUrl

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

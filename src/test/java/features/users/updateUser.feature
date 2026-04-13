Feature: Update User

    Background:
        * url baseUrl
        * path 'users/1'

    Scenario: Update a user
        Given request { "id": 1, "name": "Leanne Graham Updated", "email": "leanne.updated@example.com" }
        When method put
        Then status 200
        And match response contains { id: 1, name: 'Leanne Graham Updated', email: 'leanne.updated@example.com' }

    Scenario: Partially update a user
        Given request { "name": "Leanne Graham Patched" }
        When method patch
        Then status 200
        And match response contains { name: 'Leanne Graham Patched' }

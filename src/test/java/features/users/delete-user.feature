Feature: Delete User

    Background:
        * url baseUrl

    Scenario: Delete a user
        Given path '/users/1'
        When method delete
        Then status 200

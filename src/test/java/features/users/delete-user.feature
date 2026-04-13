Feature: Delete User

    Background:
        * url baseUrl
        * path 'users'

    Scenario: Delete a user
        Given path '1'
        When method delete
        Then status 200

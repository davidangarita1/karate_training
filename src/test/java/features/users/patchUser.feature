Feature: Patch User

    Background:
        * url baseUrl
        * path 'users/1'

    @smoke
    Scenario: Partially update a user
        Given request { "name": "Leanne Graham Patched" }
        When method patch
        Then status 200
        And match response contains { name: 'Leanne Graham Patched' }

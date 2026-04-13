Feature: Patch User

    Background:
        * url baseUrl

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

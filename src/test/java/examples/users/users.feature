Feature: Users

    Background:
        * url 'https://reqres.in'
        * header x-api-key = 'reqres_521a922aab1c42d7b55e6d75f1ccb1f6'

    Scenario: Get All Users
        Given path '/api/users?page=2'
        When method get
        Then status 200

    Scenario: Create a user
        * def create_user_request = 
        """
        {
            "email": "eve.holt@reqres.in",
            "password": "pistol"
        }
        """
        Given path '/api/register'
        And request create_user_request
        When method post
        Then status 200
                
        And match response.id == '#notnull'
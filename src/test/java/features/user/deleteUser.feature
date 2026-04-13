Feature: Delete User

    Background:
        * url baseUrl
        * def account = call read('createUser.feature')

    @smoke
    Scenario: Delete an existing user account
        Given path 'api/deleteAccount'
        And form field email = account.email
        And form field password = account.password
        When method delete
        Then status 200
        And match response == { responseCode: 200, message: 'Account deleted!' }

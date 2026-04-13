Feature: Get Users

    Background:
        * url baseUrl
        * def userModel = { id: '#number', name: '#string', email: '#string' }

    @regression
    Scenario: List all users
        Given path 'users'
        When method get
        Then status 200
        And match response == '#[10]'
        And match each response contains userModel

    @smoke
    Scenario: Get a single user
        Given path 'users/1'
        When method get
        Then status 200
        And match response contains userModel
        And match response.name == 'Leanne Graham'
        And match response.address.city == '#string'

    @regression
    Scenario Outline: Verify user emails
        Given path 'users', <id>
        When method get
        Then status 200
        And match response.email == '<email>'

        Examples:
        | id | email              |
        | 1  | Sincere@april.biz  |
        | 2  | Shanna@melissa.tv  |
        | 3  | Nathan@yesenia.net |
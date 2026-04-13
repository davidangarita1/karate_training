Feature: Get User

    Background:
        * url baseUrl
        * def account = call read('createUser.feature')
        * def userModel = { id: '#number', name: '#string', email: '#string', title: '#string', birth_day: '#string', birth_month: '#string', birth_year: '#string', first_name: '#string', last_name: '#string', company: '#string', address1: '#string', address2: '#string', country: '#string', state: '#string', city: '#string', zipcode: '#string' }

    @smoke
    Scenario: Get user account detail by email
        Given path 'api/getUserDetailByEmail'
        And param email = account.email
        When method get
        Then status 200
        And match response.responseCode == 200
        And match response.user contains userModel
        And match response.user.email == account.email
        And match response.user.name == 'New Karate User'

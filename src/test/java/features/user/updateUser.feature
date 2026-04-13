Feature: Update User

    Background:
        * url baseUrl
        * def account = call read('createUser.feature')

    @smoke
    Scenario: Update an existing user account
        * def formData =
        """
        {
            "name": "Karate Updated User",
            "email": "#(account.email)",
            "password": "#(account.password)",
            "title": "Mrs",
            "birth_date": "15",
            "birth_month": "6",
            "birth_year": "1995",
            "firstname": "Updated",
            "lastname": "Tester",
            "company": "Karate Corp",
            "address1": "456 Updated Ave",
            "country": "United States",
            "zipcode": "67890",
            "state": "New York",
            "city": "New York",
            "mobile_number": "9876543210"
        }
        """
        Given path 'api/updateAccount'
        And form fields formData
        When method put
        Then status 200
        And match response == { responseCode: 200, message: 'User updated!' }

Feature: Create User

    Background:
        * url baseUrl

    @smoke
    Scenario: Create a new user account
        * def email = 'karate.create.' + java.util.UUID.randomUUID() + '@test.com'
        * def password = 'Test@1234'
        * def formData =
        """
        {
            "name": "New Karate User",
            "email": "#(email)",
            "password": "#(password)",
            "title": "Mr",
            "birth_date": "10",
            "birth_month": "3",
            "birth_year": "1995",
            "firstname": "New",
            "lastname": "User",
            "company": "Karate Inc",
            "address1": "789 New St",
            "country": "United States",
            "zipcode": "54321",
            "state": "Texas",
            "city": "Houston",
            "mobile_number": "5551234567"
        }
        """
        Given path 'api/createAccount'
        And form fields formData
        When method post
        Then status 200
        And match response == { responseCode: 201, message: 'User created!' }

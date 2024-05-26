Feature: Registro con contraseña segura

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Contraseña menor a 8 caracteres
    Given path 'register'
    And request
    """
    {
        "cc": "1111111111",
        "idType": "pasaporte",
        "firstname": "Esteban",
        "lastname": "Salas",
        "password": "passwor",
        "mail": "esteban.salas@example.com",
        "country": "USA",
        "province": "California",
        "city": "San Francisco",
        "residence": "123 Main St, Apt 4B",
        "phone": "123-456-7890",
        "role": "ROLE_USER",
        "birthdate": "1985-10-15"
    }
    """
    When method POST
    Then status 400
    Then match response[*].defaultMessage contains 'Password must be at least 8 characters long'
    Then match response[*].defaultMessage contains "Password must contain at least one digit, one lowercase letter, one uppercase letter, one symbol, and cannot contain #='$;%"

  Scenario: Contraseña mayor a 8 caracteres sin caracteres especiales
    Given path 'register'
    And request
    """
    {
        "cc": "1111111111",
        "idType": "pasaporte",
        "firstname": "Esteban",
        "lastname": "Salas",
        "password": "password",
        "mail": "esteban.salas@example.com",
        "country": "USA",
        "province": "California",
        "city": "San Francisco",
        "residence": "123 Main St, Apt 4B",
        "phone": "123-456-7890",
        "role": "ROLE_USER",
        "birthdate": "1985-10-15"
    }
    """
    When method POST
    Then status 400
    Then match response[*].defaultMessage contains "Password must contain at least one digit, one lowercase letter, one uppercase letter, one symbol, and cannot contain #='$;%"

  Scenario: Contraseña segura
    Given path 'register'
    And request
    """
    {
        "cc": "1111111111",
        "idType": "pasaporte",
        "firstname": "Esteban",
        "lastname": "Salas",
        "password": "Password1!",
        "mail": "esteban.salas@example.com",
        "country": "USA",
        "province": "California",
        "city": "San Francisco",
        "residence": "123 Main St, Apt 4B",
        "phone": "123-456-7890",
        "role": "ROLE_USER",
        "birthdate": "1985-10-15"
    }
    """
    When method POST
    Then status 400
    Then match response == 'Registration failed: Person with email esteban.salas@example.com already exists'



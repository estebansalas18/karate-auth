Feature: Registro con documento correcto

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Identificación vacia    
    Given path 'register'
    And request
    """
    {
        "cc": "",
        "idType": "passport",
        "firstname": "Esteban",
        "lastname": "Salas",
        "password": "Aj_H|u4{p85v/!{3+kp",
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
    Then match response[*].defaultMessage contains 'CC must be 10 digits'
    Then match response[*].defaultMessage contains 'CC (Cédula) is required'

  Scenario: Identificación menor a 4 caracteres
    Given path 'register'
    And request
    """
    {
        "cc": "1111",
        "idType": "passport",
        "firstname": "Esteban",
        "lastname": "Salas",
        "password": "Aj_H|u4{p85v/!{3+kp",
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
    Then match response[*].defaultMessage contains 'CC must be 10 digits'
    
  Scenario: Identificación mayor a 10 caracteres
    Given path 'register'
    And request
    """
    {
        "cc": "11111111111",
        "idType": "passport",
        "firstname": "Esteban",
        "lastname": "Salas",
        "password": "Aj_H|u4{p85v/!{3+kp",
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
    Then match response[*].defaultMessage contains 'CC must be 10 digits'

  Scenario: Identificación correcta
    Given path 'register'
    And request
    """
    {
        "cc": "1111111111",
        "idType": "passport",
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

  
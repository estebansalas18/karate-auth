Feature: Registro con nombre correcto

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Nombre vacio 
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "",
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
    Then match response[*].defaultMessage contains 'First name is required'

  Scenario: Nombre con caracteres especiales 
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "1234",
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
    Then match response[*].defaultMessage contains 'First name must contain only letters'
  
  Scenario: Nombre correcto
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


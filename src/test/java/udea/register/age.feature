Feature: Registro con edad correcta

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Fecha de nacimiento vacia
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
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
    Then match response[*].defaultMessage contains 'Birthdate must not be empty'

  Scenario: Fecha de nacimiento invalida - menor a 18 años 
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "Esteban",
    "lastname": "1234",
    "password": "Aj_H|u4{p85v/!{3+kp",
    "mail": "esteban.salas@example.com",
    "country": "USA",
    "province": "California",
    "city": "San Francisco",
    "residence": "123 Main St, Apt 4B",
    "phone": "123-456-7890",
    "role": "ROLE_USER",
    "birthdate": "2010-10-15"
    }
    """
    When method POST
    Then status 400
    Then match response[*].defaultMessage contains 'Birthdate must be at least 18 years old'
  Scenario: Fecha de nacimiento invalida - mayor a la fecha actual
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "Esteban",
    "lastname": "1234",
    "password": "Aj_H|u4{p85v/!{3+kp",
    "mail": "esteban.salas@example.com",
    "country": "USA",
    "province": "California",
    "city": "San Francisco",
    "residence": "123 Main St, Apt 4B",
    "phone": "123-456-7890",
    "role": "ROLE_USER",
    "birthdate": "2030-10-15"
    }
    """
    When method POST
    Then status 400
    Then match response[*].defaultMessage contains 'Birthdate must be at most the current date minus 18 years'

  Scenario: Fecha de nacimiento correcta
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


Feature: Registro con tipo de documento correcto

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Tipo de identificación vacio    
    Given path 'register'
    And request
    """
    {
      "cc": "1111111111",
      "idType": "",
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
    Then match response[*].defaultMessage contains 'ID type is required'
  Scenario: Tipo de identificación "hola"  
    Given path 'register'
    And request
    """
    {
      "cc": "1111111111",
      "idType": "hola",
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
    Then match response[*].defaultMessage contains 'ID type must be cedula or pasaporte'
    
  Scenario: Tipo de dentificación correcto
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


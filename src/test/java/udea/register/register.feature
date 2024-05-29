Feature: Registro de usuario en la aplicación

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Identificación vacia    
    Given path 'register'
    And request
    """
    {
        "cc": "",
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
    Then match response[*].defaultMessage contains 'CC must be 10 digits'
    Then match response[*].defaultMessage contains 'CC (Cédula) is required'

  Scenario: Identificación menor a 4 caracteres
    Given path 'register'
    And request
    """
    {
        "cc": "1111",
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
    Then match response[*].defaultMessage contains 'CC must be 10 digits'
    
  Scenario: Identificación mayor a 10 caracteres
    Given path 'register'
    And request
    """
    {
        "cc": "11111111111",
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
    Then match response[*].defaultMessage contains 'CC must be 10 digits'

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

  Scenario: Apellido vacio 
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "Esteban",
    "lastname": "",
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
    Then match response[*].defaultMessage contains 'Last name is required'

  Scenario: Apellido con caracteres especiales 
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
    "birthdate": "1985-10-15"
    }
    """
    When method POST
    Then status 400
    Then match response[*].defaultMessage contains 'Last name must contain only letters'

  Scenario: Email vacio 
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "Esteban",
    "lastname": "Salas",
    "password": "Aj_H|u4{p85v/!{3+kp",
    "mail": "",
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
    Then match response[*].defaultMessage contains 'Email should not be empty'

  Scenario: Email sin dominio @dominio.com
    Given path 'register'
    And request
    """
    {
    "cc": "1111111111",
    "idType": "pasaporte",
    "firstname": "Esteban",
    "lastname": "Salas",
    "password": "Aj_H|u4{p85v/!{3+kp",
    "mail": "esteban.salas",
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
    Then match response[*].defaultMessage contains 'Email should be valid'
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

  Scenario: Todos los datos diligenciados correctamente
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
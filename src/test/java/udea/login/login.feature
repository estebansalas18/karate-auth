Feature: Iniciar sesión con correo y contraseña

  Background:
    * url 'https://codefact.udea.edu.co/modulo-01/public/api/auth/'
  Scenario: Logear un usuario con credenciales correctas      
    Given path 'login'
    And request
    """
    {
    "username": "john.doe@example.com",
    "password": "Aj_H|u4{p85v/!{3+kp"
    }
    """
    When method POST
    Then status 200

  Scenario: Logear un usuario con credenciales incorrectas      
    Given path 'login'
    And request
    """
    {
    "username": "john.doe@example.com",
    "password": "password"
    }
    """
    When method POST
    Then status 401
    Then match response == 'Login failed: Bad credentials'
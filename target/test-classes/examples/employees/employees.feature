Feature: gestion des employees



@getAllEmployees
Scenario: get all employees
    * url "https://api.efi-academy.com"
    Given path "public/employees"
    When method get
    Then status 200



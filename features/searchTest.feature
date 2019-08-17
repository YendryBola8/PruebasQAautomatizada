Feature: Site Search for PRUEBAS

  Scenario Outline:
    Given Open Chrome
    When We navigate to the homepage google
    When We write the word "<incorrectword>"
    Then Validate that the correct word is loaded "<correctword>"
    And Click on the correct word pruebas
    And Get the list of results
    Then validate that the number of results is greater than "<numberresults>"
    Examples:
      |incorrectword  | correctword   |numberresults  |
      |incorrectword  | incorrect word|5              |
      |pruebaz        | pruebas       |6              |
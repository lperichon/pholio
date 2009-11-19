Feature: Manage Photos
  In order to make a portfolio site
  As a photographer
  I want to create and manage photos

  Scenario: Photo List
    Given I have photos named photo1.jpg, photo2.jpg
    When I go to the list of photos
    Then I should see image "photo1.jpg"
    And I should see image "photo2.jpg"



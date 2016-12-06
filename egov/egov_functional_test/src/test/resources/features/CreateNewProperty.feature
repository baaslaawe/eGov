Feature: Create New Property

  As a register user of the system
  I want to be able to create a new property
  So that the property records are up to date.


  @Sanity
  Scenario Outline: Registered user creating a new property in the system
    Given juniorAssistant logs in

    When he chooses to create new property
    And he enters property header details as <propertyHeaderDetails>

    And he enters owner details for the first owner as <ownerDetails>
    And he enters property address details as <propertyAddressDetails>
    And he enters assessment details as <assessmentDetails>


    And he enters amenities as <amenitiesDetails>
    And he enters construction type details as <constructionTypeDetails>
    And he enters floor details as <floorDetails>
    And he forwards for approval to billCollector
    Then property details get saved successfully

    And current user closes acknowledgement
    And current user logs out

    When billCollector logs in
    And chooses to act upon the above application
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And chooses to act upon the above application
    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And chooses to act upon the above application
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And chooses to act upon the above application
    And he approved the property with remarks "property approved"
    And current user closes acknowledgement

    And chooses to act upon the above assessment
    And he does a digital signature
#
    Then he is notified that "Notice Generated Successfully"

    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And chooses to act upon the above assessment
    And he generates a notice

    Examples:
      | propertyHeaderDetails | ownerDetails | propertyAddressDetails | assessmentDetails     | amenitiesDetails | constructionTypeDetails | floorDetails |
      | residentialPrivate    | bimal        | addressOne             | assessmentNewProperty | all              | defaultConstructionType | firstFloor   |




    Scenario: Registerd user submiting the data screen
      Given admin logs in
      When user chooses to data entry screen
      And user enters the data entry information
      And finally user will submit the application
      And user will see the successfull page and view the details
      And user will close the data entry page
      And current user logs out



#  @Sanity
    Scenario: Registered user create property through data entry screen

    Given superuser logs in
    When he chooses to create data entry
    And he creates a new assessment for a private residential property
      Then dataEntry Details saved successfully

    @Sanity
    Scenario Outline: Registered user Update existing property
#    Given juniorAssistant logs in
#    When he chooses to addition alteration
#      And he searches for assessment with number "1016084436"
#     And he updates assessment details as <editAssessmentDetails>
#      And he enters amenities as <amenitiesDetails>
#      And he enters Construction Details as <ConstructionTypes1>
#      And he enters Floor Details as <editFloorDetails>
#      And he forwards for approval to billCollector
#      Then edit property details get saved successfully
#      And current user logs out

      When billCollector logs in
      And choose to Quick search property by assessmentNumber
      And he forwards for approval to revenueInspector
      And current user closes acknowledgement
      And current user logs out

      When revenueInspector logs in
      And chooses to act upon the above application
      And he forwards for approval to revenueOfficer
      And current user closes acknowledgement
      And current user logs out

      When revenueOfficer logs in
      And chooses to act upon the above application
      And he forwards for approval to commissioner
      And current user closes acknowledgement
      And current user logs out

      When commissioner logs in
      And chooses to act upon the above application
      And he approved the property with remarks "property approved"
      And current user closes acknowledgement

      And chooses to act upon the above assessment
      And he does a digital signature
#
      Then he is notified that "Notice Generated Successfully"

      When commissioner closes acknowledgement
      And current user logs out

      And juniorAssistant logs in
      And chooses to act upon the above assessment
      And he generates a notice



      Examples:
        |  editAssessmentDetails         |     amenitiesDetails |          editFloorDetails |
        |  assessmentAdditionProperty    |        all            |         firstFloorAdditionaltaration|

<<<<<<< HEAD
=======






















>>>>>>> 40482717f06ba1cb28cfc3a7c6d3347aa1d0ac09

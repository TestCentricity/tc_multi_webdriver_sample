@desktop @mobile @regression


Feature: Single user chat
  In order to ensure that users can communicate via online chat
  As a user of the Appium Pro Chat portal
  I expect to be able to create a chat channel and post messages


  Scenario:  Verify Join Channel page is correctly displayed
    Given that user Moose and Squirrel has launched the Appium Pro Chat portal
    Then the Join Channel page is correctly displayed


  Scenario:  Verify Channel Chat page is correctly displayed after creating a channel
    Given that user Moose and Squirrel has created a new channel on the Appium Pro Chat portal
    Then the Channel Chat page is correctly displayed


  Scenario:  Verify users can post messages on a chat channel
    Given that user Moose and Squirrel has created a new channel on the Appium Pro Chat portal
    When user Moose and Squirrel posts a message to the chat channel
    Then all users should see the post in the list of posts

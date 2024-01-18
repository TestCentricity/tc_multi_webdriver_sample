@desktop @mobile @regression


Feature: Three user chat
  In order to ensure that users can communicate via online chat
  As users of the Appium Pro Chat portal
  We expect to be able to create a chat channel and post messages


  Background:
    Given that user Larry has created a new channel on the Appium Pro Chat portal
    And user Curly joins the chat channel
    And user Moe joins the chat channel


  Scenario:  Verify that users can see when other users join the chat channel
    Then user Larry should see that the following users have joined the chat channel:
      |Curly |
      |Moe   |
    And user Curly should see that user Moe has joined the chat channel


  Scenario:  Verify users can post messages and see other's posts on a chat channel
    When user Larry posts a message to the chat channel
    Then all users should see the post in the list of posts
    When user Moe posts a message to the chat channel
    Then all users should see the post in the list of posts
    When user Curly posts a message to the chat channel
    Then all users should see the post in the list of posts

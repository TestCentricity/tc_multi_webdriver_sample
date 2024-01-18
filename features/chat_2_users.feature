@desktop @mobile @regression


Feature: Two user chat
  In order to ensure that users can communicate via online chat
  As users of the Appium Pro Chat portal
  We expect to be able to create a chat channel and post messages


  Background:
    Given that user Peabody has created a new channel on the Appium Pro Chat portal
    And user Sherman joins the chat channel


  Scenario:  Verify that users can see when other users join the chat channel
    Then user Peabody should see that user Sherman has joined the chat channel


  Scenario:  Verify users can post messages and see other's posts on a chat channel
    When user Sherman posts a message to the chat channel
    Then all users should see the post in the list of posts
    When user Peabody posts a message to the chat channel
    Then all users should see the post in the list of posts

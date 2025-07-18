include TestCentricity


Given(/^that user (.*) has launched the Appium Pro Chat portal$/) do |user|
  initiate_chat(user)
end


Given(/^that user (.*) has created a new channel on the Appium Pro Chat portal$/) do |user|
  initiate_chat(user)
  join_channel_page.join_channel(user)
end


Given(/^user (.*) joins the chat channel$/) do |user|
  initiate_chat(user)
  join_channel_page.join_channel(user)
end


Then(/^the (.*) page is correctly displayed$/) do |page_name|
  # find and verify that the specified target page is loaded
  target_page = PageManager.find_page(page_name)
  target_page.verify_page_exists
  # verify that target page is correctly displayed
  target_page.verify_page_ui
end


When(/^user (.*) posts a message to the chat channel$/) do |user|
  WebDriverConnect.activate_driver(user)
  channel_chat_page.send_post(user)
end


Then(/^user (.*) should see that the following users have joined the chat channel:$/) do |user, table|
  WebDriverConnect.activate_driver(user)
  table.raw.each do |joiner|
    channel_chat_page.verify_user_joined(joiner.join)
  end
end


Then(/^user (.*) should see that user (.*) has joined the chat channel$/) do |user1, user2|
  WebDriverConnect.activate_driver(user1)
  channel_chat_page.verify_user_joined(user2)
end


Then(/^all users should see (?:their|the) post in the list of posts$/) do
  $users.each do |user|
    WebDriverConnect.activate_driver(user)
    channel_chat_page.verify_post
  end
end


def initiate_chat(user)
  # add user name to list of users in chat channel
  $users.push(user)
  $users.uniq!
  # get next browser capabilities profile to be used for this user
  browser_config = ENV['BROWSERS'].downcase.to_sym
  browsers = case browser_config
             when :desktop_only
               [:chrome, :firefox, :safari, :edge]
             when :mobile_only
               [:android_phone, :iPhone, :android_tablet, :iPad]
             when :combined
               [:chrome, :android_phone, :iPhone, :android_tablet]
             else
               raise "#{browser_config} is not a supported browser configuration"
             end
  # load browser capabilities for next WebDriver instance
  capabilities.find_capabilities(browsers[WebDriverConnect.num_drivers])
  caps = { driver_name: user }.merge(Capabilities.current.caps)
  # establish connection to target web browser and load Join Channel page
  WebDriverConnect.initialize_web_driver(caps)
  join_channel_page.load_page
end

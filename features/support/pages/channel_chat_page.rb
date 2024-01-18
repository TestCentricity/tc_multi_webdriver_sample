# Page Object class definition for Channel Chat page

class ChannelChatPage < BaseChatPage
  trait(:page_name)    { 'Channel Chat' }
  trait(:page_locator) { 'div.container form#controls' }

  # Channel Chat page UI elements
  label     :channel_label, 'h2[class$="channel"]'
  list      :message_list,  'div#messages'
  textfield :message_field, 'input#sendMessageInput'
  button    :send_button,   'input#sendMessageBtn'

  attr_accessor :message_count

  def initialize
    super
    # define the list item element for the Messages list
    list_elements = { list_item: 'div[class$=" m"]' }
    message_list.define_list_elements(list_elements)
  end

  def verify_page_ui
    super
    ui = {
      channel_label => {
        visible: true,
        caption: ChatData.current.channel
      },
      message_list => {
        visible: true,
        itemcount: 0
      },
      message_field => {
        visible: true,
        enabled: true,
        placeholder: 'Say something',
        value: ''
      },
      send_button => {
        visible: true,
        enabled: true,
        caption: 'Send'
      }
    }
    verify_ui_states(ui)
  end

  def send_post(username)
    # save current message count
    @message_count = message_list.item_count
    # send the new message
    message = ChatData.current.new_message(username)
    message_field.set(message)
    send_button.click
    message_list.wait_until_item_count_changes(4)
    # verify new message was posted and message count was incremented
    ui = {
      message_list => {
        itemcount: @message_count + 1,
        { item: @message_count + 1 } => ["#{username}: #{message}"]
      },
      message_field => { value: '' }
    }
    verify_ui_states(ui)
  end

  def verify_user_joined(username)
    posts = message_list.get_list_items
    unless posts.include?("#{username}: joined the channel")
      raise "Could not verify that user #{username} has joined the channel"
    end
  end

  def verify_post
    posts = message_list.get_list_items
    username = ChatData.current.last_poster
    unless posts.include?("#{username}: #{ChatData.current.last_message}")
      raise "Could not verify that user #{username} has posted a message to the channel"
    end
  end
end

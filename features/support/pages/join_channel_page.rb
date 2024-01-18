# Page Object class definition for Join Channel page

class JoinChannelPage < BaseChatPage
  trait(:page_name)    { 'Join Channel' }
  trait(:page_locator) { 'div.container input#channel' }
  trait(:page_url)     { "#{base_url}/" }

  # Join Channel page UI elements
  labels     channel_label:  'div[class$="formSection"]:nth-of-type(1) > label',
             user_label:     'div[class$="formSection"]:nth-of-type(2) > label'
  textfields channel_field:  'input#channel',
             username_field: 'input#username'
  button     :join_button,   'input#joinChannel'

  def verify_page_ui
    super
    ui = {
      channel_label => {
        visible: true,
        caption: 'Channel to Join'
      },
      user_label => {
        visible: true,
        caption: 'Username'
      },
      channel_field => {
        visible: true,
        enabled: true,
        value: ''
      },
      username_field => {
        visible: true,
        enabled: true,
        value: ''
      },
      join_button => {
        visible: true,
        enabled: true,
        caption: 'Join'
      }
    }
    verify_ui_states(ui)
  end

  def join_channel(username)
    channel_field.set(ChatData.current.channel)
    username_field.set(username)
    join_button.click
    join_button.wait_until_gone(seconds = 5, post_exception = false)
    join_button.click if join_button.visible?
    self.wait_until_gone(5)
  end
end

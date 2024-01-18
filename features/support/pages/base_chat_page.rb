# Page Object class definition for Base Chat page

class BaseChatPage < TestCentricity::PageObject
  # Base Chat page UI elements
  label :title_label, 'h1[class$="title"]'

  def base_url
    "#{Environ.current.protocol}://#{Environ.current.base_url}"
  end

  def verify_page_ui
    # verify page title
    ui = {
      self => {
        exists: true,
        secure: true,
        title: 'Appium Pro Chat'
      },
      title_label => {
        visible: true,
        caption: 'Appium Pro Chat'
      }
    }
    verify_ui_states(ui)
  end
end

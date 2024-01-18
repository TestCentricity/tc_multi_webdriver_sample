module WorldPages
  #
  #  page_objects method returns a hash table of your web app's page objects and associated page classes to be instantiated
  # by the TestCentricity™ PageManager. Page Object class definitions are contained in the features/support/pages folder.
  #
  def page_objects
    {
      join_channel_page: JoinChannelPage,
      channel_chat_page: ChannelChatPage
    }
  end
end


World(WorldPages)

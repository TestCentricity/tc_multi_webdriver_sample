class Chat < TestCentricity::DataSource
  def initialize
    ChatData.current = ChatData.new
  end
end


class ChatData < TestCentricity::DataPresenter
  attribute :channel, String, default: nil
  attribute :last_poster, String, default: nil
  attribute :last_message, String, default: nil

  def initialize(data = nil)
    @channel = "#{Faker::Creature::Animal.name}-#{Time.now.strftime('%Y%m%d%H%M%S')}"
    super
  end

  def new_message(poster)
    @last_poster = poster
    @last_message = Faker::Hipster.sentence
  end
end

require_relative 'recipient'

CHANNEL_BASE_URL = "https://slack.com/api/conversations.list"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details

  end

  def self.list_all
    response = self.get(CHANNEL_BASE_URL, { token: BOT_TOKEN })

    channels_list = response["channels"].map do |channels_hash|
      Channel.new(channels_hash["id"], channels_hash["name"], channels_hash["topic"], channels_hash["num_members"])
    end

    return channels_list
  end

end
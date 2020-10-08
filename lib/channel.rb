require_relative 'recipient'

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(slack_id, name, topic, member_count)
    super(slack_id, name)
    @topic = topic
    @member_count = member_count
  end

  def details
    return "Channel #{@name}'s topic is #{@topic} and has #{@member_count} members. Its ID on Slack is #{@slack_id}."
  end

  def self.list_all
    response = self.get("#{BASE_URL}conversations.list", { token: SLACK_TOKEN })

    channels_list = response["channels"].map do |channels_hash|
      self.new(channels_hash["id"],
               channels_hash["name"],
               channels_hash["topic"]["value"],
               channels_hash["num_members"])
    end

    return channels_list
  end

end
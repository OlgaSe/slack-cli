require_relative 'recipient'

require 'dotenv'

Dotenv.load
BOT_TOKEN = ENV["SLACK_BOT_TOKEN"]
BASE_URL = "https://slack.com/api/conversations.list"

class Channel < Recipient
  attr_reader :topic, :member_count

  def initialize(topic, member_count)
    @topic = topic
    @member_count = member_count
  end

  def details

  end

  def self.list_all
    response = self.get(BASE_URL, { token: BOT_TOKEN })

    channels_array = []
    response["channels"].each do |channels_hash|
      channels_array << Channel.new(channels_hash["topic"],
                             channels_hash["num_members"])
      end
    return channels_array
  end
end
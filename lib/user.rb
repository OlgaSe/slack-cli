require_relative 'recipient'

require 'dotenv'

Dotenv.load
BOT_TOKEN = ENV["SLACK_BOT_TOKEN"]

BASE_URL = "https://slack.com/api/users.list"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(real_name, status_text, status_emoji)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details

  end

  def self.list_all
    response = self.get(BASE_URL, { token: BOT_TOKEN })

    user_array = []
    response["members"].each do |members_hash|
      user_array << User.new(members_hash["profile"]["real_name"],
                             members_hash["profile"]["status_text"],
                             members_hash["profile"]["status_emoji"])
    end

    return user_array
  end

end
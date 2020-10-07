require_relative 'recipient'

USER_BASE_URL = "https://slack.com/api/users.list"

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    "User details => ID: #{@slack_id}, Name: #{@name}, Real Name: #{@real_name}, Status Text: #{@status_text}, Status Emoji: #{@status_emoji}"
  end

  def self.list_all
    response = self.get(USER_BASE_URL, { token: BOT_TOKEN })

    users_list = response["members"].map do |members_hash|
      User.new(members_hash["id"], members_hash["name"], members_hash["profile"]["real_name"], members_hash["profile"]["status_text"], members_hash["profile"]["status_emoji"])
    end

    return users_list
  end

end
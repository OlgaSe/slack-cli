require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize(slack_id, name, real_name, status_text, status_emoji)
    super(slack_id, name)
    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
    return "User #{@name}'s real name is #{@real_name}, and their ID on Slack is #{@slack_id}. Their current status reads: #{@status_text} #{@status_emoji}."
  end

  def self.list_all
    response = self.get("#{BASE_URL}users.list", { token: SLACK_TOKEN })

    users_list = response["members"].map do |members_hash|
      self.new(members_hash["id"],
               members_hash["name"],
               members_hash["profile"]["real_name"],
               members_hash["profile"]["status_text"],
               members_hash["profile"]["status_emoji"])
    end

    return users_list
  end

end
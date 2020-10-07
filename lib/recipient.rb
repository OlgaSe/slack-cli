require 'httparty'
require 'dotenv'

Dotenv.load
BOT_TOKEN = ENV["SLACK_BOT_TOKEN"]

class Recipient
  class SlackApiError < Exception; end

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)

  end

  def self.get(url, params)
    response = HTTParty.get(url, query: params)

    raise SlackApiError, "API call failed with error: #{response["error"]}" if ! response["ok"]
    return response
  end

  def details
    raise NotImplementedError, "Implement me in a child class!"
  end

  def self.list_all
    raise NotImplementedError, "Implement me in a child class!"
  end
end
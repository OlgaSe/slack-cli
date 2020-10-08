require 'httparty'
require 'dotenv'

Dotenv.load
SLACK_TOKEN = ENV["SLACK_TOKEN"]
BASE_URL = "https://slack.com/api/"

class Recipient
  class SlackApiError < Exception; end

  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)
    response = HTTParty.post("#{BASE_URL}chat.postMessage",
                             headers: { 'Content-Type' => 'application/x-www-form-urlencoded' },
                             body: {
                                 token: SLACK_TOKEN,
                                 channel: self.slack_id,
                                 text: message
                             })
    raise SlackApiError, "API call failed with error: #{response["error"]}" if ! response["ok"]

    return response.code == 200 && response.parsed_response["ok"]
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
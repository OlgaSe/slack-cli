require 'httparty'
require 'dotenv'

Dotenv.load
BOT_TOKEN = ENV["SLACK_BOT_TOKEN"]

class Recipient
  attr_reader :slack_id, :name

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)

  end

  def self.get(url, params)
    return HTTParty.get(url, query: params)
  end

  def details
    raise NotImplementedError, "Implement me in a child class!"
  end

  def self.list_all
    raise NotImplementedError, "Implement me in a child class!"
  end
end
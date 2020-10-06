require 'httparty'

class Recipient
  attr_reader :slack_id, :name

  def initialize
    @slack_id = slack_id
    @name = name
  end

  def send_message(message)

  end

  def self.get(url, params)
    return HTTParty.get(url, query: params)
  end

  def details
    raise NotImplementedError
  end

  def self.list_all
    raise NotImplementedError
  end
end
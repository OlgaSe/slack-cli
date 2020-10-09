require 'table_print'

require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def list_users
    tp @users, "slack_id", "name", "real_name", "status_text", "status_emoji"
  end

  def list_channels
    tp @channels, "slack_id", "name", "topic", "member_count"
  end

  def no_recipient
    return @selected.nil?
  end

  def select_user(id_or_name)
    @selected = @users.find { |user| user.slack_id == id_or_name || user.name == id_or_name }

    raise ArgumentError, "User with that name or Slack ID not found." if no_recipient
    return "User #{id_or_name} selected."
  end

  def select_channel(id_or_name)
    @selected = @channels.find { |channel| channel.slack_id == id_or_name || channel.name == id_or_name }

    raise ArgumentError, "Channel with that name or Slack ID not found." if no_recipient
    return "Channel #{id_or_name} selected."
  end

  def show_details
    raise NoMethodError, "No recipient is currently selected." if no_recipient
    return @selected.details
  end

  def send_message(message)
    raise NoMethodError, "No recipient is currently selected." if no_recipient
    @selected.send_message(message)
  end

end

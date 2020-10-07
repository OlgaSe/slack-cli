require 'table_print'

require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels, :selected

  def initialize(selected = nil)
    @users = User.list_all
    @channels = Channel.list_all
    @selected = selected
  end

  def list_users
    tp @users, "slack_id", "name", "real_name", "status_text", "status_emoji"
  end

  def list_channels
    tp @channels, "slack_id", "name", "topic", "member_count"
  end

  def select_user(id_or_name)
    @selected = @users.select { |user| user.slack_id == id_or_name || user.name == id_or_name }
  end

  def select_channel(id_or_name)
    @selected = @channels.select { |channel| channel.slack_id == id_or_name || channel.name == id_or_name }
  end

  def show_details
    # check value of @selected
    # tp select_user(id_or_name), "slack_id", "name", "real_name", "status_text", "status_emoji"
    # tp select_channel(id_or_name), "slack_id", "name", "topic", "member_count"
  end

end

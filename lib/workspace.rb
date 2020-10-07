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

  #replaced select by find, because it returned an array
  def select_user(id_or_name)
    @selected = @users.find { |user| user.slack_id == id_or_name || user.name == id_or_name }
  end

  def select_channel(id_or_name)
    @selected = @channels.find { |channel| channel.slack_id == id_or_name || channel.name == id_or_name }
  end

  def show_details
    puts @selected.details


    # check value of @selected
    # tp select_user(id_or_name), "slack_id", "name", "real_name", "status_text", "status_emoji"
    # tp select_channel(id_or_name), "slack_id", "name", "topic", "member_count"
  end

end

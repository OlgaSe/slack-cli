require 'table_print'

require_relative 'user'
require_relative 'channel'

class Workspace
  attr_reader :users, :channels

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
  end

  def list_users
    tp @users, "slack_id", "name", "real_name", "status_text", "status_emoji"
  end

  def list_channels
    tp @channels, "slack_id", "name", "topic", "member_count"
  end

end

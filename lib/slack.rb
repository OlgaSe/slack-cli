#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'
require_relative 'channel'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  puts "What do you want to do?"
  puts "1. list users\n2. list channels\n3. quit"
  print ">> "

  user_input = gets.chomp.downcase

  until user_input == "quit"
    case user_input
    when "list users"
      workspace.list_users
    when "list channels"
      workspace.list_channels
    else
      puts "Invalid input. Try again."
    end

    print "What do you want to do next? "
    user_input = gets.chomp.downcase
  end

  puts "Thank you for using the Ada Slack CLI"
  exit
end

main if __FILE__ == $PROGRAM_NAME
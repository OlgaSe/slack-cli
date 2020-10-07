#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  puts "What do you want to do?"
  puts "1. list users\n2. list channels\n3. select user\n4. select channel\n5. details\n6. quit"
  print ">> "

  user_input = gets.chomp.downcase

  until user_input == "quit"
    case user_input
    when "list users"
      workspace.list_users
    when "list channels"
      workspace.list_channels
    when "select user"
      print "Enter the user's name or Slack ID: "
      user_input = gets.chomp

      puts workspace.select_user(user_input)
    when "select channel"
      print "Enter the channel's name or Slack ID: "
      user_input = gets.chomp

      puts workspace.select_channel(user_input)
    when "details"
      workspace.show_details
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
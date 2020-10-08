#!/usr/bin/env ruby
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  puts "What do you want to do?"
  puts "1. list users\n2. list channels\n3. select user\n4. select channel\n5. details\n6. send message\n7. quit"
  print ">> "

  user_input = gets.chomp.downcase

  until user_input == "quit" || user_input == "7"
    case user_input
    when "list users", "1"
      workspace.list_users
    when "list channels", "2"
      workspace.list_channels
    when "select user", "3"
      print "Enter the user's name or Slack ID: "
      user_input = gets.chomp

      begin
        puts workspace.select_user(user_input)
      rescue ArgumentError => exception
        puts "#{exception}"
      end
    when "select channel", "4"
      print "Enter the channel's name or Slack ID: "
      user_input = gets.chomp

      begin
        puts workspace.select_channel(user_input)
      rescue ArgumentError => exception
        puts "#{exception}"
      end
    when "details", "5"
      begin
        puts workspace.show_details
      rescue NoMethodError => exception
        puts "#{exception}"
      end
    when "send message", "6"
      print "Enter a message here: >>"
      user_input = gets.chomp
      begin
        puts workspace.send_message(user_input)
      rescue NoMethodError => exception
        puts "#{exception}"
      end
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
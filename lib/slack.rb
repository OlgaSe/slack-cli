#!/usr/bin/env ruby
require_relative 'workspace'
require_relative 'user'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  # TODO project
  puts "What would you like to do?"
  puts "1. list users\n2. list channels\n3. quit"
  print ">> "
  user_input = gets.chomp.downcase

  if user_input == "list users"
    puts User.list_all
  elsif user_input == "list channels"
  elsif user_input == "quit"
    exit
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
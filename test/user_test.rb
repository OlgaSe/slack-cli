require_relative 'test_helper'
require_relative '../lib/user'

describe User do

  it "return a specific values for user's attributes" do
    user = User.new("USLACKBOT", "slackbot", "Slackbot", "","")
    expect(user.details).must_equal "User slackbot's real name is Slackbot, and their ID on Slack is USLACKBOT. Their current status reads:  ."
  end

  it "return an instance array class" do
    VCR.use_cassette("list all") do
      users = User.list_all
      expect(users).must_be_kind_of Array
      expect(users.length).must_equal 2
      # expect(users).must_equal [User.new("U01CQMA06F2", "bak02013", "Beauttie", '', ''), User.new("U01CQMN9XR6", "beauttie_api_project", "Earth - Beauttie - API Project", '', '' )]
    end
  end
end


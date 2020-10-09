require_relative 'test_helper'
require_relative '../lib/user'

describe "User class" do
  before do
    @user = User.new("USLACKBOT", "slackbot", "Slackbot", "away", "happy")
  end

  it "is an instance of User" do
    expect(@user).must_be_kind_of User
  end

  it "is set up for specific attributes and data types" do
    expect(@user).must_respond_to :details
    expect(User).must_respond_to :list_all

    expect(@user.slack_id).must_be_kind_of String
    expect(@user.name).must_be_kind_of String
    expect(@user.real_name).must_be_kind_of String
    expect(@user.status_text).must_be_kind_of String
    expect(@user.status_emoji).must_be_kind_of String
  end

  it "return a specific values for user's attributes" do
    expect(@user.details).must_equal "User slackbot's real name is Slackbot, and their ID on Slack is USLACKBOT. Their current status reads: away happy."
  end

  it "initialized properly sets all properties" do
    expect(@user.slack_id).must_equal "USLACKBOT"
    expect(@user.name).must_equal "slackbot"
    expect(@user.status_text).must_equal "away"
    expect(@user.status_emoji).must_equal "happy"
  end
end

describe "list_all method" do
  it "returns an Array of users" do
    VCR.use_cassette("list users") do
      users = User.list_all

      expect(users).must_be_kind_of Array
      expect(users.all?(User)).must_equal true

      expect(users.length).must_equal 5
      users_details = users.map { |user| user.details }
      expected_details = ["User slackbot's real name is Slackbot, and their ID on Slack is USLACKBOT. Their current status reads:  .",
                          "User eartholgaslackcli's real name is Earth-Olga-SlackCLI, and their ID on Slack is U01BU4T45M4. Their current status reads:  .",
                          "User olga.tka4eva's real name is olga.tka4eva, and their ID on Slack is U01C12E4CF5. Their current status reads: YAy! :+1:.",
                          "User bak02013's real name is Beauttie, and their ID on Slack is U01CQMA06F2. Their current status reads: trying to make my code work :female-technologist:.",
                          "User beauttie_api_project's real name is Earth - Beauttie - API Project, and their ID on Slack is U01CQMN9XR6. Their current status reads:  ."]
      expect(users_details).must_equal expected_details
    end
  end


  describe "details method" do
    before do
      @user = User.new("USLACKBOT", "slackbot", "Slackbot", "away", "happy")
    end

    it "returns a String including specific attributes" do
      user_details = @user.details

      expect(user_details).must_be_kind_of String

      expect(user_details).must_include @user.slack_id
      expect(user_details).must_include @user.name
      expect(user_details).must_include @user.real_name
      expect(user_details).must_include @user.status_text
      expect(user_details).must_include @user.status_emoji
    end
  end
end


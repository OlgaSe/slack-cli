require_relative 'test_helper'
require_relative '../lib/workspace'
require_relative '../lib/recipient'

describe "Workspace class" do

  before do
    VCR.use_cassette("load workspace") do
      @workspace = Workspace.new
    end
  end

  describe "Workspace instantiation" do
    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    it "is set up for specific attributes and data types" do
      [:list_users, :list_channels, :no_recipient, :select_user, :select_channel, :show_details, :send_message].each do |prop|
        expect(@workspace).must_respond_to prop
      end

      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users.all?(User)).must_equal true
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels.all?(Channel)).must_equal true
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "no_recipient method" do
    it "returns a Boolean" do
      expect(@workspace.no_recipient).must_be_kind_of ( TrueClass || FalseClass )
    end
  end

  describe "select_user method" do
    it "stores an instance of User" do
      @workspace.select_user("slackbot")

      expect(@workspace.selected).must_be_kind_of User
    end

    it "raises an error when invalid user is entered" do
      expect {
        @workspace.select_user("beepbop")
      }.must_raise ArgumentError
    end
  end

  describe "select_channel method" do
    it "stores an instance of Channel" do
      @workspace.select_channel("general")

      expect(@workspace.selected).must_be_kind_of Channel
    end

    it "raises an error when invalid channel is entered" do
      expect {
        @workspace.select_channel("beepbop")
      }.must_raise ArgumentError
    end
  end

  describe "show_details method" do
    it "returns a String when user is selected" do
      @workspace.select_user("olga.tka4eva")
      user_details = @workspace.show_details

      expect(user_details).must_be_kind_of String
      expect(user_details).must_equal "User olga.tka4eva's real name is olga.tka4eva, and their ID on Slack is U01C12E4CF5. Their current status reads: YAy! :+1:."
    end

    it "returns a String when user is selected" do
      @workspace.select_channel("testing")
      channel_details = @workspace.show_details

      expect(channel_details).must_be_kind_of String
      expect(channel_details).must_equal "Channel testing's topic is  and has 3 members. Its ID on Slack is C01CQMA6E56."
    end

    it "raises an error when no recipient is selected" do
      expect {
        @workspace.show_details
      }.must_raise NoMethodError
    end
  end

  describe "send_message method" do
    it "sends a message to the testing channel" do
      VCR.use_cassette("send_message") do
        @workspace.select_channel('testing')
        response = @workspace.send_message('This is our first message')

        expect(response).must_equal true
      end
    end

    # it "returns false when channel doesn't exist" do
    #   VCR.use_cassette("negative-cases") do
    #     recipient = Recipient.new("", "")
    #     expect {
    #       recipient.send_message("weird message")
    #     }.must_raise SlackApiError
    #   end
    # end
  end
end
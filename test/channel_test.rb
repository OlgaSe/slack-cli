require_relative 'test_helper'
require_relative '../lib/channel'

describe "Channel class" do
  describe "Channel instantiation" do
    before do
      @channel = Channel.new("C14", "earth-adies", "collaborative space for the Earth classroom", 2)
    end

    it "is an instance of Channel" do
      expect(@channel).must_be_kind_of Channel
    end

    it "is set up for specific attributes and data types" do
      expect(@channel).must_respond_to :details
      expect(Channel).must_respond_to :list_all

      expect(@channel.slack_id).must_be_kind_of String
      expect(@channel.name).must_be_kind_of String
      expect(@channel.topic).must_be_kind_of String
      expect(@channel.member_count).must_be_kind_of Integer
    end
  end

describe "list_all method" do
    it "returns an Array of Channels" do
      VCR.use_cassette("list_channels") do
        channels_list = Channel.list_all

        expect(channels_list).must_be_kind_of Array
        expect(channels_list.all?(Channel)).must_equal true

        expect(channels_list.length).must_equal 4
      end
    end

    it "raises an error when token is not provided" do
      VCR.use_cassette("list_channels") do
        expect{ Channel.get("#{BASE_URL}conversations.list", { token: "" }) }.must_raise SlackApiError
      end
    end
  end

  describe "details method" do
    before do
      @channel = Channel.new("C14", "earth-adies", "collaborative space for the Earth classroom", 2)
    end

    it "returns a String including specific attributes" do
      channel_details = @channel.details

      expect(channel_details).must_be_kind_of String

      expect(channel_details).must_include @channel.slack_id
      expect(channel_details).must_include @channel.name
      expect(channel_details).must_include @channel.topic
      expect(channel_details).must_include @channel.member_count.to_s
    end
 end

end

require_relative 'test_helper'
require_relative '../lib/workspace'

xdescribe "Workspace class" do
  describe "Workspace instantiation" do
    before do
      @workspace = Workspace.new
    end

    it "is an instance of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    it "is set up for specific attributes and data types" do
      [:list_users, :list_channels, :no_recipient, :select_user, :select_channel, :show_details].each do |prop|
        expect(@workspace).must_respond_to prop
      end

      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users.all?(User)).must_equal true
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.users.all?(Channel)).must_equal true
      expect(@workspace.selected).must_be_nil
    end
  end

  describe "no_recipient method" do
    it "returns a Boolean" do
      workspace = Workspace.new

      expect(workspace.no_recipient).must_be_kind_of Boolean
    end
  end

  describe "select_user method" do

  end

  describe "select_channel method" do

  end

  describe "show_details method" do

  end
end
# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  #include Devise::Test::ControllerHelpers

  def setup
   # @request.env["devise.mapping"] = Devise.mappings[:jp][:user]
    #@alice = users(:alice)
  end

  test "AliceはBobをフォローしている" do
    @alice = users(:alice)
    @bob = users(:bob)
    #@alice.follow(@bob)
    assert @alice.following?(@bob)
  end
end

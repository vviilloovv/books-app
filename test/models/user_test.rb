# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test "フォロー中でないユーザーをフォローできる" do
    assert_difference "@bob.followings.count", 1 do
      @bob.follow(@alice)
    end
  end

  test "フォロー中の人を重複フォローしない" do
    assert_no_difference "@alice.followings.count" do
      @alice.follow(@bob)
    end
  end

  test "自分自身はフォローしない" do
    assert_no_difference "@alice.followings.count" do
      @alice.follow(@alice)
    end
  end

  test "フォロー中のユーザーをリムーブできる" do
    assert_difference "@alice.followings.count", -1 do
      @alice.unfollow(@bob)
    end
  end

  test "フォロー中ではないユーザーはリムーブしない" do
    assert_no_difference "@bob.followings.count" do
      @bob.unfollow(@alice)
    end
  end

  test "AliceはBobをフォローしている" do
    assert @alice.following?(@bob)
  end

  test "BobはAliceをフォローしていない" do
    assert_not @bob.following?(@alice)
  end
end

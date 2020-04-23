# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test "ユーザー一覧" do
    sign_in @alice
    visit users_path

    assert_text "Alice"
    assert_text "Bob"
  end

  test "自分の詳細表示" do
    sign_in @alice
    visit @alice

    assert_text "Alice"
    assert_text "Alice in Wonderland"
  end

  test "別のユーザーの詳細表示" do
    sign_in @alice
    visit @bob

    assert_text "Bob"
    assert_text "Bob Book"
  end

  test "Bobをリムーブする" do
    sign_in @alice
    visit users_path
    click_button "フォロー中"

    assert_text "フォロー解除成功"
  end

  test "Aliceをフォローする" do
    sign_in @bob
    visit users_path

    click_button "フォロー"

    assert_text "フォロー成功"
  end
end

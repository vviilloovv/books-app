# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @alice = users(:alice)
    @bob = users(:bob)
  end

  test "ログイン" do
    visit new_user_session_path

    assert_selector "h1", text: "ログイン"

    fill_in "Eメール", with: "alice@example.com"
    fill_in "パスワード", with: "password"
    click_button "Log in"

    assert_selector "h1", text: "本一覧"
    assert_text "ログインしました。"
  end

  test "ユーザー登録" do
    visit new_user_registration_path

    assert_selector "h1", text: "ユーザー登録"

    fill_in "Eメール", with: "charlie@example.com"
    fill_in "パスワード", with: "password"
    fill_in "パスワード（確認用）", with: "password"
    click_button "登録"

    assert_selector "h1", text: "プロフィール"
    assert_text "アカウント登録が完了しました。"
  end

  test "ユーザー一覧" do
    sign_in @alice
    visit users_path

    assert_selector "h1", text: "ユーザー一覧"
    assert_text "Alice"
    assert_text "Bob"
  end

  test "ユーザー詳細表示" do
    sign_in @alice
    visit user_path(@alice)

    assert_selector "h1", text: "プロフィール"
    assert_text "Alice"
    assert_text "Alice in Wonderland"
  end

  test "プロフィール編集" do
    sign_in @alice
    visit edit_user_registration_path

    assert_selector "h1", text: "プロフィール編集"

    fill_in "ユーザー名", with: "朝日のあ"
    fill_in "現在のパスワード", with: "password"
    click_button "更新"

    assert_selector "h1", text: "本一覧"
    assert_text "アカウント情報を変更しました。"
  end

  test "アカウント削除" do
    sign_in @alice
    visit edit_user_registration_path

    accept_alert do
      click_button "アカウント削除"
    end

    assert_selector "h1", text: "ログイン"
    assert_text "アカウントを削除しました。またのご利用をお待ちしております。"
  end

  test "リムーブする" do
    sign_in @alice
    visit users_path
    click_button "フォロー中", match: :first

    assert_selector "h1", text: "ユーザー一覧"
    assert_text "フォロー解除成功"
  end

  test "フォローする" do
    sign_in @bob
    visit users_path

    click_button "フォロー", match: :first

    assert_selector "h1", text: "ユーザー一覧"
    assert_text "フォロー成功"
  end
end

# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  def setup
    @alice = users(:alice)
    @report = reports(:one)
  end

  test "AliceはBobの投稿が一覧に表示される" do
    sign_in @alice
    visit reports_url

    assert_selector "h1", text: "Listing reports"
    assert_text "Alice repo"
    assert_text "Bob repo"
  end

  test "BobはAliceの投稿が一覧に表示されない" do
    sign_in users(:bob)
    visit reports_url

    assert_no_text "Alice repo"
    assert_text "Bob repo"
  end

  test "詳細表示" do
    sign_in @alice
    visit report_path(@report)

    assert_text "Alice repo"
  end

  test "新規作成" do
    sign_in @alice
    visit new_report_path

    fill_in "タイトル", with: "Neo Alice"
    fill_in "内容", with: "Aliceの日報"
    click_button "登録する"

    assert_text "Report was successfully created."
    assert_text "Neo Alice"
    assert_text "Aliceの日報"
  end

  test "更新" do
    sign_in @alice
    visit edit_report_path(@report)

    fill_in "タイトル", with: "update Alice"
    fill_in "内容", with: "更新された日報"
    click_button "更新する"

    assert_text "Report was successfully updated."
  end

  test "削除" do
    sign_in @alice
    visit reports_url
    accept_alert do
      click_on "Destroy", match: :first
    end

    assert_text "Report was successfully destroyed."
    assert_no_text "Alice repo"
  end
end


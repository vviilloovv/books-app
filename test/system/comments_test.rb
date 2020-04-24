# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  def setup
    @alice = users(:alice)
    @book_with_comments = books(:one)
    @book_without_comments = books(:two)
    @report_with_comments = reports(:one)
    @report_without_comments = reports(:two)
  end

  test "一覧表示" do
    sign_in @alice
    visit comments_path

    assert_selector "h1", text: "コメント一覧"
    assert_text "Book Alice"
    assert_text "Report Alice"
    assert_no_text "Book Bob"
    assert_no_text "Report Bob"
  end

  test "コメントありのBookにコメントが表示される" do
    sign_in @alice
    visit book_path(@book_with_comments)

    assert_text "Book Alice"
    assert_text "Book Bob"
    assert_no_text "Report Alice"
    assert_no_text "Report Bob"
  end

  test "コメントなしのBookにコメントが表示されない" do
    sign_in @alice
    visit book_path(@book_without_comments)

    assert_no_text "Book Alice"
    assert_no_text "Book Bob"
    assert_no_text "Report Alice"
    assert_no_text "Report Bob"
  end

  test "コメントありのReportにコメントが表示される" do
    sign_in @alice
    visit report_path(@report_with_comments)

    assert_text "Report Alice"
    assert_text "Report Bob"
    assert_no_text "Book Alice"
    assert_no_text "Book Bob"
  end

  test "新規作成" do
    sign_in @alice
    visit book_path(@book_without_comments)

    fill_in "内容", with: "New Comment"
    click_button "登録する"

    assert_selector "h1", text: "本の詳細"
    assert_text "Comment was successfully created."
    assert_text "New Comment"
  end

  test "更新" do
    sign_in @alice
    visit edit_comment_path(comments(:to_book_by_alice))

    assert_selector "h1", text: "コメント編集"

    fill_in "内容", with: "Update Comment"
    click_button "更新する"

    assert_selector "h1", text: "本の詳細"
    assert_text "Comment was successfully updated."
  end

  test "削除" do
    sign_in @alice
    visit book_url(@book_with_comments)
    accept_alert do
      click_on "Destroy", match: :first
    end

    assert_selector "h1", text: "本の詳細"
    assert_text "Comment was successfully destroyed."
    assert_no_text "Book Alice"
    assert_text "Book Bob"
  end
end

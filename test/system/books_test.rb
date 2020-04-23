# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  def setup
    @alice = users(:alice)
    sign_in @alice
    @book = books(:one)
  end

  test "一覧表示" do
    visit books_url

    assert_selector "h1", text: "Listing books"
    assert_text "Alice in Wonderland"
    assert_text "Bob Book"
  end

  test "詳細表示" do
    visit @book

    assert_text "Alice in Wonderland"
  end

  test "新規作成" do
    visit new_book_path

    fill_in "タイトル", with: "Neo Alice"
    fill_in "概要", with: "Memo"
    fill_in "作者", with: "Alice Carroll"
    click_button "登録する"

    assert_text "Book was successfully created."
    assert_text "Neo Alice"
    assert_text "Memo"
    assert_text "Alice Carroll"
  end

  test "更新" do
    visit edit_book_path(@book)

    fill_in "タイトル", with: "不思議の国のアリス"
    fill_in "概要", with: "鏡の国"
    fill_in "作者", with: "ルイス・キャロル"
    click_button "更新する"

    assert_text "Book was successfully updated."
  end

  test "削除" do
    visit books_url
    accept_alert do
      click_on "Destroy", match: :first
    end

    assert_text "Book was successfully destroyed."
    assert_no_text "Alice in Wonderland"
  end
end

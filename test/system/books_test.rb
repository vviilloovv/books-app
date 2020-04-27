# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @alice = users(:alice)
    @book = books(:one)
  end

  test "AliceはBobの投稿が一覧に表示される" do
    sign_in @alice
    visit books_path

    assert_selector "h1", text: "本一覧"
    assert_text "Alice in Wonderland"
    assert_text "Bob Book"
  end

  test "BobはAliceの投稿が一覧に表示されない" do
    sign_in users(:bob)
    visit books_path

    assert_selector "h1", text: "本一覧"
    assert_no_text "Alice in Wonderland"
    assert_text "Bob Book"
  end

  test "詳細表示" do
    sign_in @alice
    visit book_path(@book)

    assert_selector "h1", text: "本の詳細"
    assert_text "Alice in Wonderland"
  end

  test "新規作成" do
    sign_in @alice
    visit new_book_path

    assert_selector "h1", text: "本の新規登録"

    fill_in "タイトル", with: "Neo Alice"
    fill_in "概要", with: "Memo"
    fill_in "作者", with: "Alice Carroll"
    click_button "登録する"

    assert_selector "h1", text: "本の詳細"
    assert_text "Book was successfully created."
    assert_text "Neo Alice"
    assert_text "Memo"
    assert_text "Alice Carroll"
  end

  test "更新" do
    sign_in @alice
    visit edit_book_path(@book)

    assert_selector "h1", text: "本の編集"

    fill_in "タイトル", with: "不思議の国のアリス"
    fill_in "概要", with: "鏡の国"
    fill_in "作者", with: "ルイス・キャロル"
    click_button "更新する"

    assert_selector "h1", text: "本の詳細"
    assert_text "Book was successfully updated."
  end

  test "削除" do
    sign_in @alice
    visit books_path
    accept_alert do
      click_on "Destroy", match: :first
    end

    assert_text "Book was successfully destroyed."
    assert_selector "h1", text: "本一覧"
    assert_no_text "Alice in Wonderland"
  end
end

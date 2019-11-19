# frozen_string_literal: true

require "application_system_test_case"
require "webmock"

class TweetsTest < ApplicationSystemTestCase
  setup do
    @note = notes(:note_1)
  end

  # test "show notes" do
  #   visit notes_url
  #   assert_selector "h1", text: "ノート一覧"
  # end

  test "show tweets" do
    visit notes_url

    p current_url

    url = current_url.to_s
    url.slice!("/notes")

    # p url

    click_on "追加"

    WebMock.enable!
    WebMock.stub_request(:post, "https://api.twitter.com/oauth2/token").
      with(
        body: { "grant_type"=>"client_credentials" },
        headers: {
        "Accept"=>"*/*",
        # "Authorization"=>"Basic dnJhVXhHSU1UcFR0M09KdHJmaTI5ZUxhbTo0QWxTYWU4bktQV09ieHNpV1pGNDBLNk1WeWdLbUJlY09ncnYyM0xTbExaRU1TclVWSg==",
        "Connection"=>"close",
        "Content-Type"=>"application/x-www-form-urlencoded",
        "Host"=>"api.twitter.com",
        "User-Agent"=>"TwitterRubyGem/6.2.0"
        }).
      to_return(status: 200, body: "", headers: {})

    # WebMock.stub_request(:get, "#{url}/api/tweets.json?start_datetime=2019-11-15%2023:59&end_datetime=2019-11-16%2023:59&query=s4na_penguin").to_return(

    # WebMock.stub_request(:get, "#{url}/api/tweets.json").to_return(

    url = url + "/api/tweets.json?start_datetime=2019-11-15%2023:59&end_datetime=2019-11-16%2023:59&query=s4na_penguin"
    p url

    WebMock.stub_request(:get, url).to_return(
      body: File.read("#{Rails.root}/test/fixtures/files/twitter_api_search_response.json"),
      status: 200,
      headers: { "Content-Type" =>  "application/json" })

    # p File.read("#{Rails.root}/test/fixtures/files/twitter_api_search_response.json")
    # Billy.proxy.stub(url).and_return(
    #   # headers: { 'Access-Control-Allow-Origin'  => '*' },
    #   json: File.read("#{Rails.root}/test/fixtures/files/twitter_api_search_response.json"),
    #   # code:    200,
    # )

    # WebMock.disable_net_connect!(allow_localhost: false)
    # WebMock.stub_request(:get, current_url).to_return(
    #   body: File.read("#{Rails.root}/test/fixtures/files/twitter_api_search_response.json"),
    #   status: 200,
    #   headers: { "Content-Type" =>  "application/json" })

    # visit current_url

    # allowed_sites = lambda { |uri|
    #   blacklist.none? { |site| uri.host.include?(site) }
    # }
    # WebMock.disable_net_connect!(allow: allowed_sites)

    # WebMock.allow_net_connect!

    click_on "検索"
    assert_text '"id": 1195372469411958800'

    sleep(100)

    # fill_in "タイトル", with: @note.title
    # fill_in "本文", with: @note.body
    # click_on "登録する"

    # # assert_text "ノートを作成しました"
    # # click_on "一覧へ"
  end

  # test "update note" do
  #   visit notes_url
  #   click_on "編集", match: :first

  #   fill_in "タイトル", with: @note.title
  #   fill_in "本文", with: @note.body
  #   click_on "更新"

  #   assert_text "ノートを更新しました"
  #   click_on "一覧へ"
  # end

  # test "destroy note" do
  #   visit notes_url
  #   page.accept_confirm do
  #     click_on "削除", match: :first
  #   end

  #   assert_text "ノートを削除しました"
  # end
end

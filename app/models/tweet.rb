# frozen_string_literal: true

class Tweet
  def self.all(params)
    @params = params
    set_params

    if Rails.env.test?
      load_file_tweets
    else
      search_tweets
    end

    extract_time_period
    @tweets
  end

  private
    def self.set_params
      @query = @params[:query]
      @start_datetime = Time.strptime(@params[:start_datetime], "%Y-%m-%d %H:%M").to_time
      @end_datetime = Time.strptime(@params[:end_datetime], "%Y-%m-%d %H:%M").to_time
      @end_date = I18n.l(@end_datetime, format: :ymd_hy)
      @since_id = nil
    end

    def self.load_file_tweets
      file_path = "#{Rails.root}/test/fixtures/files/twitter_api_search_response.json"
      result_tweets = open(file_path) do |file|
        JSON.load(file)
      end

      @tweets = []
      result_tweets.each do |tweet|
        result = JSON.parse(tweet.to_json, { symbolize_names: true })
        @tweets.push(result)
      end
    end

    def self.search_tweets
      client = Twitter::REST::Client.new(
        consumer_key: ENV["CONSUMER_KEY"],
        consumer_secret: ENV["CONSUMER_SECRET"])

      result_tweets = client.search(
        @query,
        count: 100,
        result_type: "recent",
        until: @end_date,
        exclude: "retweets",
        since_id: @since_id).to_h

      @tweets = result_tweets[:statuses]
    end

    def self.extract_time_period
      @tweets.select! do |tweet|
        tweet_datetime = Time.parse(tweet[:created_at].to_s)
        (@start_datetime < tweet_datetime) && (@end_datetime > tweet_datetime)
      end
    end
end
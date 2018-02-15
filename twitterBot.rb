#!/usr/bin/env ruby

require 'twitter'
require 'dotenv/load'

if ARGV.any?
  if ARGV.length != 2
    raise StandardError, 'Usage : ./twitterBot.rb [twitter_account] [pattern]'
  end
end

tw_account = ARGV[0].nil? ? 'TBM_TramB' : ARGV[0]
pattern = ARGV[1].nil? ? 'interrompu' : ARGV[1]
filename = "#{tw_account}.data"
query = "from:#{tw_account} #{pattern}"

unless File.readable?(filename)
  File.open(filename, 'w') do |f|
    f.write ''
  end
end

data = nil
File.open(filename, 'r') do |file|
  data = file.gets
end

tweet_id = !data ? nil : data

client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['consumer_key']
  config.consumer_secret = ENV['consumer_secret']
  config.access_token = ENV['access_token']
  config.access_token_secret = ENV['access_token_secret']
end

options = if tweet_id.nil?
            { result_type: 'recent' }
          else
            { result_type: 'recent', since_id: tweet_id }
          end

is_interrupted = false
client.search(query, options).collect.reverse_each do |tweet|
  is_interrupted = true
  tweet_id = tweet.id
  puts "#{tweet.text} #{tweet.created_at} #{tweet.id}"
  client.favorite(tweet.id)
end

latest_interruption_tweet = client.status(tweet_id)
tweet_date = Date.parse(latest_interruption_tweet.created_at.to_s)
date_diff = (Date.today - tweet_date).to_i
message = "#TBMTram #{tw_account} : #{date_diff} jour(s) sans interruption. "

puts "#{message} #{message.length}"
puts "Latest tweet_id : #{tweet_id}"
File.open(filename, 'w') { |file| file.write(tweet_id) }
# If there is an interruption, put tweet url at the end to make a quoted tweet
client.update(message + (is_interrupted ? latest_interruption_tweet.uri : ''))

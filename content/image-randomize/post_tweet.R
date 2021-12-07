# Pretty simple: one package needed!
library(rtweet)

# Create the Twitter token
twitter_token <- create_token(
  app = Sys.getenv("TWITTER_APPNAME"),
  consumer_key = Sys.getenv("TWITTER_KEY"),
  consumer_secret = Sys.getenv("TWITTER_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_SECRET"),
  set_renv = FALSE)

# Get the tweet details. If this file doesn't exist, then the Tweet post
# will error out...which is sloppy error handling, but it works
tweet_details <- readRDS("content/image-randomize/output/tweet_details.rds")

# Post the tweet!
post_tweet(status = paste("My daily diversion: a random picture I took with a",
                          "random number of transformations applied in a random",
                          "order with random settings. Usually hideous or dull,",
                          "but occasionally interesting. Details for this one at:",
                          tweet_details$page_url),
           media = c(tweet_details$orig_img_path, tweet_details$trans_img_path),
           token = twitter_token)

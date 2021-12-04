# Pretty simple: one package needed!
library(rtweet)

# Get the Twitter token
twitter_token <- create_token(
  app = Sys.getenv("TWITTER_APPNAME"),
  consumer_key = Sys.getenv("TWITTER_KEY"),
  consumer_secret = Sys.getenv("TWITTER_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_SECRET"),
  set_renv = FALSE)

# Post the tweet!
post_tweet(status = paste("My daily diversion: a random picture I took with a",
                          "random number of transformations applied in a random",
                          "order with random settings. Usually hideous or dull,",
                          "but occasionally interesting. Details for this one at:",
                          final_url),
           media = c(img_out_path, img_trans_out_path))

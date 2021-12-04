# Pretty simple: one package needed!
library(rtweet)

# Get token values
app = Sys.getenv("TWITTER_APPNAME")
consumer_key = Sys.getenv("TWITTER_KEY")
consumer_secret = Sys.getenv("TWITTER_SECRET")
access_token = Sys.getenv("TWITTER_ACCESS_TOKEN")
access_secret = Sys.getenv("TWITTER_ACCESS_SECRET")

# Create the Twitter token
twitter_token <- create_token(
  app = app,
  consumer_key = consumer_key,
  consumer_secret = consumer_secret,
  access_token = access_token,
  access_secret = access_secret,
  set_renv = TRUE)

# Post the tweet!
post_tweet(status = paste("My daily diversion: a random picture I took with a",
                          "random number of transformations applied in a random",
                          "order with random settings. Usually hideous or dull,",
                          "but occasionally interesting. Details for this one at:",
                          final_url),
           media = c(img_out_path, img_trans_out_path))

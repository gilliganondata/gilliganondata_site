# Pretty simple: one package needed!
library(rtweet)

# Create the Twitter token
twitter_token <- rtweet_bot(
  api_key = Sys.getenv("TWITTER_KEY"),
  api_secret = Sys.getenv("TWITTER_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_SECRET"))

cat("twitter_token created.\n")

# Get the tweet details. If this file doesn't exist, then the Tweet post
# will error out...which is sloppy error handling, but it works
tweet_details <- readRDS("content/image-randomize/output/tweet_details.rds")

cat("Original Image Path:", tweet_details$orig_img_path, "\n")
cat("Transformed Image Path:", tweet_details$trans_img_path, "\n")

# Build the ALT image text
date_taken <- if(tweet_details$date_taken == ""){
  "Date Taken: Not Available\n"
} else {
  paste0("Date Taken: ", tweet_details$date_taken, "\n")
}

image_title <- if(tweet_details$image_title == ""){
  "Description: Not Available\n"
} else {
  paste0("Description: ", tweet_details$image_title, "\n")
}

alt_copy <- paste0(date_taken, image_title)

# Post the tweet!
post_tweet(status = paste("My daily diversion: a random picture I took with a",
                          "random number of transformations applied in a random",
                          "order with random settings. Usually hideous or dull,",
                          "but occasionally interesting. Details for this one at:",
                          tweet_details$page_url),
           media = c(tweet_details$orig_img_path, tweet_details$trans_img_path),
           media_alt_text = c(paste0(alt_copy, "Original Image"), 
                              paste0(alt_copy, "Transformed Image")),
           token = twitter_token)

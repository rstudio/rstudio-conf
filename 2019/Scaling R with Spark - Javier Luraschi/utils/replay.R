replay_tweets <- function(producer, topic = "tweets", last = data.frame(), iters = 1) {
  if (iters <= 0) return(last)
  
  tweets <- readRDS(sprintf("tweets/%03d.rds", min(iters, 20)))
  
  if (nrow(tweets) > 0) {
    tweets_subset <- dplyr::select(
      tweets,
      created_at, screen_name, text, is_retweet, favorite_count, retweet_count, media_url, location
    )
    
    for (idx in 1:nrow(tweets_subset)) {
      cat(".")
      capture.output(rkafka::rkafka.send(producer, topic, "localhost", jsonlite::toJSON(tweets_subset[idx,])))
      Sys.sleep(1)
    }
  }
  
  replay_tweets(producer, topic, tweets, iters - 1)
}

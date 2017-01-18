library(httr)

# OAuth 2 example, lifted from https://github.com/hadley/httr/blob/master/demo/oauth2-github.r

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("rstudio_conf_app",
                   key = Sys.getenv("GITHUB_ID"),
                   secret = Sys.getenv("GITHUB_SECRET")
)
# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp, cache = TRUE)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
rate_limit <- content(req)
rate_limit$resources$core$limit

# See API documentation for all resources, examples

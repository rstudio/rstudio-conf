# Using Web APIs in R
These are example scripts for my "Using web APIs in R" presentation from rstudio::conf(2017).

## Presentation
#### WebAPIsInR.html
Slides from the presentation.

## Scripts
#### omdb.R
Get data from http://www.omdbapi.com/, an open-source movie database.  Explore the GET response; parse it with jsonlite or xml2, depending on the response format.

#### swapi.R
Get data from https://swapi.co/, an open-source Star Wars database.  Explore the GET response, parse with jsonlite, create a function to parse automatically, write a loop to process a paged response.

#### twitter.R
Get data from https://api.twitter.com using httr's convenience functions for OAuth 1.0 authentication.

#### github.R
Get data from https://api.github.com using httr's convenience functions for OAuth 2.0 authentication.

## More resources
#### On APIs and HTTP: 
https://zapier.com/learn/apis/chapter-1-introduction-to-apis/

https://www.ntu.edu.sg/home/ehchua/programming/webprogramming/HTTP_Basics.html

#### On the packages:
`help(package=httr)`

https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html

http://github.com/hadley/httr/tree/master/demo

https://cran.r-project.org/web/packages/jsonlite/vignettes/json-apis.html

https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html

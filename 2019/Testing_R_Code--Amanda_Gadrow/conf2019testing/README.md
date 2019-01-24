# conf2019testing

The goal of conf2019testing is as a set of examples for Amanda Gadrow's talk on writing reliable and maintainable code, from rstudio::conf 2019, January 15-18 2019.

## Installation

This package is not available on CRAN or GitHub, but you can build it locally with `devtools::build()` and`devtools::install()`, or by using the "Install and Restart" button in the Build pane in the RStudio IDE.

``` r
devtools::build()
devtools::install()
```

## Examples

``` r
add_two(4, 21)
hello("french")
goodbye("maori")
uniquify(iris$Species)
```


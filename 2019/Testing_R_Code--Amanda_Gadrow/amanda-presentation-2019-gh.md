Getting It Right
================
Amanda Gadrow
01/17/2019

Data science through code
=========================

Purpose of the code:

-   To answer a question, or make a prediction

-   To make it easier to reproduce and improve analyses

-   To collaborate with others on shared projects

-   To distribute findings easily

-   To distribute useful functions internally or with the community

------------------------------------------------------------------------

Data science through code
=========================

Code is written in the service of analysis

It is a means to an end, but it is also an artifact

------------------------------------------------------------------------

Data science through code
=========================

Characteristics of good code:

-   Reliability

-   Reproducibility

-   Flexibility

-   Longevity

-   Scalability

------------------------------------------------------------------------

Code quality matters
====================

How do we determine the quality of our code?

-   Execution feedback

-   User feedback

-   Measure it with **tests**: functional, integration, performance

------------------------------------------------------------------------

Code quality matters
====================

Measure it with **tests**: functional, integration, performance

Make this part of your regular development cycle for:

-   Faster updates

-   Quick feedback on impact of changes

-   Visibility into internal dependencies

-   Easily trace the function, scope, and meaning of code

------------------------------------------------------------------------

Writing tests
=============

-   **Ideally**, cover all code paths

-   **Practically**, start with the major functions, inputs, and integration points

-   Run manual tests in the console during development

-   Convert them to coded tests when the basic functionality is established

An ounce of prevention is worth a pound of cure.

------------------------------------------------------------------------

`testthat`
==========

``` r
# Install the released version from CRAN
install.packages("testthat")

# Set up test infrastructure:
# Create ‘tests/testthat.R’ and ‘tests/testthat/’, and adding testthat to the suggested packages in the package DESCRIPTION
# install.packages("usethis")
usethis::use_testthat()

# Create a new test file
# Create ‘tests/testthat/test-<name>.R’ and open it for editing
usethis::use_test("name")
```

------------------------------------------------------------------------

An example of a test file from the stringr package:

    context("String length")                            <- context describes the set of tests
    library(stringr)

    test_that("str_length is number of characters", {   <- tests exercise the output of
      expect_equal(str_length("a"), 1)                      a single function with 1+ expectation
      expect_equal(str_length("ab"), 2)
      expect_equal(str_length("abc"), 3)                <- expectations describe the
    })                                                      expected result of a computation

    test_that("str_length of factor is length of level", {
      expect_equal(str_length(factor("a")), 1)
      expect_equal(str_length(factor("ab")), 2)
      expect_equal(str_length(factor("abc")), 3)
    })

    test_that("str_length of missing is missing", {
      expect_equal(str_length(NA), NA_integer_)
      expect_equal(str_length(c(NA, 1)), c(NA, 1))
      expect_equal(str_length("NA"), 2)
    })

------------------------------------------------------------------------

Expectations
============

<img src="images/testthat_ref.png" width="700" height="617" />

------------------------------------------------------------------------

Development workflow
====================

Once you’re set up, the workflow is simple:

1.  Modify your code or tests.

2.  Test your package with Ctrl/Cmd + Shift + T in RStudio, or `devtools::test()` in the console.

3.  Repeat until all tests pass.

------------------------------------------------------------------------

Testing considerations
======================

User experience

-   Expected results for each function
-   Common mistakes or typos

Test coverage

-   External interfaces
-   Fragile code
-   Input types

Test design

-   One test per behavior
-   One test per bug

**hard to test == hard to maintain**

------------------------------------------------------------------------

`shinytest`
===========

``` r
# install.packages("devtools")
library(devtools)
install_github("rstudio/shinytest")
# shinytest::installDependencies()
library(shinytest)

# Record test
recordTest("path/to/app")

# Run test
testApp("path/to/app")           # all tests
testApp("path/to/app", "mytest") # individual test
```

------------------------------------------------------------------------

`shinytest`
===========

`shinytest::recordTest("my_shiny_app")`

<img src="images/shinytest_recordTest.png" width="600" />

------------------------------------------------------------------------

`shinytest`
===========

`shinytest::recordTest("my_shiny_app")`

<img src="images/shinytest_snapshot.png" width="600" />

------------------------------------------------------------------------

`shinytest`
===========

`shinytest::recordTest("my_shiny_app")`

<img src="images/shinytest_record_console.png" width="400" /><img src="images/shinytest_savedtest.png" width="406" />

------------------------------------------------------------------------

`shinytest`
===========

`shinytest::testApp("my_shiny_app", "test_name")`

<img src="images/shinytest_testApp.png" width="526" />

------------------------------------------------------------------------

`shinytest`
===========

`shinytest::testApp("my_shiny_app", "test_name")`

<img src="images/shinytest_diff.png" width="450" />

------------------------------------------------------------------------

Designing for ease of testing
=============================

Good software practices

-   Goals
-   Reliability, Reproducibility, Flexibility, Longevity, Scalability
-   Good user experience
-   High degree of confidence
-   Modular design for ease of testing and maintenance
-   Modular design
-   Decoupling, code isolation
-   DRY: Don't Repeat Yourself
-   KISS: Keep It Simple, Stupid
-   Consistent code style
-   User experience (including Future You)
-   Ease of use
-   Error handling

------------------------------------------------------------------------

Profit!
=======

But remember:

The tests won't **ensure** high quality in your script or application; they just **verify** it when it's there.

------------------------------------------------------------------------

Resources to read/watch:
========================

-   [*R packages*](http://r-pkgs.had.co.nz/package.html) by Hadley Wickham, particularly the chapter on [Testing](http://r-pkgs.had.co.nz/tests.html)
-   [*Advanced R*](http://adv-r.had.co.nz/) by Hadley Wickham, for advice on good software design
-   [Jenny Bryan's video](https://www.youtube.com/watch?v=7oyiPBjLAWY) on ["Code smells and feels"](https://rstd.io/code-smells) from useR!2018
-   Charles Gray's [blog post](http://cantabile.rbind.io/posts/2019-01-05-its-not-not-the-math-its-the-code/) on the benefits of a workflow based on `testthat::auto_test`
-   Winston Chang's [talk on testing shiny apps](https://www.rstudio.com/resources/videos/developing-robust-shiny-apps-with-regression-testing/) with `shinytest` from rstudio::conf(2018)

------------------------------------------------------------------------

Resources for testing packages:
===============================

Unit Tests - [testthat](https://testthat.r-lib.org/) - [usethis](https://usethis.r-lib.org/) - [devtools](https://cran.rstudio.com/web/packages/devtools/index.html) - [testit](https://github.com/yihui/testit) - [testthis](https://cran.rstudio.com/web/packages/testthis/index.html) - [assertive](https://bitbucket.org/richierocks/assertive) - [RUnit](https://cran.rstudio.com/web/packages/RUnit/index.html)

Shiny Tests - [shinytest](https://rstudio.github.io/shinytest/articles/shinytest.html)

Performance Tests - [profvis](https://rstudio.github.io/profvis/) (see also the ["Performance" chapter in *Advanced R*](http://adv-r.had.co.nz/Performance.html)) - [shinyloadtest and shinycannon](https://rstudio.github.io/shinyloadtest/)

Code Coverage - [covr](https://cran.rstudio.com/web/packages/covr/index.html) and [covrpage](https://github.com/metrumresearchgroup/covrpage)

------------------------------------------------------------------------

Next steps
==========

-   Start small, and give it a go
-   Look for opportunities to improve the functional code to be more testable, and therefore, more maintainable
-   Make a habit of running all the tests locally before checking in code
-   If you're not already using source control, see Jenny Bryan's [Happy Git and GitHub for the useR](https://happygitwithr.com/)
-   Add more tests over time
-   Integrate tests into Continuous Integration (CI) pipeline, if applicable
-   Bask in the warm glow of reliability, maintainability, and transparency

------------------------------------------------------------------------

Thank you
=========

Amanda Gadrow

<amanda@rstudio.com>

![](images/ajmcoqui_social_media_sig.png)

Slides and code examples will be available after the conference.

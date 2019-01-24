context("test-print_things")

test_that("hello returns the correct value when language is supported", {
  expect_equal(hello("maori"), "Koa")
  expect_equal(hello("Maine"), "Hihowahya?")
  # expect_equal(hello("French"), "Bonjour")
})

test_that("hello returns nothing when language isn't supported", {
  expect_equal(hello("foo"), NULL)
})

test_that("goodbye returns the correct value when language is supported", {
  expect_equal(goodbye("spanish"), "Adios")
  expect_equal(goodbye("french"), "Au revoir")
  # expect_equal(goodbye("developer"), "Goodbye, world!")
})

context("test-add_things")

test_that("add_two returns the correct value when adding integers", {
  expect_equal(add_two(11, 31), 42)
})

test_that("add_two returns the correct value when adding integers", {
  expect_equal(add_two(31, 11), 42)
})

test_that("add_two returns the correct value when adding numerics", {
  expect_equal(add_two(9.3, 32.7), 42)
})

# test_that("add_two handles string integers", {
#   expect_equal(add_two(11, "31"), 42)
# })
#
# test_that("add_two handles string integers", {
#   expect_error(add_two(11, "31"), "non-numeric argument to binary operator")
# })
#
# test_that("add_two handles string integers", {
#   expect_equal(add_two(11, NULL), 11)
# })

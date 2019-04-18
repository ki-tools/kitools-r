context("test-basic")

test_that("configure", {
  ic <- suppressMessages(is_configured())
  if (!ic)
    kitools_configure()
})

test_that("import kitools", {
  kitools <- reticulate::import("kitools")
})

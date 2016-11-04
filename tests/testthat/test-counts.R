context("Counts")

test_that("Observed taxa matches a known taxa", {
  expect_true(all(insect_counts$taxa %in% insect_guilds$taxa))
})

test_that("Counts are positive", {
  expect_true(all(insect_counts$count>0))
})

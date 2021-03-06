context("assessments")

pkg_tested <- "plyr"

test_that("pkg_assess on a single pkg_ref returns a vctrs_list_of with one element per assessment", {
  a_pkg_ref <- pkg_ref(pkg_tested)
  a_pkg_assess <- pkg_assess(a_pkg_ref)
  assessments <- all_assessments()

  expect_is(a_pkg_assess, "list_of_pkg_metric")
  expect_is(a_pkg_assess, "vctrs_list_of")
  expect_is(a_pkg_assess, "list")

  # Add three to the assessments for package name, version, and pkg_ref type
  expect_length(a_pkg_assess, length(assessments))
})



test_that("pkg_assess on list of pkg_refs returns a tibble with one col per assessment", {
  a_pkg_ref <- pkg_ref(c(pkg_tested, pkg_tested))
  a_pkg_assess <- pkg_assess(a_pkg_ref)
  assessments <- all_assessments()

  expect_is(a_pkg_assess, "tbl_df")
  expect_is(a_pkg_assess, "data.frame")

  # Add three to the assessments for package name, version, and pkg_ref type
  expect_length(a_pkg_assess, length(assessments) + 3)
})



test_that("assess returns the correct classes", {
  a_pkg_ref <- pkg_ref(pkg_tested)
  a_pkg_assess <- pkg_assess(a_pkg_ref)
  expect_is(a_pkg_assess$downloads_1yr, c("pkg_metric_downloads_1yr", "pkg_metric", "numeric"))
  expect_is(a_pkg_assess$license, c("pkg_metric_license", "pkg_metric", "character"))
  expect_is(a_pkg_assess$bugs_status, c("pkg_metric_last_30_bugs_status", "pkg_metric", "logical"))
  expect_is(a_pkg_assess$has_news, c("pkg_metric_has_news", "pkg_metric", "integer"))
  expect_is(a_pkg_assess$has_vignettes, c("pkg_metric_has_vignettes", "pkg_metric", "integer"))
  expect_is(a_pkg_assess$export_help, c("pkg_metric_export_help", "pkg_metric", "logical"))
  expect_is(a_pkg_assess$news_current, c("pkg_metric_news_current", "pkg_metric", "logical"))
})



# I'm thinking something like the below could be done for all assessments
test_that("assess_has_bug_reports_url returns the correct url", {
  a_pkg_ref <- pkg_ref(pkg_tested)
  a_pkg_assess <- pkg_assess(a_pkg_ref)
  expect_is(a_pkg_assess$has_bug_reports_url[[1]], c("pkg_metric_has_bug_reports_url", "pkg_metric", "character"))
  expect_match(a_pkg_assess$has_bug_reports_url[[1]], "https://github.com/hadley/plyr/issues")
})

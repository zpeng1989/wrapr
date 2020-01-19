test_unpack <- function() {

  a <- 'x'
  # name capture version
  into[a, b] <- list(5, 10)
  RUnit::checkEquals(a, 5)
  RUnit::checkEquals(b, 10)

  # into is now in local namespace, 2nd check is also checking that still works

  # bquote re-direct to value in variable
  # plus quotes are allowed
  a <- 'x'
  into[.(a), 'b'] <- list(20, 40)
  RUnit::checkEquals(a, 'x')
  RUnit::checkEquals(x, 20)
  RUnit::checkEquals(b, 40)

  invisible(NULL)
}
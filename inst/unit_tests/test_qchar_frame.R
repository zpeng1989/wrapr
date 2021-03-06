
test_qchar_frame <- function() {

  block_record <- wrapr::qchar_frame(
    "baker"  , "order", "score", "guess" |
      .      , 1    , score_1, guess_1 |
      .      , 2    , score_2, guess_2 |
      .      , 3    , score_3, guess_3 )
  dims <- dim(block_record)
  RUnit::checkEquals(c(3, 4), dims)

  b2 <- wrapr::build_frame(
    "baker"  , "order", "score"  , "guess"   |
      "."    , "1"    , "score_1", "guess_1" |
      "."    , "2"    , "score_2", "guess_2" |
      "."    , "3"    , "score_3", "guess_3" )
  RUnit::checkEquals(block_record, b2)

  invisible(NULL)
}

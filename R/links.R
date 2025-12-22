#' Logit link
#'
#' @param mu Mean parameter in (0,1)
#' @export
logit <- function(mu) log(mu / (1 - mu))

#' Inverse logit link
#'
#' @param eta Linear predictor
#' @export
ilogit <- function(eta) 1 / (1 + exp(-eta))

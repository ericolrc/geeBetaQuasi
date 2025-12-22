#' Working correlation matrix
#'
#' @param Ti Cluster size
#' @param alpha Correlation parameter
#' @param type Correlation structure
#'
#' @export
R_work <- function(Ti, alpha = 0, type = "independence") {

  if (type == "independence") {
    return(diag(Ti))
  }

  if (type == "exchangeable") {
    R <- matrix(alpha, Ti, Ti)
    diag(R) <- 1
    return(R)
  }

  if (type == "ar1") {
    R <- matrix(0, Ti, Ti)
    for (i in 1:Ti)
      for (j in 1:Ti)
        R[i, j] <- alpha^abs(i - j)
    return(R)
  }
}

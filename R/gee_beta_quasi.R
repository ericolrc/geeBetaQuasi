#' Quasi-likelihood GEE for Beta regression
#'
#' Fits a beta regression model for longitudinal data
#' using quasi-likelihood and generalized estimating equations.
#'
#' @param y Response in (0,1)
#' @param X Design matrix
#' @param id Cluster indicator
#' @param link Link function
#' @param corstr Correlation structure
#' @param alpha Working correlation parameter
#' @param maxit Maximum iterations
#' @param tol Convergence tolerance
#'
#' @return A list with estimated coefficients and dispersion
#'
#' @references
#' Liang, K.-Y. and Zeger, S. L. (1986).
#' Longitudinal data analysis using generalized linear models.
#' Biometrika.
#'
#' @export
gee_beta_quasi <- function(y, X, id,
                           link = "logit",
                           corstr = "independence",
                           alpha = 0,
                           maxit = 50,
                           tol = 1e-6) {

  beta <- rep(0, ncol(X))
  ids <- unique(id)
  N <- length(y)

  for (iter in 1:maxit) {

    eta <- as.vector(X %*% beta)
    mu  <- ilogit(eta)

    phi <- sum((y - mu)^2 / (mu * (1 - mu))) / N - 1

    U <- rep(0, length(beta))
    I <- matrix(0, length(beta), length(beta))

    for (i in ids) {

      idx <- which(id == i)

      yi <- y[idx]
      mui <- mu[idx]
      Xi <- X[idx, , drop = FALSE]
      Ti <- length(idx)

      Ai <- diag(mui * (1 - mui) / (1 + phi))
      Di <- diag(mui * (1 - mui)) %*% Xi

      Ri <- R_work(Ti, alpha, corstr)
      Vi <- sqrt(Ai) %*% Ri %*% sqrt(Ai)
      Vi_inv <- solve(Vi)

      U <- U + t(Di) %*% Vi_inv %*% (yi - mui)
      I <- I + t(Di) %*% Vi_inv %*% Di
    }

    beta_new <- beta + solve(I, U)

    if (max(abs(beta_new - beta)) < tol) break
    beta <- beta_new
  }

  list(beta = beta,
       phi = phi,
       iter = iter)
}

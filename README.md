## Installation

You can install the development version of geeBetaQuasi from [GitHub](https://github.com/) with:

``` r
devtools::install_github("ericolrc/geeBetaQuasi", force = TRUE)
library(geeBetaQuasi)
```

## Example

This is a basic example which shows you how to solve a common problem:

```{r example}
library(geeBetaQuasi)
## basic example code

n  <- 1000
Ti <- 5
N  <- n * Ti

id <- rep(1:n, each = Ti)
x  <- runif(N)
X  <- cbind(1, x)

beta_true <- c(-0.5, 2)
eta <- X %*% beta_true
mu  <- ilogit(eta)

phi_true <- 20
y <- rbeta(N, mu * phi_true, (1 - mu) * phi_true)

fit <- gee_beta_quasi(y, X, id,
                      corstr = "exchangeable",
                      alpha = 0.3)
fit

```


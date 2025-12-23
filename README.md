## Core References

This README collects the **main theoretical and applied references** on  
**Quasi-Likelihood (QL)** and **Generalized Estimating Equations (GEE)**, with
emphasis on regression models, longitudinal/correlated data, and non-Gaussian
responses (e.g. Binomial, Poisson, Beta).

## Foundations of Quasi-Likelihood

- **Wedderburn, R. W. M. (1974)**  
  *Quasi-likelihood functions, generalized linear models, and the Gauss–Newton method.*  
  **Biometrika**, 61(3), 439–447.  
  > Seminal paper introducing the quasi-likelihood concept.

- **McCullagh, P. & Nelder, J. A. (1989)**  
  *Generalized Linear Models (2nd ed.).*  
  Chapman & Hall.  
  > Chapters 9–10 provide the canonical treatment of quasi-likelihood in GLMs.

- **Heyde, C. C. (1997)**  
  *Quasi-Likelihood and Its Application.*  
  Springer.  
  > Unified theory and applications of quasi-likelihood.

##  Estimating Functions Framework

- **Godambe, V. P. & Thompson, M. E. (1989)**  
  *Estimating functions.*  
  **Journal of the Royal Statistical Society, Series B**, 51, 393–425.

- **Godambe, V. P. (1991)**  
  *Estimating Functions.*  
  Oxford University Press.  
  > General framework encompassing quasi-likelihood and GEE.


## Generalized Estimating Equations (GEE)

- **Liang, K.-Y. & Zeger, S. L. (1986)**  
  *Longitudinal data analysis using generalized linear models.*  
  **Biometrika**, 73(1), 13–22.  
  > Foundational paper introducing GEE.

- **Zeger, S. L. & Liang, K.-Y. (1986)**  
  *Longitudinal data analysis for discrete and continuous outcomes.*  
  **Biometrics**, 42, 121–130.  
  > Interpretation of marginal models and robustness properties.

- **Diggle, P. J., Heagerty, P., Liang, K.-Y. & Zeger, S. L. (2002)**  
  *Analysis of Longitudinal Data (2nd ed.).*  
  Oxford University Press.  
  > Standard reference for GEE and longitudinal models.


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


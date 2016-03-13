#' Building a model with Top Ten Features
#'
#' This function develops a prediction algorithm based on
#' the Top 10 features in 'x' that are most predictive of 'y'
#'
#' @param x n*p matrix of n observations and p predictors
#' @param y vector of length n representing the response
#' @return a vector of coefficients from the final fitted model with Top 10 features
#' @details
#' This function runs a univariate regression of y on each predictor in x and
#' calculates a p-value indicating the significance of the association. The 10 predictors
#' used for the final model are the ones with the smallest p-values.
#' @seealso \code{lm}
#' @export
#' @importFrom stats lm

topten <- function (x, y) {

  # check number of predictors
  p <- ncol(x)
  if (p < 10) stop("there are less than 10 predictors")

  # estimate pvalues
  pvalues <- numeric(p)
  for (i in seq_len(p)) {
    fit <- lm (y ~ x[, i])
    summ <- summary(fit)
    pvalues[i] <- summ$coefficients[2, 4]
  }

  # keep only 10 smallest pvalues
  ord <- order(pvalues)
  ord <- ord[1:10]

  # apply final model
  x10 <- x[, ord]
  fit <- lm(y ~ x10)

  # returns coefficients
  coef(fit)

}

#' Prediction with Top 10 features
#' This function takes a set of coefficients produced by the \code{topten}\ function
#' and makes a prediction for each of the values provided in the input 'X' matrix.
#'
#' @param X n*10 matrix containing n new observations
#' @param b vector of coefficients obtained from the \code{topten}\ function
#' @return a numeric vectore containing the predicted values
#' @export

predict10 <- function (X, b) {

  # add an intercept to the matrix
  X <- cbind (1, X)

  # returns the prediction vector
  drop(X %*% b)

}

#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'


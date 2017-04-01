#' @title Function \code{grapes}
#' @description Turn a collection of functions into binary operators. For
#' example, create the binary operator \code{\%cbind\%} from the function
#' \code{\link{cbind}()} by calling \code{grapes(cbind)}. Then,
#' you can call \code{sleep \%cbind\% sleep \%cbind\% sleep} to add
#' to the columns of a data frame while avoiding cumbersome parentheses.
#' @export
#' @param ... characters or symbols, names of functions to make into
#' binary operators.
#' @param list character vector of names of functions to make into
#' binary operators
#' @param from either a character scalar or an environment. If an environment,
#' this is where \code{grapes()} will look for the the functions named in 
#' \code{...} and \code{list}. If a character string, \code{from} names the 
#' package where \code{grapes()} will look for functions.
#' @param to environment to store the new binary operators. 
#' @examples
#' grapes(rbind, from = "base") # Use `from` to specify a package or environment to search.
#' nrow(sleep) # 20
#' longer = sleep %rbind% sleep %rbind% sleep # No clumsy parentheses!
#' nrow(longer) # 60. We'd all like to sleep longer.
grapes = function(..., list = character(0), from = to, to = parent.frame()){
  dots = match.call(expand.dots = FALSE)$...
  names = vapply(dots, as.character, "") %>% c(list)
  force(from)
  force(to)
  from = get_from(from)
  assign_grapes(names = names, from = from, to = to)
  invisible()
}

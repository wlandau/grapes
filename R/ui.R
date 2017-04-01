#' @title Function \code{bunch}
#' @description List the available operators in a package or environment.
#' The environment defaults to your workspace.
#' @export
#' @return character vector of all the available operators in an
#' environemnt
#' @param from package (character scalar) or environment to look for operators
#' @examples
#' grow(rbind, from = "base") 
#' bunch() # has "%rbind%"
#' myfun = function(x, y) x + y
#' env = new.env()
#' grow(myfun, to = env)
#' bunch() # has "%rbind%"
#' bunch(from = env) # "%myfun%"
bunch = function(from = parent.frame()){
  force(from)
  from = parse_from(from)
  Filter(ls(from), f = function(x) grepl("^%.*%$", x))
}

#' @title Function \code{grow}
#' @description Turn a collection of functions into binary operators. For
#' example, create the binary operator \code{\%cbind\%} from the function
#' \code{\link{cbind}()} by calling \code{grow(cbind)}. Then,
#' you can call \code{sleep \%cbind\% sleep \%cbind\% sleep} to add
#' to the columns of a data frame while avoiding cumbersome parentheses.
#' @export
#' @param ... characters or symbols, names of functions to make into
#' binary operators.
#' @param list character vector of names of functions to make into
#' binary operators
#' @param from package (character scalar) or environment to look 
#' for functions to turn into binary operators.
#' @param to environment to store the new binary operators. 
#' @examples
#' grow(rbind, from = "base") # Use `from` to specify a package or environment to search.
#' nrow(sleep) # 20
#' longer = sleep %rbind% sleep %rbind% sleep # No clumsy parentheses!
#' nrow(longer) # 60. Most of us would like to sleep longer.
grow = function(..., list = character(0), from = parent.frame(), to = parent.frame()){
  force(from)
  force(to)
  from = parse_from(from)
  dots = match.call(expand.dots = FALSE)$...
  names = vapply(dots, as.character, "") %>% c(list) %>% 
    unlist %>% unique
  if(!length(names)) names = functions(from)
  assign_grapes(names = names, from = from, to = to)
  invisible()
}

#' @title Function \code{functions}
#' @description List the available functions in a package or environment
#' that are not already binary ooperators.
#' @export
#' @return character vector of the names of available functions 
#' in \code{from}
#' @param from package (character scalar) or environment to look for functions
#' @examples
#' functions()
#' myfun = function(x, y) x + y
#' functions()
#' functions("grapes")
#' functions("knitr")
functions = function(from = parent.frame()){
  force(from)
  from = parse_from(from)
  lapply(ls(from), name_if_function, from = from) %>%
    unlist %>% setdiff(y = bunch(from)) %>% as.character
}

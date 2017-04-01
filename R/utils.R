assign_grapes = Vectorize(function(names, from, to){
  if(!(names %in% ls(from))){
    warning("function ", names, " not in found.")
    return()
  }
  value = from[[names]]
  if(is.function(value))
    assign(x = grape_names(names), value = value, envir = to)
  else
    warning(names, " is not a function.")
}, vectorize.args = "names")

grape_names = function(names){
  paste0("%", names, "%")
}

name_if_function = function(name, from){
  if(is.function(from[[name]])) name
}

parse_from = function(from){
  if(is.character(from)){
    require(from, character.only = TRUE)
    from = paste0("package:", from) %>%
      as.environment
  }
  if(!is.environment(from))
    stop("argument 'from' must be a package name or an environment.")
  from
}

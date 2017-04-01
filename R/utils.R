assign_grapes = Vectorize(function(names, from, to){
  value = from[[names]]
  if(is.function(value))
    assign(x = grape_names(names), value = value, envir = to)
}, vectorize.args = "names")

grape_names = function(names){
  paste0("%", names, "%")
}

get_from = function(from){
  if(is.character(from)){
    require(from, character.only = TRUE)
    from = paste0("package:", from) %>%
      as.environment
  }
  if(!is.environment(from))
    stop("argument 'from' must be a package name or an environment.")
  from
}

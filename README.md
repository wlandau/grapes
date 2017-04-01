<h1 align="center">
  <img width="400" src="./vignettes/logo.png" alt="" style = "border: none">
</h1>

[![Travis-CI Build Status](https://travis-ci.org/wlandau/grapes.svg?branch=master)](https://travis-ci.org/wlandau/grapes)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/wlandau/grapes?branch=master&svg=true)](https://ci.appveyor.com/project/wlandau/grapes)
[![codecov.io](https://codecov.io/github/wlandau/grapes/coverage.svg?branch=master)](https://codecov.io/github/wlandau/grapes?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/grapes)](http://cran.r-project.org/package=grapes)

The `grapes` package turns arbitrary functions into binary operators. As with the [magrittr pipe](https://CRAN.R-project.org/package=magrittr/vignettes/magrittr.html), you can avoid cumbersome parentheses this way.

```r
library(grapes)
grapes(rbind, from = "base") # `from` defaults to your current workspace
nrow(sleep) # 20
longer = sleep %rbind% sleep %rbind% sleep # No clumsy parentheses!
nrow(longer) # 60. We'd all like to sleep longer.
```

# Installation

To install the development version, get the [devtools](https://CRAN.R-project.org/package=devtools) package and run

```
devtools::install_github("wlandau/grapes", build = TRUE)
```

If you specify a tag, you can install a GitHub release.

```r
devtools::install_github("wlandau/grapes@v0.0.0", build = TRUE)
```

# Tutorial

The [online package vignette](https://github.com/wlandau/grapes/blob/master/vignettes/grapes.Rmd) has a complete tutorial. You can load the compiled version from an R session.

```r
vignette("grapes")
```


# Help and troubleshooting

Please read the [issue tracker](https://github.com/wlandau/grapes/issues) first, taking care to browse both open and closed issues. Afterwards, if you still feel the need, [submit a new issue](https://github.com/wlandau/grapes/issues/new) to log a bug report or feature request.

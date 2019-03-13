kitools <- NULL

.onLoad <- function(libname, pkgname) {
  kitools <<- reticulate::import("kitools", delay_load = TRUE)
}

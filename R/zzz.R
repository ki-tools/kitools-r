#' @importFrom rminiconda find_miniconda_python
.onLoad <- function(libname, pkgname) {
  py <- suppressWarnings(rminiconda::find_miniconda_python("kitools"))
  if (!file.exists(py)) {
    config_message()
  } else {
    reticulate::use_python(py, required = TRUE)
  }
}

config_message <- function() {
  message("It appears that kitools has not been configured...")
  message("Run 'kitools_configure()' for a one-time setup.")
}

#' One-time configuration of environment for kitools
#' @details This installs an isolated Python distribution along with required dependencies so that the kitools R package can seamlessly wrap the kitools Python package.
#' @export
kitools_configure <- function() {
  # install isolated miniconda
  rminiconda::install_miniconda(version = 3, name = "kitools")
  # install python packages
  py <- rminiconda::find_miniconda_python("kitools")
  pip <- rminiconda::find_miniconda_pip("kitools")
  system2(pip, " install beautifultable")
  system2(pip, " install synapseclient")
  system2(pip, " install -i https://test.pypi.org/simple/ kitools")

  reticulate::use_python(py, required = TRUE)
}

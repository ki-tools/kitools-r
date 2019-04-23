#' @importFrom rminiconda find_miniconda_python
.onLoad <- function(libname, pkgname) {
  Sys.setenv(PYTHONHOME = "")
  Sys.setenv(PYTHONPATH = "")
  is_configured()
}

is_configured <- function() {
  py <- suppressWarnings(rminiconda::find_miniconda_python("kitools"))
  if (!file.exists(py)) {
    message("It appears that kitools has not been configured...")
    message("Run 'kitools_configure()' for a one-time setup.")
    return (FALSE)
  } else {
    reticulate::use_python(py, required = TRUE)
    return (TRUE)
  }
}

#' One-time configuration of environment for kitools
#'
#' @details This installs an isolated Python distribution along with required dependencies so that the kitools R package can seamlessly wrap the kitools Python package.
#' @export
kitools_configure <- function() {
  # install isolated miniconda
  py <- suppressWarnings(rminiconda::find_miniconda_python("kitools"))
  if (!file.exists(py))
    rminiconda::install_miniconda(version = 3, name = "kitools")
  # install python packages
  py <- rminiconda::find_miniconda_python("kitools")
  pip_install("beautifultable")
  pip_install("synapseclient")
  pip_install("kitools", "-i https://test.pypi.org/simple/ kitools")

  reticulate::use_python(py, required = TRUE)
}

pip_install <- function(name, args = "") {
  pip <- rminiconda::find_miniconda_pip("kitools")
  args <- paste0(" install ", name, " ", args)
  res <- system2(pip, args)
  if (res != 0)
    warning("There was an issue installing Python module '", name, "'.")
}

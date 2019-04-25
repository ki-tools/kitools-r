#' @import rminiconda
.onLoad <- function(libname, pkgname) {
  Sys.setenv(PYTHONHOME = "")
  Sys.setenv(PYTHONPATH = "")
  is_configured(msg = packageStartupMessage)
}

#' Check to see if the kitools Python environment has been configured
#' @param msg What function to use for messages (could be called at package startup or elsewhere in the package)
is_configured <- function(msg = message) {
  # should also check that the required packages are installed
  if (!rminiconda::is_miniconda_installed("kitools")) {
    msg("It appears that kitools has not been configured...")
    msg("Run 'kitools_configure()' for a one-time setup.")
    return (FALSE)
  } else {
    py <- rminiconda::find_miniconda_python("kitools")
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
  if (!rminiconda::is_miniconda_installed("kitools"))
    rminiconda::install_miniconda(version = 3, name = "kitools")
  # install python packages
  py <- rminiconda::find_miniconda_python("kitools")
  rminiconda::rminiconda_pip_install("beautifultable", "kitools")
  rminiconda::rminiconda_pip_install("synapseclient", "kitools")
  rminiconda::rminiconda_pip_install("kitools", "kitools",
    "-i https://test.pypi.org/simple/ kitools")

  reticulate::use_python(py, required = TRUE)
}

pip_install <- function(name, args = "") {
  pip <- rminiconda::find_miniconda_pip("kitools")
  args <- paste0(" install ", name, " ", args)
  res <- system2(pip, args)
  if (res != 0)
    warning("There was an issue installing Python module '", name, "'.")
}

#' Initialize a kitools project
#'
#' @param local_path local_path
#' @param title title
#' @param description description
#' @param project_uri project_uri
#' @param resources resources
#' @export
ki_project <- function(local_path, title = NULL, description = NULL,
  project_uri = NULL, resources = NULL) {
  if (!is_configured())
    return(invisible(NULL))
  kitools <- reticulate::import("kitools")
  kitools$KiProject(local_path, title, description,
  project_uri, resources)
}

print.kitools.ki_project.KiProject <- function(x, ...) {
  message("*kitools Project*")
  message("title: ", x$title)
  if (!is.null(x$description))
    message("description:", x$description)
  message("located at: ", x$local_path)
}

# prevent double-printing of data_list()
print.beautifultable.beautifultable.BeautifulTable <- function(x, ...) {
  invisible(NULL)
}

# py_help_as_string <- function(object) {
#   reticulate::py_capture_output(
#     reticulate::import_builtins()$help(object),
#     type = "stdout")
# }

# hlp <- py_help_as_string(kitools$KiProject)
# reticulate::py_help(kitools$KiProject)

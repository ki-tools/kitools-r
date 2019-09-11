#' Initialize a kitools project
#'
#' @param local_path local_path
#' @param title title
#' @param description description
#' @param project_uri project_uri
#' @param resources resources
#' @export
ki_project <- function(local_path, title = NULL, description = NULL,
  project_uri = NULL, project_title = NULL, resources = NULL) {
  if (!is_configured())
    return(invisible(NULL))
  kitools <- reticulate::import("kitools")

  if (missing(local_path))
    stop("local_path is required.")

  # just load it if it already exists
  if (file.exists(file.path(local_path, "kiproject.json"))) {
    res <- kitools$KiProject(local_path)
    return(res)
  }

  ans <- user_prompt(paste0("Create KiProject in: ", local_path),
    c("y", "n"))
  if (ans == "n")
    stop("KiProject initialization failed.", call. = FALSE)

  if (is.null(title))
    title <- readline("KiProject title: ")

  if (is.null(project_title) && is.null(project_uri)) {
    ans <- user_prompt("Create a remote project or use an existing?",
      c("c", "e"))

    if (ans == "e")
      project_uri <- readline("Remote project URI: ")

    if (ans == "c")
      project_title <- readline("Remote project name: ")
  }

  kitools$KiProject(local_path, title, description,
    project_uri, resources, init_no_prompt = TRUE)
}

user_prompt <- function(question, opts) {
  msg <- paste0(question, " [", paste(opts, collapse = "/"), "]: ")
  while (TRUE) {
    ans <- tolower(readline(msg))
    if (ans %in% opts)
      return(ans)
  }
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

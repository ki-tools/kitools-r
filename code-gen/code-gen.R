load_all()
reticulate::py_config()

kitools <- reticulate::import("kitools")
inspect <- reticulate::import("inspect")

in_class <- names(kitools$KiProject)

to_doc <- c(
  "data_add", "data_change", "data_list",
  "data_pull", "data_push", "data_remove",
  "data_type_from_project_path",  "data_type_to_project_path",
  "find_missing_resources", "find_project_resource_by",
  "find_project_resources_by", "is_project_data_type_path",
  "load", "save", "show_missing_resources")

setdiff(in_class, to_doc)
setdiff(to_doc, in_class)

docs <- unname(sapply(to_doc, function(nm) {
  x <- inspect$getdoc(kitools$KiProject[[nm]])
  x <- strsplit(x, "\n")[[1]]
  didx <- seq_len(min(which(x == "")) - 1)
  dsc <- paste(x[didx], collapse = " ")
  x <- x[setdiff(seq_along(x), didx)]
  pidx <- which(grepl("^:param", x))
  params <- gsub("^:param ", "", x[pidx])
  pname <- gsub("([a-zA-Z0-9_]+): .*", "\\1", params)
  pdesc <- gsub("[a-zA-Z0-9_]+: (.*)", "\\1", params)
  x <- x[setdiff(seq_along(x), pidx)]
  ridx <- which(grepl("^:return:", x))
  ret <- gsub("^:return: (.*)", "\\1", x[ridx])
  ret <- gsub("None", "NULL", ret)
  x <- x[setdiff(seq_along(x), ridx)]

  sg <- inspect$signature(kitools$KiProject[[nm]])
  pars <- reticulate::iterate(sg$parameters)
  pars <- setdiff(pars, "self")
  if (!identical(sort(pars), sort(pname))) {
    message("Not identical:")
    message("  pars:  ", paste(pars, collapse = ", "))
    message("  pname: ", paste(pname, collapse = ", "))
  }
  fargs <- lapply(pars, function(par) {
    df <- sg$parameters$get(par)$default
    df <- as.character(df)
    if (length(df) == 0)
      df <- "NULL"
    if (! df %in% c("NULL", "TRUE", "FALSE", "<class 'inspect._empty'>"))
      df <- paste0("\"", df, "\"")
    if (par == "kwargs") {
      res <- "..."
    } else if (df == "<class 'inspect._empty'>") {
      res <- par
    } else {
      res <- paste(par, "=", df)
    }
    res
  })
  pname2 <- ifelse(pname == "kwargs", "...", pname)
  pname2 <- c("ki_project", pname2)
  pdesc2 <- c("a Ki Project obtained from \\code{\\link{ki_project}}", pdesc)
  args <- ifelse(pname == "kwargs", "...", paste(pname, "=", pname))
  fn <- paste0(nm,
    " <- function(", paste(c("ki_project", fargs), collapse = ", "), ") {\n",
    "  ki_project$", nm, "(", paste(args, collapse = ", "), ")\n",
    "}\n")
  dc <- paste0(
    "#' ", dsc, "\n",
    "#'\n",
    paste0("#' @param ", pname2, " ", pdesc2, collapse = "\n"), "\n",
    "#' @note This can be used in either of the following ways:\n",
    "#' \\preformatted{\n",
    "#' ki_project$", nm, "(...)\n",
    "#' ", nm, "(ki_project, ...)\n",
    "#' }\n",
    "#' @return ", ret, "\n",
    "#' @export"
  )
  paste0(dc, "\n", fn)
}))

cat(paste(docs, collapse = "\n"), file = "R/fns-auto.R")

document()

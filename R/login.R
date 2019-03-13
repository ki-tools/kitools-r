#' One-time setup of Synapse credentials
#' @param email your Synapse email address (if not supplied, will be prompted)
#' @param pass your Synapse password (if not supplied, will be prompted)
#' @export
#' @importFrom reticulate import
#' @importFrom askpass askpass
syn_login <- function(email = NULL, pass = NULL) {
  sc <- reticulate::import("synapseclient")
  syn <- sc$Synapse()
  if (is.null(email))
    email <- readline("Please enter your email address: ")
  if (is.null(pass))
    pass <- askpass::askpass()
  syn$login(email, pass, rememberMe = TRUE)
}

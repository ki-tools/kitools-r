#' Adds a new resource to the KiProject. The resource can be a remote or local file or directory. If the resource already exists it will be updated with the provided parameters.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param remote_uri_or_local_path The remote URI (e.g., syn:syn123456) or local path of the directory for file.
#' @param name A user friendly name for the resource.
#' @param version The version of the file to add.
#' @param data_type The DataType of the file. This is only required when a remote_uri is provided and the remote
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_add(...)
#' data_add(ki_project, ...)
#' }
#' @return KiProjectResource
#' @export
data_add <- function(ki_project, remote_uri_or_local_path, name = NULL, version = NULL, data_type = NULL) {
  ki_project$data_add(remote_uri_or_local_path = remote_uri_or_local_path, name = name, version = version, data_type = data_type)
}

#' Changes the name or version on a KiProjectResource.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param resource_or_identifier KiProjectResource object or a valid identifier (local path, remote URI, name).
#' @param name The new name.
#' @param version The new version (or 'None' to clear the version).
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_change(...)
#' data_change(ki_project, ...)
#' }
#' @return KiProjectResource
#' @export
data_change <- function(ki_project, resource_or_identifier, name = NULL, version = NULL) {
  ki_project$data_change(resource_or_identifier = resource_or_identifier, name = name, version = version)
}

#' Prints out a table of all the resources in the KiProject.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param all Set to True to include all child resources.
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_list(...)
#' data_list(ki_project, ...)
#' }
#' @return BeautifulTable
#' @export
data_list <- function(ki_project, all = FALSE) {
  ki_project$data_list(all = all)
}

#' Downloads a specific resource or all resources in the KiProject.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param resource_or_identifier KiProjectResource object or a valid identifier (local path, remote URI, name).
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_pull(...)
#' data_pull(ki_project, ...)
#' }
#' @return The absolute path to the pulled resource or a list of absolute paths for all pulled resources.
#' @export
data_pull <- function(ki_project, resource_or_identifier = NULL) {
  ki_project$data_pull(resource_or_identifier = resource_or_identifier)
}

#' Uploads a specific resource or all local non-pushed resources.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param resource_or_identifier KiProjectResource object or a valid identifier (local path, remote URI, name).
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_push(...)
#' data_push(ki_project, ...)
#' }
#' @return The absolute path to the pushed resource or a list of absolute paths for all pushed resources.
#' @export
data_push <- function(ki_project, resource_or_identifier = NULL) {
  ki_project$data_push(resource_or_identifier = resource_or_identifier)
}

#' Removes a resource from the KiProject. This does not delete the file locally or remotely, it is only removed from the KiProject manifest.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param resource_or_identifier KiProjectResource object or a valid identifier (local path, remote URI, name).
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_remove(...)
#' data_remove(ki_project, ...)
#' }
#' @return KiProjectResource
#' @export
data_remove <- function(ki_project, resource_or_identifier) {
  ki_project$data_remove(resource_or_identifier = resource_or_identifier)
}

#' Gets the DataType from a local path. The local path must be in one of the KiProject's DataType directories.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param local_path Path to get the DataType from.
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_type_from_project_path(...)
#' data_type_from_project_path(ki_project, ...)
#' }
#' @return The DataType or NULL.
#' @export
data_type_from_project_path <- function(ki_project, local_path) {
  ki_project$data_type_from_project_path(local_path = local_path)
}

#' Gets the absolute path to the DataType directory in the KiProject.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param data_type The DataType to get the path for.
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$data_type_to_project_path(...)
#' data_type_to_project_path(ki_project, ...)
#' }
#' @return Absolute path to the local directory as a string.
#' @export
data_type_to_project_path <- function(ki_project, data_type) {
  ki_project$data_type_to_project_path(data_type = data_type)
}

#' Finds all local DataType directories and files that have not been added to the KiProject resources.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$find_missing_resources(...)
#' find_missing_resources(ki_project, ...)
#' }
#' @return List of paths
#' @export
find_missing_resources <- function(ki_project) {
  ki_project$find_missing_resources()
}

#' Finds a single resource in the KiProject by any of KiProjectResource attributes.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param operator The operator to use when finding by more than one attribute. Must be one of: 'and', 'or'.
#' @param ... KiProjectResource attributes and values to find by.
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$find_project_resource_by(...)
#' find_project_resource_by(ki_project, ...)
#' }
#' @return KiProjectResource or NULL
#' @export
find_project_resource_by <- function(ki_project, operator = "and", ...) {
  ki_project$find_project_resource_by(operator = operator, ...)
}

#' Finds all resources in the KiProject by any of KiProjectResource attributes.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param operator The operator to use when finding by more than one attribute. Must be one of: 'and', 'or'.
#' @param ... KiProjectResource attributes and values to find by.
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$find_project_resources_by(...)
#' find_project_resources_by(ki_project, ...)
#' }
#' @return List of KiProjectResources or an empty list.
#' @export
find_project_resources_by <- function(ki_project, operator = "and", ...) {
  ki_project$find_project_resources_by(operator = operator, ...)
}

#' Gets if the local_path is in one of the DataType directories.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @param local_path Path to check.
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$is_project_data_type_path(...)
#' is_project_data_type_path(ki_project, ...)
#' }
#' @return True or False
#' @export
is_project_data_type_path <- function(ki_project, local_path) {
  ki_project$is_project_data_type_path(local_path = local_path)
}

#' Loads the KiProject from a config file.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$load(...)
#' load(ki_project, ...)
#' }
#' @return True if the config file exists and was loaded.
#' @export
load <- function(ki_project) {
  ki_project$load()
}

#' Saves the KiProject to a config file.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$save(...)
#' save(ki_project, ...)
#' }
#' @return NULL
#' @export
save <- function(ki_project) {
  ki_project$save()
}

#' Shows all local DataType directories and files that have not been added to the KiProject resources.
#'
#' @param ki_project a Ki Project obtained from \code{\link{ki_project}}
#' @note This can be used in either of the following ways:
#' \preformatted{
#' ki_project$show_missing_resources(...)
#' show_missing_resources(ki_project, ...)
#' }
#' @return NULL
#' @export
show_missing_resources <- function(ki_project) {
  ki_project$show_missing_resources()
}

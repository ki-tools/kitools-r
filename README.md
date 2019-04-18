[![Travis build status](https://travis-ci.org/ki-tools/kitools.svg?branch=master)](https://travis-ci.org/ki-tools/kitools-r) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/ki-tools/kitools-r?branch=master&svg=true)](https://ci.appveyor.com/project/hafen/kitools-r) [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- [![Coverage status](https://codecov.io/gh/ki-tools/kitools-r/branch/master/graph/badge.svg)](https://codecov.io/github/ki-tools/kitools-r?branch=master) -->

# kitools

Tools for working with data in Ki analyses. Based on an [earlier prototype](https://github.com/ki-tools/kitools) - see that package's [README](https://github.com/ki-tools/kitools#kitools) for more background. This is an an alpha stage of development and is built around the [kitools Python package](https://github.com/ki-tools/kitools-py).

## Installation

You can install this package from GitHub with:

``` r
devtools::install_github("ki-tools/kitools-r")
```

Currently, to use this package you need to have Python (>=v3.6) installed and the `kitools-py` Python package installed. We are working to remove this prerequisite.

```bash
pip install beautifultable
pip install synapseclient
pip install -i https://test.pypi.org/simple/ kitools
```

## Example

``` r
library(kitools)

# path for analysis project directory
path <- tempfile()

# initialize a ki project
# this will prompt for a project name and Synapse space name
p <- ki_project(path)

## Create KiProject in: /var/folders/n4/6ztyqms165s3r_4n001n1y6m0000gn/T/RtmpUCOII8/file1343122d69306 [y/n]: y
## KiProject title: test project
## Create a remote project or use an existing? [c/e]: e
## Remote project URI (e.g., syn:syn123456): syn:syn296555
## Remote project URI: syn:syn296555
## KiProject initialized successfully and ready to use.

# list all datasets associated with project (none at this point)
p$data_list()

# associate a file located on Synapse with the project
p$data_add("syn:syn17100911", data_type = "core")

# the data has been registered with the project but hasn't been pulled yet
p$data_list()

## ┌─────────────────┬─────────┬─────────────────┬──────┐
## │ Remote URI      │ Version │ Name            │ Path │
## ├─────────────────┼─────────┼─────────────────┼──────┤
## │ syn:syn17100911 │ None    │ syn:syn17100911 │ None │
## └─────────────────┴─────────┴─────────────────┴──────┘

# pull the dataset
file <- p$data_pull()

file

## "/var/folders/n4/6ztyqms165s3r_4n001n1y6m0000gn/T/RtmpUCOII8/file1343122d69306/data/core/cpp.csv"

# read the csv file
cpp <- readr::read_csv(file)

# compute a derived dataset and save it
library(dplyr)

cpp_summ <- cpp %>%
  group_by(subjid) %>%
  tally()

path <- file.path(p$data_path, "derived/cpp_summ.csv")
readr::write_csv(cpp_summ, path = path)

# register this data with the project
p$data_add(path)

# the data has been registered but hasn't been pushed yet
p$data_list()

## ┌─────────────────┬─────────┬─────────────────┬───────────────────────────┐
## │ Remote URI      │ Version │ Name            │ Path                      │
## ├─────────────────┼─────────┼─────────────────┼───────────────────────────┤
## │ syn:syn17100911 │ None    │ syn:syn17100911 │ data/core/cpp.csv         │
## ├─────────────────┼─────────┼─────────────────┼───────────────────────────┤
## │ None            │ None    │ cpp_summ.csv    │ data/derived/cpp_summ.csv │
## └─────────────────┴─────────┴─────────────────┴───────────────────────────┘

# push the data
p$data_push("cpp_summ.csv")

## ##################################################
##  Uploading file to Synapse storage 
## ##################################################
##
## Uploading [####################]100.00%   2.8kB/2.8kB (1.1kB/s) cpp_summ.csv Done...

p$data_list()

## ┌─────────────────┬─────────┬─────────────────┬───────────────────────────┐
## │ Remote URI      │ Version │ Name            │ Path                      │
## ├─────────────────┼─────────┼─────────────────┼───────────────────────────┤
## │ syn:syn17100911 │ None    │ syn:syn17100911 │ data/core/cpp.csv         │
## ├─────────────────┼─────────┼─────────────────┼───────────────────────────┤
## │ syn:syn18420491 │ None    │ cpp_summ.csv    │ data/derived/cpp_summ.csv │
## └─────────────────┴─────────┴─────────────────┴───────────────────────────┘
```

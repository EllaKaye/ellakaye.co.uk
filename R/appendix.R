# The code below is copied from Danielle Navarro's quarto blog:
# https://github.com/djnavarro/quarto-blog/blob/main/posts/2022-04-20_porting-to-quarto/appendix.R

# markdown helpers --------------------------------------------------------

markdown_appendix <- function (name, content) {
  paste(paste("##", name, "{.appendix}"), " ", content, sep = "\n")
}
markdown_link <- function (text, path) {
  paste0("[", text, "](", path, "){target='_blank'}")
}



# worker functions --------------------------------------------------------

insert_source <- function(repo_spec, name,
                          collection = "posts",
                          branch = "main",
                          host = "https://github.com",
                          text = "source code") {
  path <- paste(
    host,
    repo_spec,
    "tree",
    branch,
    collection,
    name,
    "index.qmd",
    sep = "/"
  )
  return(markdown_link(text, path))
}

insert_timestamp <- function(tzone = Sys.timezone()) {
  time <- lubridate::now(tzone = tzone)
  stamp <- as.character(time, tz = tzone, usetz = TRUE)
  return(stamp)
}

insert_lockfile <- function(repo_spec, name,
                            collection = "posts",
                            branch = "main",
                            host = "https://github.com",
                            text = "R environment") {
  path <- paste(
    host,
    repo_spec,
    "tree",
    branch,
    collection,
    name,
    "renv.lock",
    sep = "/"
  )
  return(markdown_link(text, path))
}



# top level function ------------------------------------------------------

insert_appendix <- function (repo_spec, name, collection = "posts", lockfile = FALSE) {

  if (lockfile) {
    details_content <- paste(
      insert_source(repo_spec, name, collection),
      insert_lockfile(repo_spec, name, collection),
      sep = ", ")
  } else {
    details_content <- insert_source(repo_spec, name, collection)
  }


  appendices <- paste(
    markdown_appendix(
      name = "Last updated",
      content = insert_timestamp()
    ),
    " ",
    markdown_appendix(
      name = "Details",
      content = details_content
    ),
    sep = "\n"
  )
  knitr::asis_output(appendices)
}
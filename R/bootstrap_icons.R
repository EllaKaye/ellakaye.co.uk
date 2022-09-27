# Get icon names

# bootstrap

bi_icons <- jsonlite::fromJSON("https://raw.githubusercontent.com/twbs/icons/main/font/bootstrap-icons.json")

bi_icons |> tibble::enframe()

# fontawesome (piggyback off fontawesome R package)

fa_icons <- fontawesome:::fa_tbl
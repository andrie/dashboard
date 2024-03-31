pkg <- "rfordummies"
repo <- "rfordummies"

get_badges <- function(pkg, repo = "andrie") {
  blob <- glue::glue("https://raw.githubusercontent.com/{repo}/{pkg}/main/README.Rmd")
  rmd <- readr::read_lines(blob)
  start <- grep("<!-- badges: start -->", rmd)
  end   <- grep("<!-- badges: end -->"  , rmd)
  badges <- rmd[(start + 1) : (end - 1)] 
  
  desc <- glue::glue("https://raw.githubusercontent.com/{repo}/{pkg}/main/DESCRIPTION")
  dcf <- readr::read_lines(desc)
  line <- grep("^Title", dcf)
  title <- dcf[line]
  
  cat(title)
  cat("\n\n")
  cat(badges)
  cat("\n\n")
  invisible(list(title, badges))
}

get_badges(pkgs, repo)

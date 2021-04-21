library(fs)

## Check if URL in storage, download and save if not.
retrieve_page_at_url <- function(url, scrape_waiting_period = 5) {
  file_to_return <- NULL
  
  file_path <- url %>% convert_url_to_filename
  
  file_is_already_downloaded <- file_exists(file_path)
  
  if (file_is_already_downloaded) {
    file_to_return = read_html(file_path)
  } else {
    tryCatch(
      {
        Sys.sleep(scrape_waiting_period)
        
        file_to_return = read_html(url)
        
        file_to_return %>% write_html(file_path)
      },
      error = function(c) {
        message(
          paste0(
            "Got an error when trying to read_html a page",
            "\n\t url = ", url,
            "\n\t error = ", c
          )
        )
      }
    )
  }
  
  if (is_null(file_to_return)) {
    message(
      paste0(
        "Could not retrieve a page\n\t ",
        "url = ", url
      )
    )
    
    return(list())
  }
  
  return(file_to_return)
}

convert_url_to_filename <- function(url) {
  url %>%
    str_replace_all(fixed("/"), fixed("SLASH")) %>%
    str_replace_all(fixed(":"), fixed("COLON")) %>%
    path("data/source/downloaded-pages", ., ext = "html")
}

library(tidyverse)
library(rvest)

source("lib/retrieve-pages.R")

budget_doc_urls <- c(
  "https://www.budget.gc.ca/2021/report-rapport/p1-en.html",
  "https://www.budget.gc.ca/2021/report-rapport/p2-en.html",
  "https://www.budget.gc.ca/2021/report-rapport/p3-en.html",
  "https://www.budget.gc.ca/2021/report-rapport/p4-en.html"
)

budget_docs <- tibble(url = budget_doc_urls) %>%
  mutate(page = map(url, retrieve_page_at_url))



library(tidyverse)
library(rvest)

source("lib/retrieve-pages.R")

budget_docs <- tribble(
    ~part, ~title, ~url,
    1, "Finishing the Fight Against COVID-19", "https://www.budget.gc.ca/2021/report-rapport/p1-en.html",
    2, "Creating Jobs and Growth", "https://www.budget.gc.ca/2021/report-rapport/p2-en.html",
    3, "A Resilient and Inclusive Recovery", "https://www.budget.gc.ca/2021/report-rapport/p3-en.html",
    4, "Fair and Responsible Government", "https://www.budget.gc.ca/2021/report-rapport/p4-en.html"
  ) %>%
  mutate(page = map(url, retrieve_page_at_url))

proposals <- budget_docs %>%
  mutate(proposal = map(
    page,
    ~ .x %>%
      html_elements(".media-body") %>%
      html_text2()
  )) %>%
  unnest(cols = c(proposal)) %>%
  select(part, proposal) %>%
  mutate(proposal = str_remove_all(proposal, "\\r")) %>% ## Next set of `mutate` lines are data cleaning.
  mutate(proposal = trimws(proposal)) %>%
  mutate(has_gba_icon = str_detect(proposal, "Gender-Based Analysis\\+$")) %>% ## Note which proposals include a GBA+ icon -- not visible in the text. See all GBA+ summaries here: https://www.budget.gc.ca/2021/pdf/Annexe-5-eng.pdf
  mutate(proposal = str_remove(proposal, "Gender-Based Analysis\\+$")) %>%
  mutate(proposal = trimws(proposal))

proposals %>% write_csv("data/out/proposals.csv")

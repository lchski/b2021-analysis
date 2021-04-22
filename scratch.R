zzz <- budget_docs %>%
  mutate(proposal = map(
    page,
    ~ .x %>%
      html_elements(".media-body")
  )) %>%
  slice(1) %>%
  mutate(proposal_title = map(
    page,
    ~ .x %>%
      html_elements(xpath = '//span[contains(@class,"media-body")]/preceding::h4') %>%
      html_text2()
  ))

budget_docs %>%
  mutate(proposal = map(
    page,
    ~ .x %>%
      html_elements(".media-body")
  )) %>%
  slice(1) %>%
  mutate(proposal_title = map(
    proposal,
    ~ .x %>%
      html_elements(xpath = './preceding::h4') %>%
      html_text2()
  )) %>%
  mutate(proposal = map(proposal, html_text2)) %>%
  unnest(c(proposal, proposal_title))

budget_docs %>%
  mutate(proposal = map(
    page,
    ~ .x %>%
      html_elements(".media-body")
  )) %>%
  slice(1) %>%
  mutate(proposal_title = map(
    proposal,
    ~ .x %>%
      html_element(xpath = '//ancestor::ul/preceding-sibling::h4[1]') %>%
      html_text2()
  )) %>%
  mutate(proposal = map(proposal, html_text2)) %>%
  unnest(c(proposal, proposal_title))

budget_docs %>%
  slice(1) %>%
  mutate(proposal_title = map(
    page,
    ~ .x %>%
      html_elements("h4")
  )) %>%
  mutate(proposal = map(
    proposal_title,
    ~ .x %>%
      html_elements(xpath = './following-sibling::ul[starts-with(@class,"media-list")]/span[contains(@class,"media-body")]')
  )) %>%
  mutate(proposal_title = map(proposal_title, html_text2)) %>%
  mutate(proposal = map(proposal, html_text2))

## go to parent .media-list
## find 

## "./ancestor::ul"

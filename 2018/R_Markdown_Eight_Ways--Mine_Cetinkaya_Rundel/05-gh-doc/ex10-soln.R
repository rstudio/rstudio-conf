# data prep
dn <- dn %>%
  mutate(
    establishment = "Denny's",
    country = "United States"
  ) %>%
  filter(country == "United States")

lq <- lq %>%
  mutate(
    establishment = "La Quinta",
    country = case_when(
      state %in% state.abb     ~ "United States",
      state %in% c("ON", "BC") ~ "Canada",
      state == "ANT"           ~ "Columbia",
      state == "FM"            ~ "Honduras",
      TRUE                     ~ "Mexico")) %>%
  filter(country == "United States")

dn_lq <- bind_rows(dn, lq)    

# plot
ggplot(dn_lq, mapping = aes(x = longitude, y = latitude, color = establishment)) +
  geom_point()

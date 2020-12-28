#################################################################
####  Figures for "Always Look on the Bright Side of Plots"  ####
#################################################################

# Setup ------------------------------------------------------------------------

library("tidyverse")
library("palmerpenguins")
library("ggrepel")
library("gapminder")
library("patchwork")
library("flametree")

## Color palette
## https://coolors.co/7c1354-b40424-fb8b24-e36414-0f4c5c
colors <- c("#7C1354", "#B40424", "#fb8b24", "#e36414", "#0f4c5c")

talk_theme <- theme_grey(base_size = 20) +
  theme(
    text = element_text(family = "Lato", colour = "grey80"),
    axis.text = element_text(colour = "grey80"),
    axis.ticks = NULL,
    legend.background = element_rect(fill = NA),
    legend.key = element_rect(fill = NA),
    legend.position = "bottom",
    panel.background = element_rect(fill = NA),
    panel.grid = element_line(colour = "grey40"),
    plot.background = element_rect(fill = "black", colour = "black")
  )

theme_set(talk_theme)

# Tree image -------------------------------------------------------------------

dat <- flametree_grow(
  seed = 500,
  time = 15,
  scale = c(0.8, 0.7),
  angle = c(-15, -5, 5, 7, 10)
)

tree <- flametree_plot(
  tree = dat,
  background = "black",
  palette = "viridis::magma"
)

# Mapping text to data ---------------------------------------------------------

penguin_plot <- ggplot(
  penguins,
  aes(x = flipper_length_mm, y = bill_length_mm)
) +
  geom_point(aes(color = species, shape = species), size = 3, alpha = 0.8) +
  scale_colour_manual(values = colors) +
  labs(
    x = "Flipper length (mm)",
    y = "Bill length (mm)",
    color = "Penguin species",
    shape = "Penguin species",
    title = "Penguin flipper and bill length"
  )

## Wrong:
penguin_wrong_1 <- penguin_plot +
  geom_text(
    aes(x = 195, y = 55, label = "Chinstrap"),
    size = 9,
    colour = "grey80"
  )

## ggrepel example
penguin_wrong_2 <- penguin_plot +
  geom_text_repel(
    aes(x = 195, y = 55, label = "Chinstrap"),
    colour = "grey80"
  )

## Right:
penguin_right <- penguin_plot +
  annotate(
    geom = "text",
    x = 195,
    y = 55,
    label = "Chinstrap",
    size = 9,
    colour = "grey80"
  )

# Scales vs coordinates --------------------------------------------------------

penguin_smooth <- penguin_plot +
  geom_smooth(aes(group = species, fill = species, colour = species)) +
  scale_fill_manual(values = colors) +
  labs(fill = "Penguin species")

## Censors data:
penguin_scale <- penguin_smooth +
  scale_x_continuous(limits = c(200, NA)) +
  # Set y limits so they match between plots (otherwise the error bands throw
  # off the y scale between the two plots)
  coord_cartesian(ylim = c(30, NA))

## Zooms in plot:
penguin_coord <- penguin_smooth +
  coord_cartesian(xlim = c(200, NA), ylim = c(30, NA))

## Side by side view
penguin_scale_coord <- penguin_scale +
  theme(legend.position = "none") +
  penguin_coord +
  labs(title = NULL) +
  theme(legend.position = "none")

# Themes -----------------------------------------------------------------------

penguin_plot_2ax <- penguin_plot +
  scale_y_continuous(sec.axis = dup_axis())

## Wrong:
penguin_theme_wrong <- penguin_plot_2ax +
  theme(
    axis.text.y = element_text(
      angle = 90,
      hjust = 1,
    )
  )

## Right:
penguin_theme_right <- penguin_plot_2ax +
  theme(
    axis.text.y.left = element_text(
      angle = 90,
      hjust = 1
    ),
    axis.text.y.right = element_text(
      angle = 90,
      hjust = 1
    )
  )

# Final example ----------------------------------------------------------------

states <- map_data("state") %>%
  arrange(desc(region))  # makes a cooler looking pattern

## Geometric map
states_wrong <- ggplot(states, aes(x = long, y = lat)) +
  geom_polygon(fill = "#7C1354") +
  coord_map() +
  labs(
    x = "Longitude",
    y = "Latitude"
  )

## What's wrong here?

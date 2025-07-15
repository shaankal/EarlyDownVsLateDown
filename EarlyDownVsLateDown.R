library(nflfastR)
library(tidyverse)
library(data.table)


pbp <- load_pbp(2024) %>%
  filter(season_type == "REG",
         !is.na(epa),
         play_type %in% c("run", "pass"
         ))


pbp <- pbp %>%
  mutate(
    down_bucket = case_when(
      down == 1 & ydstogo == 10 ~ "1st & 10",
      down %in% c(3, 4) ~ "3rd/4th Down",
      TRUE ~ NA_character_
    ),
    shotgun_type = ifelse(shotgun == 1, "Shotgun", "Under Center"),
    conversion = if_else(down %in% c(3, 4) & first_down == 1, 1, 0)
  ) %>%
  filter(!is.na(down_bucket))



pbp <- pbp %>%
  mutate(
    shotgun_type = ifelse(shotgun == 1, "Shotgun", "Under Center"),
    play_action_type = ifelse(play_action == 1, "Play Action", "Standard Dropback"),
    conversion = if_else(down %in% c(3, 4) & first_down == 1, 1, 0)
  )

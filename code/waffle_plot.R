# Waffle plot -------------------------------------------------------------
# to come back to when I have figured this out!


library(waffle)

c <- waffle(records$species, rows = 10)

parts <- c(One=80, Two=30, Three=20, Four=10)
chart <- waffle(parts, rows=6)
chart

ggplot(records, aes(fill = species, values = n)) + geom_waffle(n_rows = 10)

waffle(records, rows = 10)
waffle(grp, rows=5)
# Load necessary libraries
library(readxl)
library(ggplot2)
library(dplyr)

# Read the Excel file
file_path <- "/Users/qaisbello/Desktop/Project Data/ALL INDOOR VALUES REFORMATTED.xlsx"
data <- read_excel(file_path)

# Convert TIME column to POSIXct
data$TIME <- as.POSIXct(data$TIME, format = "%H:%M")

# Define the time limits and breaks
time_limits <- as.POSIXct(c("08:00", "19:00"), format = "%H:%M")
time_breaks <- seq(from = as.POSIXct("08:00", format = "%H:%M"), to = as.POSIXct("19:00", format = "%H:%M"), by = "5 min")

# Add a column to differentiate morning and afternoon
data <- data %>%
  mutate(Period = ifelse(format(TIME, "%H:%M") < "12:00", "Morning", "Afternoon"))

# Function to find peaks for morning and afternoon
find_peaks <- function(data, value_column) {
  data %>%
    group_by(Location, Period) %>%
    filter(!!sym(value_column) == max(!!sym(value_column), na.rm = TRUE)) %>%
    slice(1) %>% # In case of multiple peaks, take the first one
    ungroup()
}

# Adjust the plot area by modifying theme settings
custom_theme <- theme_minimal() +
  theme(
    plot.margin = margin(10, 10, 10, 10),
    panel.grid.major = element_line(size = 0.2),
    panel.grid.minor = element_line(size = 0.1),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "bottom",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 8) # Rotate and adjust size of time labels
  )

# Function to format labels with 2 decimal places
format_label <- function(x) {
  sprintf("%.2f", x)
}

# Function to add morning and afternoon labels to the x-axis
add_period_labels <- function(plot, data) {
  periods <- data %>%
    group_by(Period) %>%
    summarise(start = min(TIME), end = max(TIME))
  
  plot + annotate("text", x = as.POSIXct("09:30", format = "%H:%M"), y = Inf, label = "Morning", vjust = 2, size = 3.5) +
    annotate("text", x = as.POSIXct("15:30", format = "%H:%M"), y = Inf, label = "Afternoon", vjust = 2, size = 3.5)
}

# Plot CO2 levels for Day 1
data_day1 <- subset(data, DAY == "Day 1") %>% na.omit()
data_day1_peaks <- find_peaks(data_day1, "CO2")
ggplot(data_day1, aes(x = TIME, y = CO2, color = Location, group = Location)) +
  geom_line() +
  geom_point(data = data_day1_peaks, aes(x = TIME, y = CO2, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day1_peaks, aes(x = TIME, y = CO2, label = format_label(CO2)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "CO2 Levels on Day 1", x = "Time", y = "CO2 Level") +
  custom_theme

# Plot CO2 levels for Day 2
data_day2 <- subset(data, DAY == "Day 2") %>% na.omit()
data_day2_peaks <- find_peaks(data_day2, "CO2")
ggplot(data_day2, aes(x = TIME, y = CO2, color = Location, group = Location)) +
  geom_line() +
  geom_point(data = data_day2_peaks, aes(x = TIME, y = CO2, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day2_peaks, aes(x = TIME, y = CO2, label = format_label(CO2)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "CO2 Levels on Day 2", x = "Time", y = "CO2 Level") +
  custom_theme

# Plot CO2 levels for Day 3
data_day3 <- subset(data, DAY == "Day 3") %>% na.omit()
data_day3_peaks <- find_peaks(data_day3, "CO2")
ggplot(data_day3, aes(x = TIME, y = CO2, color = Location, group = Location)) +
  geom_line() +
  geom_point(data = data_day3_peaks, aes(x = TIME, y = CO2, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day3_peaks, aes(x = TIME, y = CO2, label = format_label(CO2)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "CO2 Levels on Day 3", x = "Time", y = "CO2 Level") +
  custom_theme

# Plot CO2 levels for Day 4
data_day4 <- subset(data, DAY == "Day 4") %>% na.omit()
data_day4_peaks <- find_peaks(data_day4, "CO2")
ggplot(data_day4, aes(x = TIME, y = CO2, color = Location, group = Location)) +
  geom_line() +
  geom_point(data = data_day4_peaks, aes(x = TIME, y = CO2, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day4_peaks, aes(x = TIME, y = CO2, label = format_label(CO2)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "CO2 Levels on Day 4", x = "Time", y = "CO2 Level") +
  custom_theme

# Plot CO2 levels for Day 5
data_day5 <- subset(data, DAY == "Day 5") %>% na.omit()
data_day5_peaks <- find_peaks(data_day5, "CO2")
ggplot(data_day5, aes(x = TIME, y = CO2, color = Location, group = Location)) +
  geom_line() +
  geom_point(data = data_day5_peaks, aes(x = TIME, y = CO2, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day5_peaks, aes(x = TIME, y = CO2, label = format_label(CO2)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "CO2 Levels on Day 5", x = "Time", y = "CO2 Level") +
  custom_theme

# PM 2.5 Levels on Day 1
data_day1_pm25 <- subset(data_pm, DAY == "Day 1") %>% na.omit()
data_day1_pm25_peaks <- find_peaks(data_day1_pm25, "PM2.5")
ggplot(data_day1_pm25, aes(x = TIME, y = `PM2.5`, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day1_pm25_peaks, aes(x = TIME, y = `PM2.5`, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day1_pm25_peaks, aes(x = TIME, y = `PM2.5`, label = format_label(`PM2.5`)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 2.5 Levels on Day 1", x = "Time", y = "PM 2.5 Level") +
  custom_theme

# PM 2.5 Levels on Day 2
data_day2_pm25 <- subset(data_pm, DAY == "Day 2") %>% na.omit()
data_day2_pm25_peaks <- find_peaks(data_day2_pm25, "PM2.5")
ggplot(data_day2_pm25, aes(x = TIME, y = `PM2.5`, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day2_pm25_peaks, aes(x = TIME, y = `PM2.5`, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day2_pm25_peaks, aes(x = TIME, y = `PM2.5`, label = format_label(`PM2.5`)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 2.5 Levels on Day 2", x = "Time", y = "PM 2.5 Level") +
  custom_theme

# PM 2.5 Levels on Day 3
data_day3_pm25 <- subset(data_pm, DAY == "Day 3") %>% na.omit()
data_day3_pm25_peaks <- find_peaks(data_day3_pm25, "PM2.5")
ggplot(data_day3_pm25, aes(x = TIME, y = `PM2.5`, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day3_pm25_peaks, aes(x = TIME, y = `PM2.5`, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day3_pm25_peaks, aes(x = TIME, y = `PM2.5`, label = format_label(`PM2.5`)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 2.5 Levels on Day 3", x = "Time", y = "PM 2.5 Level") +
  custom_theme

# PM 2.5 Levels on Day 4
data_day4_pm25 <- subset(data_pm, DAY == "Day 4") %>% na.omit()
data_day4_pm25_peaks <- find_peaks(data_day4_pm25, "PM2.5")
ggplot(data_day4_pm25, aes(x = TIME, y = `PM2.5`, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day4_pm25_peaks, aes(x = TIME, y = `PM2.5`, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day4_pm25_peaks, aes(x = TIME, y = `PM2.5`, label = format_label(`PM2.5`)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 2.5 Levels on Day 4", x = "Time", y = "PM 2.5 Level") +
  custom_theme

# PM 2.5 Levels on Day 5
data_day5_pm25 <- subset(data_pm, DAY == "Day 5") %>% na.omit()
data_day5_pm25_peaks <- find_peaks(data_day5_pm25, "PM2.5")
ggplot(data_day5_pm25, aes(x = TIME, y = `PM2.5`, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day5_pm25_peaks, aes(x = TIME, y = `PM2.5`, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day5_pm25_peaks, aes(x = TIME, y = `PM2.5`, label = format_label(`PM2.5`)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 2.5 Levels on Day 5", x = "Time", y = "PM 2.5 Level") +
  custom_theme

# PM 10 Levels on Day 1
data_day1_pm10 <- subset(data_pm, DAY == "Day 1") %>% na.omit()
data_day1_pm10_peaks <- find_peaks(data_day1_pm10, "PM10")
ggplot(data_day1_pm10, aes(x = TIME, y = PM10, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day1_pm10_peaks, aes(x = TIME, y = PM10, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day1_pm10_peaks, aes(x = TIME, y = PM10, label = format_label(PM10)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 10 Levels on Day 1", x = "Time", y = "PM 10 Level") +
  custom_theme

# PM 10 Levels on Day 2
data_day2_pm10 <- subset(data_pm, DAY == "Day 2") %>% na.omit()
data_day2_pm10_peaks <- find_peaks(data_day2_pm10, "PM10")
ggplot(data_day2_pm10, aes(x = TIME, y = PM10, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day2_pm10_peaks, aes(x = TIME, y = PM10, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day2_pm10_peaks, aes(x = TIME, y = PM10, label = format_label(PM10)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 10 Levels on Day 2", x = "Time", y = "PM 10 Level") +
  custom_theme

# PM 10 Levels on Day 3
data_day3_pm10 <- subset(data_pm, DAY == "Day 3") %>% na.omit()
data_day3_pm10_peaks <- find_peaks(data_day3_pm10, "PM10")
ggplot(data_day3_pm10, aes(x = TIME, y = PM10, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day3_pm10_peaks, aes(x = TIME, y = PM10, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day3_pm10_peaks, aes(x = TIME, y = PM10, label = format_label(PM10)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 10 Levels on Day 3", x = "Time", y = "PM 10 Level") +
  custom_theme

# PM 10 Levels on Day 4
data_day4_pm10 <- subset(data_pm, DAY == "Day 4") %>% na.omit()
data_day4_pm10_peaks <- find_peaks(data_day4_pm10, "PM10")
ggplot(data_day4_pm10, aes(x = TIME, y = PM10, color = LOCATION, group = LOCATION)) +
  geom_line() +
  geom_point(data = data_day4_pm10_peaks, aes(x = TIME, y = PM10, shape = Period), size = 4, stroke = 1.5) +  # Make symbols bolder
  geom_text(data = data_day4_pm10_peaks, aes(x = TIME, y = PM10, label = format_label(PM10)), vjust = -1, size = 3) +
  scale_x_datetime(limits = time_limits, breaks = time_breaks, date_labels = "%H:%M") +
  labs(title = "PM 10 Levels on Day 4", x = "Time", y = "PM 10 Level") +
  custom_theme

#co2 levels day1 to day5
# Load Required Packages ------
pacman::p_load(tidyverse, magrittr, scales, readxl, timetk, hms)

# Load data -----
# Define data path
fpath <- '/Users/qaisbello/Desktop/Project Data/combined data/ALL INDOOR VALUES REFORMATTED.xlsx'

# Read the data from the CO2 sheet
iaq_data_raw <- readxl::read_excel(fpath, sheet = "CO2") %>% 
  janitor::clean_names() %>% 
  mutate(time = hms::as_hms(time)) %>%
  mutate(datetime = date + time) %>% 
  arrange(datetime) %>%
  print()

# Clean data -----
iaq_data_clean <- iaq_data_raw %>% 
  group_by(day, location, session) %>% 
  summarise_by_time(
    .date_var = datetime,
    .by       = "minute",
    co2       = mean(co2),  # Use the co2 column for CO2 data
    .type     = "ceiling"
  ) %>% 
  ungroup() %>% 
  print()

# Ensure 'id' is numeric
plot_data <- iaq_data_clean %>%
  group_by(location) %>% 
  mutate(id = row_number()) %>% 
  mutate(id = as.numeric(id)) %>% 
  ungroup() %>% 
  print()

# Calculate average CO2 per location -----
avg_co2_per_location <- iaq_data_clean %>%
  group_by(location) %>%
  summarise(average_co2 = mean(co2, na.rm = TRUE))

# Define data to label the plot
label_dat <- plot_data %>%
  mutate(labels = format(datetime, "%d %b, %Y")) %>% 
  mutate(labels = paste0(day, " \n", labels)) %>% 
  group_by(location, day, labels) %>% 
  summarise(id = first(id), 
            co2 = first(co2),
            .y = Inf,
            .groups = "drop") %>% 
  print()

# Manually adjust y-limits based on location
plot_data <- plot_data %>%
  mutate(y_limits = case_when(
    location == "ELT" ~ 4000,  # Set custom limit for ELT
    TRUE ~ 2000  # Default limit for other locations
  ))

# Plot with ASHRAE guideline and Average CO2 levels -----
plt <- plot_data %>%
  ggplot(aes(x = id, y = co2, colour = location)) + 
  geom_line(linewidth = 0.75) +
  theme_bw() +
  
  # Facet by location with custom scaling for ELT
  facet_wrap(~location, scales = "free_y", nrow = 3) +  # free_y allows the y-axis to adjust differently
  
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = expansion(mult = c(0.0, 0.02)), breaks = seq(0, max(plot_data$id), 150)) +
  
  # Add horizontal line for ASHRAE guideline
  geom_hline(yintercept = 1000, linetype = "dotted", color = "red", size = 1.2) +  # Dotted line at 1000 ppm
  
  # Add "1000 PPM" label using annotate within the plot
  annotate("text", x = max(plot_data$id) - 50, y = 1050, label = "1000 PPM", color = "red", vjust = 2.5, hjust = 1.0, size = 4) +
  
  # Add thin line for average CO2 for each location
  geom_hline(data = avg_co2_per_location, aes(yintercept = average_co2), color = "blue", size = 0.7, linetype = "solid") +
  
  # Add vertical arrows and labels for average CO2, keeping them inside the plot
  geom_segment(data = avg_co2_per_location, aes(x = max(plot_data$id) - 30, xend = max(plot_data$id) - 30, y = average_co2, yend = average_co2 + 30), 
               arrow = arrow(length = unit(0.15, "inches")), color = "blue", linetype = "solid") +
  geom_text(data = avg_co2_per_location, aes(x = max(plot_data$id) - 30, y = average_co2 + 40, label = paste0("Avg CO2: ", round(average_co2, 2))), 
            color = "blue", vjust = 2.5, hjust = 1.0, size = 4, inherit.aes = FALSE) +
  
  # Add vertical lines to mark test days
  geom_vline(data = label_dat, aes(xintercept = id), linetype = 2, size = rel(0.5), color = "#2C3E50") +
  
  # Staggered labels to avoid overlap
  geom_text(data = label_dat, color = "#2C3E50",
            aes(x = id + 30, y = .y, vjust = 1.15, hjust = 0.00, label = labels), size = rel(3.2)) +
  
  theme(panel.grid.minor = element_blank(),
        strip.background = element_blank(),
        strip.text = element_text(size = 14, face = "bold"),
        text = element_text(size = 14),
        legend.position = "none") +
  
  labs(x = "Time [mins]", y = expression("CO"["2"] ~ "Concentration [ppm]"))

# Print the plot
print(plt)

# Save the plot with the required dimensions (8.73 cm * 15 cm)
ggsave(
  filename = "/Users/qaisbello/Desktop/Journals/chats/co2_levels_day1_to_day5_combined.png",
  plot = plt,
  width = 35,
  height = 20,
  units = "cm",
  dpi = 1000
)

#pm2.5 levels day1 to day5
# Load Required Packages ------
pacman::p_load(tidyverse, magrittr, scales, readxl, timetk, hms)

# Load data -----
# Define data path
fpath <- '/Users/qaisbello/Desktop/Project Data/combined data/ALL INDOOR VALUES REFORMATTED.xlsx'

# Read the data from the PM sheet for PM2.5
iaq_data_raw <- readxl::read_excel(fpath, sheet = "PM") %>% 
  janitor::clean_names() %>% 
  mutate(time = hms::as_hms(time)) %>%
  mutate(datetime = date + time) %>% 
  arrange(datetime) %>%
  print()

# Filter data for PM2.5
iaq_data_raw <- iaq_data_raw %>%
  filter(!is.na(pm2_5))  # Filter out missing values for PM2.5

# Clean data -----
# Find the average of repetitive values of PM2.5 per minute
iaq_data_clean <- iaq_data_raw %>% 
  group_by(day, location, session) %>% 
  summarise_by_time(
    .date_var = datetime,
    .by       = "minute",
    pm2_5     = mean(pm2_5),  # Use the pm2_5 column for PM2.5 data
    .type     = "ceiling"
  ) %>% 
  ungroup() %>% 
  print()

# Calculate average PM2.5 per location -----
avg_pm2_5_per_location <- iaq_data_clean %>%
  group_by(location) %>%
  summarise(average_pm2_5 = mean(pm2_5, na.rm = TRUE))

print(avg_pm2_5_per_location)  # Display the calculated average PM2.5 per location

# Define plot data
plot_data <- iaq_data_clean %>%
  group_by(location) %>% 
  mutate(id = row_number()) %>% 
  mutate(id = lag(id, default = 0)) %>% 
  ungroup() %>% 
  print()

# Define data to label the plot
label_dat <- plot_data %>%
  mutate(labels = format(datetime, "%d %b, %Y")) %>% 
  mutate(labels = paste0(day, " \n", labels)) %>% 
  group_by(location, day, labels) %>% 
  summarise(id = first(id), 
            pm2_5 = first(pm2_5),
            .y = Inf,
            .groups = "drop") %>% 
  print()

# Plot with WHO guideline and Average PM2.5 levels -----
plt <- plot_data %>%
  ggplot(aes(x = id, y = pm2_5, colour = location)) + 
  geom_line(linewidth = 0.75) +
  theme_bw() +
  facet_wrap(~location, scales = "free", nrow = 3) +
  scale_y_continuous(expand = expansion(mult = c(0.01, 0.25))) +
  coord_cartesian(clip = "off") +
  scale_x_continuous(
    expand = expansion(mult = c(0.0, 0.02)),
    breaks = seq(0, max(plot_data$id), 150)) +
  
  # Add horizontal line for WHO guideline
  geom_hline(yintercept = 15, linetype = "dotted", color = "red", size = 1.2) +  # Dotted line at 15 µg/m³
  
  # Add the "15 µg/m³" label for WHO guideline
  annotate("text", x = max(plot_data$id) - 50, y = 15 + 0.5, label = "WHO guideline: 15 µg/m³", color = "red", vjust = -1, hjust = 1.0, size = 4) +
  
  # Add vertical lines to mark test days
  geom_vline(
    data = label_dat, 
    aes(xintercept = id), 
    linetype = 2, 
    size = rel(0.5),
    color = "#2C3E50") +
  
  geom_text(
    data = label_dat, color = "#2C3E50",
    aes(x = id + 20, y = .y, vjust = 1.15, hjust = 0.00,
        label = labels),
    size = rel(3.2)
  ) +
  
  # Add thinner horizontal lines for average PM2.5 per location
  geom_hline(data = avg_pm2_5_per_location, aes(yintercept = average_pm2_5), linetype = "solid", color = "blue", size = 0.5) +  # Thinner average PM2.5 line
  
  # Add text labels next to average lines
  geom_text(
    data = avg_pm2_5_per_location, aes(x = Inf, y = average_pm2_5, label = paste0("Avg PM2.5: ", round(average_pm2_5, 2))), 
    color = "blue", vjust = 4.5, hjust = 1.2, size = 4, inherit.aes = FALSE
  ) +
  
  # Remove plot title
  theme(panel.grid.minor = element_blank(),
        strip.background = element_blank(),
        strip.text = element_text(size = 14, face = "bold"),
        text = element_text(size = 14),
        legend.position = "none") +
  labs(
    x = "Time [mins]",
    y = "PM2.5 Concentration [µg/m³]"
  )

# Print the plot
print(plt)

# Save the plot with adjusted dimensions
ggsave(
  filename = "/Users/qaisbello/Desktop/Journals/chats/pm2_5_levels_day1_to_day5_with_who_avg_no_title.png",
  plot = plt,
  width = 35,
  height = 50,
  units = "cm",
  dpi = 1000
)


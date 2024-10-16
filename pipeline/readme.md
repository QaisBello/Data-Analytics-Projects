```markdown
# Lake Mendota Temperature Prediction Model Comparison

## Overview
This project evaluates and visualizes the performance of three different models used to predict the temperature of Lake Mendota: **Process-Based (PB)**, **Deep Learning (DL)**, and **Process-Guided Deep Learning (PGDL)**. The script compares the models' performance based on their **Root Mean Squared Error (RMSE)** and visualizes the results in a plot.

## Technologies Used
- **R**: For data manipulation, analysis, and plotting.
  - Libraries used:
    - `dplyr`: For data wrangling and transformations.
    - `readr`: For reading CSV files.
    - `stringr`: For string manipulations.
    - `sbtools`: To download data from ScienceBase.
    - `whisker`: For rendering text templates with dynamic data.

## Steps Performed in the Script

### 1. **Setting Up the Project Directory**
```r
project_output_dir <- 'my_dir'
dir.create(project_output_dir)
```
This creates a directory called `my_dir` where all outputs, including figures and CSV files, will be saved.

### 2. **Downloading the Model Performance Data**
```r
mendota_file <- file.path(project_output_dir, 'model_RMSEs.csv')
item_file_download('5d925066e4b0c4f70d0d0599', names = 'me_RMSE.csv', destinations = mendota_file, overwrite_file = TRUE)
```
Here, the script downloads the **model_RMSEs.csv** file, which contains the RMSE (Root Mean Squared Error) values of the different models. The data is fetched from ScienceBase and saved locally in the project directory.

### 3. **Data Cleaning and Preparation**
```r
eval_data <- readr::read_csv(mendota_file, col_types = 'iccd') %>%
  filter(str_detect(exper_id, 'similar_[0-9]+')) %>%
  mutate(col = case_when(
    model_type == 'pb' ~ '#1b9e77',
    model_type == 'dl' ~'#d95f02',
    model_type == 'pgdl' ~ '#7570b3'
  ), pch = case_when(
    model_type == 'pb' ~ 21,
    model_type == 'dl' ~ 22,
    model_type == 'pgdl' ~ 23
  ), n_prof = as.numeric(str_extract(exper_id, '[0-9]+')))
```
This step filters the dataset to include only relevant experiments and adds color (`col`) and marker shape (`pch`) columns for each model type (PB, DL, PGDL). It also extracts the number of training profiles used in the experiments and stores it as `n_prof`.

### 4. **Generating the Plot**
```r
png(file = file.path(project_output_dir, 'figure_1.png'), width = 8, height = 10, res = 200, units = 'in')
```
A PNG image is generated to visualize the RMSE (model error) as a function of the number of training profiles used.

- **Axes Setup**: 
```r
plot(NA, NA, xlim = c(2, 1000), ylim = c(4.7, 0.75),
     ylab = "Test RMSE (°C)", xlab = "Training temperature profiles (#)", log = 'x', axes = FALSE)
axis(1, at = c(-100, n_profs, 1e10), labels = c("", n_profs, ""), tck = -0.01)
axis(2, at = seq(0,10), las = 1, tck = -0.01)
```
This defines the x-axis as the number of training temperature profiles (with a logarithmic scale) and the y-axis as the test RMSE values.

- **Adding Model Data**:
```r
for (mod in c('pb','dl','pgdl')){
  mod_data <- filter(eval_data, model_type == mod)
  ...
  points(d$x + tail(offsets[[mod]], nrow(d)), d$y, pch = d$pch[1], col = d$col[1], bg = 'white', lwd = 2.5, cex = 1.5)
}
```
For each model (PB, DL, PGDL), the script plots the minimum and maximum RMSE values as lines and the mean RMSE values as points. Different colors and point shapes are used for each model.

- **Legend**: The script adds a legend to label each model on the plot, explaining the color and marker for PB, DL, and PGDL models.

### 5. **Saving the Results**
- The processed data is saved back into a CSV file for future analysis.
```r
readr::write_csv(eval_data, path = file.path(project_output_dir, 'model_summary_results.csv'))
```

### 6. **Generating a Text Summary**
- The script calculates and summarizes the mean RMSE for different training profile sizes (e.g., 980 profiles, 500 profiles, etc.) for each model.
```r
render_data <- list(
  pgdl_980mean = filter(eval_data, model_type == 'pgdl', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
  dl_980mean = filter(eval_data, model_type == 'dl', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2),
  pb_980mean = filter(eval_data, model_type == 'pb', exper_id == "similar_980") %>% pull(rmse) %>% mean %>% round(2)
  ...
)
```
This data is then used to fill a text template, describing how the models performed based on the number of training profiles.

### 7. **Rendering the Text Summary**
```r
whisker.render(template_1 %>% str_remove_all('\n') %>% str_replace_all('  ', ' '), render_data) %>% cat(file = file.path(project_output_dir, 'model_diagnostic_text.txt'))
```
Finally, the rendered text summary is saved to a file (`model_diagnostic_text.txt`). The text explains how each model performed at different training profile levels, highlighting which model was more accurate.

## Summary of Results
- The **PGDL model** generally performs better across different training profile sizes, with more robust prediction accuracy.
- The **DL model** outperforms the **PB model** when trained on larger datasets (500 profiles or more), but its performance drops below that of the PB model with smaller training sets (100 profiles or fewer).
- These insights can help guide model selection depending on the available training data.

## Outputs
- `figure_1.png`: Visualization of the model performance (RMSE vs. training profiles).
- `model_summary_results.csv`: Summary data of model performance.
- `model_diagnostic_text.txt`: Text summary of model performance insights.

```

This version explains each section of the code and provides an overview of what the script accomplishes. You can add links to the data or repository files if you want to provide further details or examples.

# Shiny Load Test Results

The full materials and data for the talk are available at https://github.com/slopp/shinyloadtest-result. The best place to start is the [video of the talk](https://rstudio.com/resources/webinars) as well as the pdf slides.

The contents of the repo are as follows:

- **slides.pdf**: Slides from the talk
- **recorder**: Mac binary of the shinyloadtest recorder. The shinyloadtest software will be released separately, this binary is for historical reproducibility only.
- **player**: The Java jar file used for playback. The shinyloadtest software will be released separately, this jar file is for historical reproducibility only.
- **beep.R**: R code to help record a test with "normal" user pauses.
- **analyse.R**: Helper functions to analyse the playback logs.
- **results.R**: Main script which produces the result plots in `slides.pdf`.
- **result_data.RData**: Data which can be generated from `results.R`, serialized to save time.
- **15min.log**: Recording file that produced the result data.
- **Result data**: Folders with the playback logs. One folder per test. Named `<users>_<cores>`.

Testing infrastructure is documented in the [shinyloadtest-cloud](https://github.com/rstudio/shinyloadtest-cloud) repo.

The application used in the tests is available at: https://github.com/wch/shiny_demo.


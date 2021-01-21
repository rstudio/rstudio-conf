# Files

The files in this repository allow for users to perform an in-depth analysis of the COMPAS data using drake, tidymodels, iml, and a number of hand-rolled functions that _probably_ ought to be turned into a package.

* `plan.R` has the code for building and executing the `drake` functions that analyze the COMPAS data
* `setup/helpers.R` contains the functions necessary for running `plan.R`
* `setup/packages.R` contains the packages necessary for running `plan.R` 

Slides will be uploaded to this repo once I manage to recover them from the boot looping laptop they are locked away within. Always back up your data, folks!

## Resources for learning more

### Survey Papers on methods

* [Survey on bias and fairness in ML (2019)](https://arxiv.org/abs/1908.09635)
* [One Explanation Does Not Fit All: A Toolkit and Taxonomy (2019)](https://arxiv.org/abs/1909.03012)
* [Explainable Deep Learning: A Field Guide for the Uninitiated (2020)](https://arxiv.org/abs/2004.14545)
* [Ethical Machine Learning in Health Care (2020)](https://arxiv.org/abs/2009.10576)
* [Fairness in Criminal Justice Risk Assessments: The State of the Art (2017)](https://arxiv.org/abs/1703.09207)

### Short articles

* [How our data encodes systematic racism, by Deborah Raji](https://www.technologyreview.com/2020/12/10/1013617/racism-data-science-artificial-intelligence-ai-opinion/)
* [The true dangers of AI are closer than we think, by William Isaac](https://www.technologyreview.com/2020/10/21/1009492/william-isaac-deepmind-dangers-of-ai/)
* [Why Are We Using Black Box Models in AI When We Don't Need To? By Cynthia Rudin and Joanna Radin](https://hdsr.mitpress.mit.edu/pub/f9kuryi8/release/6)

### Free books

* [Christoph Molnar's _Interpretable Machine Learning_](https://christophm.github.io/interpretable-ml-book/)
* [Barocas, Hardt, and Narayanan's _Fairness and Machine Learning_](https://fairmlbook.org/)


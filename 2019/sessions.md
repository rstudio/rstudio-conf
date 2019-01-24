# rstudio-conf 2019

Three conference tracks helped us cover all of the amazing and important changes in data science with R and RStudio. below are all of the materials currently available.

___

## Day 1

Welcome + RStudio Vision<br>
Speaker: Tareef Kawaf - [twitter](https://twitter.com/tareefk), [linkedin](https://www.linkedin.com/in/tareefk/)
<details><summary>Abstract</summary>
<p>
</p>
</details><br>

**Keynote 1** - [Shiny in production: Principles, practices, and tools](https://speakerdeck.com/jcheng5/shiny-in-production)<br>
Speaker: Joe Cheng - [twitter](https://twitter.com/jcheng),	[github](https://github.com/jcheng5), [linkedin](https://www.linkedin.com/in/jcheng/)
<details><summary>Abstract</summary>
<p>
Shiny is a web framework for R, a language not traditionally known for web frameworks, to say the least. As such, Shiny has always faced questions about whether it can or should be used “in production”. In this talk we’ll explore what “production” even means, review some of the historical obstacles and objections to using Shiny for production purposes, and discuss practices and tools that can help your Shiny apps flourish.
</p>
</details><br>

Session 1 / Interop / Ursa Labs and Apache Arrow in 2019<br>
Speaker: Wes	McKinney - 	[website](http://wesmckinney.com/),	[twitter](https://twitter.com/wesmckinn),	[github](https://github.com/wesm),	[linkedin](https://www.linkedin.com/in/wesmckinn/)
<details><summary>Abstract</summary>
<p>
For the last 3 years, the Apache Arrow project has been developing a language-independent open standard in-memory format for tabular data and a library ecosystem that builds on top of the format. In this talk I will discuss the current status of the project and Ursa Labs, a new not-for-profit development group we founded to focus on Arrow development. I will give a preview of our Arrow development roadmap for 2019 and things that the R community can look forward to.
</p>
</details><br>

Session 1 / professional / [Push straight to prod: API development with R and Tensorflow at T-Mobile](https://nolisllc.com/assets/presentations/r-tensorflow-api.pdf)<br>
Speaker: Jacqueline	Nolis - [website](https://nolisllc.com/), [twitter](https://twitter.com/skyetetra),	[github](https://github.com/jnolis), [linkedin](https://www.linkedin.com/in/jnolis/)<br>
Speaker: Heather	Nolis	- [website](https://nolisllc.com/),	[twitter](https://twitter.com/heatherklus), [github](https://github.com/nolistic),	[linkedin](https://www.linkedin.com/in/heatherwensler/)
<details><summary>Abstract</summary>
<p>
When tasked with creating the first customer-facing machine learning model at T-Mobile, we were faced with a conundrum. We had been told time and time again to deploy machine learning models in production you had to use Python, but our very best data scientists were fluent in building neural networks in R with Keras and TensorFlow. Determined to avoid double work, we decided to use R in production for our machine learning models. After months of work, wrangling our containers to meet cloud security compliance, and conforming to DevOps standards, we succeeded in creating a containerized API solution using the keras and plumber R packages and Docker. Today R is actively powering tools that our customers directly interact with and we have open sourced our methods. In this talk, we'll walk through how to deploy R models as container-based APIs, the struggles and triumphs we've had using R in production, and how you can design your teams to optimize for this sort of innovation.
</p>
</details><br>

Session 1 / tidyverse-ext / [A guide to modern reproducible data science with R](https://github.com/karthik/rstudio2019)<br>
Speaker: Karthik	Ram	[website](http://karthik.io/), [twitter](https://twitter.com/_inundata),	[linkedin](https://www.linkedin.com/in/karthik-ram-93334954/)
<details><summary>Abstract</summary>
<p>Have you ever had a challenging time cloning someone's data analysis repo and easily re-running the analysis without fiddling with missing packages, mismatched versions, external dependencies, unavailable data or a whole host of other issues? Would you like your own work to be reproducible where someone else can access your data, code, workflow, models and provenance and easily re-create your results without consulting you? Then this is the talk for you. You'll learn about creating custom computing environments that can be shared and instantly with remote users, packaging small to medium data inside and outside packages, and creating simple to complex workflows to track the provenance of your results.
</p>
</details><br>


Session 1 / interop / [New Language Features in RStudio 1.2](https://github.com/jmcphers/rstudio-1.2-features)<br>
Speaker: Jonathan McPherson -	[twitter](https://twitter.com/jmcphers), [github](https://github.com/jmcphers), [linkedin](https://www.linkedin.com/in/jonathanmcpherson/)
<details><summary>Abstract</summary>
<p>RStudio 1.2 dramatically improves support for many languages frequently used alongside R in data science projects, including SQL, D3, Stan, and Python. In this talk, you'll learn how to use RStudio 1.2's new language features to work more efficiently and fluidly in multi-lingual projects.
</p>
</details><br>

Session 1 / professional / [R in Production](https://rinprod.com/)<br>
Speaker: Mark Sellors - [website](https://www.mango-solutions.com/), [twitter](https://twitter.com/sellorm), [linkedin](https://www.linkedin.com/in/msellors/)
<details><summary>Abstract</summary>
<p>With the increase in people using R for data science comes an associated increase in the number of people and organisations wanting to put models or other analytic code into "production". We often hear it said that R isn't suitable for production workloads, but is that true? In this talk, Mark will look at some of the misinformation around the idea of what "putting something into production" actually means, as well as provide tips on overcoming the obstacles put in your path.
</p>
</details><br>

Session 1 / tidyverse-ext / [Solving R for Data Science](https://github.com/jrnold/r4ds-exercise-solutions)<br>
Speaker: Jeffrey Arnold - [website](https://jrnold.me/), [twitter](https://twitter.com/jrnld), [linkedin](https://www.linkedin.com/in/jrnold/)
<details><summary>Abstract</summary>
<p>While teaching a course using "R for Data Science", I wrote a complete set of solutions to its exercises and posted them on GitHub. Then other people started finding them. And now I'm here. In this talk, I'll discuss why I did it, and what I learned from the process, both what I learned about the tidyverse itself, and what I learned from teaching it.
</p>
</details><br>

Session 1 / interop / [Databases using R: The latest](https://github.com/edgararuiz/databases-w-r)<br>
Speaker: Edgar Ruiz - [twitter](https://twitter.com/theotheredgar), [github](https://github.com/edgararuiz), [linkedin](https://www.linkedin.com/in/edgararuiz/)
<details><summary>Abstract</summary>
<p>Learn about the latest packages and techniques that can help you access and analyze data found inside databases using R. Many of the techniques we will cover are based on our personal and the community’s experiences of implementing concepts introduced last year, such as offloading most of the data wrangling to the database using dplyr, and using the RStudio IDE to preview the database’s layout and data. Also, learn more about the most recent improvements to the RStudio products that are geared to aid developers in using R with databases effectively.
</p>
</details><br>

Session 1 / professional / [RStudio Connect: Past, Present, and Future](http://rstd.io/rsc170)<br>
Speaker: Jeff Allen - [website](https://www.rplumber.io), [twitter](https://twitter.com/TrestleJeff), [github](https://github.com/trestletech), [linkedin](https://www.linkedin.com/in/jeffreydallen1/)
<details><summary>Abstract</summary>
<p>RStudio Connect is a publishing platform that helps to operationalize the data science work you're doing. We'll review the current state of Connect including its ability to host Shiny applications and Plumber APIs, schedule and render R Markdown documents, and manage access. Then we'll unveil some exciting new features that we've been working on, and give you a sneak peek at what's coming up next.
</p>
</details><br>

Session 1 / tidyverse-ext / [Box plots: A case study in debugging and perseverance](https://github.com/karawoo/2019-01-17-rstudioconf) ([the PR of interest](https://github.com/tidyverse/ggplot2/pull/2196))<br>
Speaker: Kara Woo -	[website](http://accidental-art.tumblr.com), [twitter](https://twitter.com/kara_woo), [github](https://github.com/karawoo), [linkedin](https://www.linkedin.com/in/karawoo/)
<details><summary>Abstract</summary>
<p>Come on a journey through pull request #2196. What started as a seemingly simple fix for a bug in ggplot2's box plots developed into an entirely new placement algorithm for ggplot2 geoms. This talk will cover tips and techniques for debugging, testing, and not smashing your computer when dealing with tricky bugs.
</p>
</details><br>

Session 1 / interop / Configuration Management Tools for the R Admin<br>
Speaker: Kelly O’Briant - [website](https://kellobri.github.io),	[twitter](https://twitter.com/kellrstats), [linkedin](https://www.linkedin.com/in/kellyobriant/)
<details><summary>Abstract</summary>
<p>This talk will feature an introduction to configuration management tools for the Analytic Administrator. An analytic admin is someone who is invested in continually improving analytic infrastructure, advocates for best practices in data product deployments, and acts to adopt DataOps philosophies in their organization. One of the biggest challenges for an analytic admin can be figuring out how to help IT groups develop core competencies around the management of R tooling. When IT groups are unfamiliar with R, they might lean heavily on the analytic admin for guidance or resist adoption entirely. Data science teams that rely on delivering results through integrated R based solutions can get blocked when they lack the full support of IT. I’ll present a roadmap for how analytic admins can create custom teaching tools for introducing the R toolchain. Using these strategies, a dash of creativity, and a little bit of empathy, I hope you can get the IT buy-in you’ll need to make R a fully legitimate part of your organization.
</p>
</details><br>

Session 1 / professional / [RStudio Package Manager](https://github.com/slopp/rspm-rstudioconf)<br>
Speaker: Sean Lopp - [twitter](https://twitter.com/lopp_sean), [github](https://github.com/slopp), [linkedin](https://www.linkedin.com/in/sean-lopp-86301368)
<details><summary>Abstract</summary>
<p>RStudio Package Manager is the newest professional product that helps teams, departments, and entire enterprises organize and centralize package management. If you've ever struggled with IT to get access to a new (any?) R package, reproduce an old result, or share your code with others, RStudio Package Manager can help! We'll introduce the new product, discuss how R repositories can be used to solve problems and take a sneak peek at what is coming in 2019.
</p>
</details><br>

Session 1 / tidyverse-ext / [Working with categorical data in R without losing your mind](http://www.amelia.mn/WranglingCats.pdf) ([related paper](http://bitly.com/WranglingCats) from the [DSS collection](https://peerj.com/collections/50-practicaldatascistats/))<br>
Speaker: Amelia McNamara -	[website](http://www.science.smith.edu/~amcnamara/), 	[twitter](https://twitter.com/AmeliaMN), [github](https://github.com/AmeliaMN), 	[linkedin](https://www.linkedin.com/in/ameliamcnamara/)
<details><summary>Abstract</summary>
<p>Categorical data, called “factor” data in R, presents unique challenges in data wrangling. R users often look down at tools like Excel for automatically coercing variables to incorrect datatypes, but factor data in R can produce very similar issues. The stringsAsFactors=HELLNO movement and standard tidyverse defaults have moved us away from the use of factors, but they are sometimes still necessary for analysis. This talk will outline common problems arising from categorical variable transformations in R, and show strategies to avoid them, using both base R and the tidyverse (particularly, dplyr and forcats functions).
</p>
</details><br>

## Session 2
Session 2 / applications / R at the ACLU: joining tables to reunite families<br>
Speaker: Brooke Watson -	[website](https://blog.brooke.science/), 	[twitter](https://twitter.com/brooklynevery1), 	[github](https://github.com/brooke-watson), 	[linkedin](https://www.linkedin.com/in/brookewatson1/)
<details><summary>Abstract</summary>
<p>Last year, over 2500 immigrant children were separated from their family while in government custody. Information about their status is scattered across several government agencies, and throughout the national class-action lawsuit “Ms. L vs ICE,” the Analytics team of the ACLU has been using R to join, deduplicate, validate, and analyze it. Using specifics of this case, this talk will address common challenges arising from human-generated data in spreadsheets. With generalizable examples, I will discuss data tidying, standardization, deduplication, and validation using the tidyverse, janitor, assertthat, and other packages. Finally, I will share best practices for requesting useful data from non-quantitative subject matter experts.
</p>
</details><br>

Session 2 / distributed / RStudio Job Launcher: Changing where we run R stuff<br>
Speaker: Darby	Hadley - [website](https://github.com/dfalty), 	[twitter](https://twitter.com/dfalt), 			[linkedin](https://www.linkedin.com/in/darby-hadley-7670515/)
<details><summary>Abstract</summary>
<p>RStudio Job Launcher provides the ability to start processes within batch processing systems and container orchestration platforms. In this talk, we will explore what is possible when you have the ability to launch containerized R sessions including scaling, isolating, and customizing environments. We will review examples of launching ad-hoc jobs as well as dockerized R sessions in Kubernetes using the Job Launcher.
</p>
</details><br>

Session 2 / teaching / R4DS online learning community<br>
Speaker: Jesse Mostipak -	[website](https://www.jessemaegan.com/),	[twitter](https://twitter.com/kierisi), [github](https://github.com/jmostipak), 	[linkedin](https://www.linkedin.com/in/jesse-mostipak-02647826/)
<details><summary>Abstract</summary>
<p>R4DS online learning community: improvements to self-taught data science & the critical need for diversity, equity, and inclusion in data science education. The first iteration of the R4DS Online Learning Community was created as an online space for learners and mentors to gather and work through the "R for Data Science" text in a collaborative and supportive environment. The creation of this group was inspired by my own success in transitioning to a career in data science coupled with the resources that I wanted to see in the R programming space. This talk will go through the learnings of creating an online learning space focused on R programming for data science, and how future iterations of similar groups can more proactively center on bringing about diversity, equity, and inclusion to data science spaces.
</p>
</details><br>

Session 2 / applications / [Building an A/B Testing Analytics System with R + Shiny](http://bit.ly/rstudio19)<br>
Speaker: Emily Robinson -	[website](https://robinsones.github.io/),	[twitter](https://twitter.com/robinson_es), [github](https://github.com/robinsones),	[linkedin](https://www.linkedin.com/in/robinsones/)
<details><summary>Abstract</summary>
<p>Online experimentation, or A/B Testing, is the gold standard for measuring the effectiveness of changes to a website. While A/B testing is used at tens of thousands of companies, it can seem difficult to parse without resorting to expensive end-to-end commercial options. Using DataCamp’s system as an example, I’ll illustrate how R is actually a great language for building powerful analytical and visualization A/B testing tools. We’ll first dive into our open-source funneljoin package, which allows you to quickly analyze sequential actions using different types of behavioral funnels. We'll then cover the importance of setting up health checks for every experiment. Finally, we'll see how Shiny dashboards can help people monitor and quickly analyze multiple A/B tests each week.
</p>
</details><br>

Session 2 / distributed / [Scaling R with Spark](https://github.com/rstudio/rstudio-conf/tree/master/2019/Scaling%20R%20with%20Spark%20-%20Javier%20Luraschi)<br>
Speaker: Javier Luraschi - [twitter](https://twitter.com/javierluraschi), [github](https://github.com/javierluraschi),	[linkedin](https://www.linkedin.com/in/javier-luraschi-45ba7224)
<details><summary>Abstract</summary>
<p>This talk introduces new features in sparklyr that enable real-time data processing, brand new modeling extensions and significant performance improvements. The sparklyr package provides an interface to Apache Spark to enable data analysis and modeling in large datsets through familiar packages like dplyr and broom.
</p>
</details><br>

Session 2 / teaching / [Teaching data science with puzzles](https://github.com/isteves/ds-puzzles)<br>
Speaker: Irene Steves -	[website](https://irene.rbind.io/), [twitter](https://twitter.com/i_steves),	[github](https://github.com/isteves), [linkedin](https://www.linkedin.com/in/irene-steves-03687a70/)
<details><summary>Abstract</summary>
<p>Of the many coding puzzles on the web, few focus on the programming skills needed for handling untidy data. During my summer internship at RStudio, I worked with Jenny Bryan to develop a series of data science puzzles known as the "Tidies of March." These puzzles isolate data wrangling tasks into bite-sized pieces to nurture core data science skills such as importing, reshaping, and summarizing data. We also provide access to puzzles and puzzle data directly in R through an accompanying Tidies of March package. I will show how this package models best practices for both data wrangling and project management.
</p>
</details><br>

Session 2 / applications / [The Future's Shiny: Dashboards for Pioneering Genomic Medicine in R](https://github.com/thisisnic/rstudio-conf-2019)<br>
Speaker: Nic Crane - [website](https://www.datacamp.com/instructors/ncrane),	[twitter](https://twitter.com/nic_crane),	[github](https://thisisnic.github.io/)	[linkedin](https://www.linkedin.com/in/nicolacrane/)
<details><summary>Abstract</summary>
<p>Shiny’s expanding capabilities are rapidly transforming how it is used in an enterprise. This talk details the creation of a large-scale application, supporting hundreds of concurrent users, making use of the future and promises packages. The 100,000 genomes project is an ambitious exercise that follows on from the Human Genome Project - aiming to put the UK at the forefront of genomic medicine, with the NHS as the first health service in the world to offer precision medicine to patients with rare diseases and cancer. Data is at the heart of this project; not only the outputs of the genomic sequencing, but vast amounts of metadata used to track progress against the 100,000 genome target and the status and path of each case through the sample tracking pipeline. In order to make this data readily available to stakeholders, Shiny was used to create an application containing multiple interactive dashboards. A scaled-up version of the app is being rolled out in early 2019 to a much larger audience to support the National Genomics Informatics Service, with the challenge of creating a complex app capable of supporting so many users without grinding to a halt. In this talk, I will explain why Shiny was the obvious technology choice for this task, and discuss the design decisions which enabled this project's success.
</p>
</details><br>

Session 2 / distributed / Introducing mlflow<br>
Speaker: Kevin Kuo -	[website](http://kevinykuo.com/),	[twitter](https://twitter.com/kevinykuo), [github](https://github.com/kevinykuo), [linkedin](https://www.linkedin.com/in/kevinykuo/)
<details><summary>Abstract</summary>
<p>We introduce the R API for MLflow, which is an open source platform for managing the machine learning lifecycle. We demonstrate each component of the platform–Tracking, Projects, and Models–and describe how they can be leveraged in practical data science workflows.
</p>
</details><br>

Session 2 / teaching / [Introductory statistics with R: Easing the transition to software for beginner students](http://calpoly.edu/~kbodwin/RStudio_2019.html) ([github repo](http://github.com/kbodwin/Introductory-Statistics-Labs))<br>
Speaker: Kelly Nicole Bodwin - [website](https://web.calpoly.edu/~kbodwin/), [twitter](https://twitter.com/kellybodwin)<br>
Speaker: Hunter Glanz - [twitter](https://twitter.com/hglanz), [linkedin](https://www.linkedin.com/in/hunter-glanz-35567720/)
<details><summary>Abstract</summary>
<p>In this talk, we will present our approach to incorporating R and RStudio into a 10-week introductory statistics course for non-majors Cal Poly. Our primary contribution will be to share a series of Shiny Apps, created to ease students with no statistical or coding background into the philosophy of using programming tools to explore data. Our program was recently used in 3 sections of 35 students each this Fall, during which students were surveyed regularly for their reactions to the approach. We will demonstrate our new tools, discuss our successes and failures, share student-generated output, and summarize the results of our Fall survey.
</p>
</details><br>

Session 2 / applications / R Consortium Initiatives in Medicine<br>
Speaker: Joseph Rickert -	[website](https://rviews.rstudio.com/),	[twitter](https://twitter.com/rstudiojoe),	[github](https://github.com/joseph-rickert),	[linkedin](https://www.linkedin.com/in/joseph-rickert-a45a96/)
<details><summary>Abstract</summary>
<p>R / Pharma and R / Medicine, two new R Consortium sponsored conferences that appeared in 2018, are both grass roots, community-level manifestations of fundamental trends driving the growth of R. R / Pharma organized as an R Consortium working group by R users at several prominent pharmaceutical companies demonstrated that R has reached sufficient critical mass in Pharma to be recognized as a technology important enough to explore inter-company cooperation, while the addition of Genetech/Roche to R Consortium shows the commitment of upper level management to migrate from SAS to R. - At the other, non-corporate end of the spectrum, the R / Medicine conference was well attended by practicing clinicians coming to R, and in some cases statistics and data analysis, for the first time in order to move forward with the practice of data driven medicine. - In this talk, I will present some highlights from these conferences, and other related R Consortium initiatives, describe some of the R-based projects that illustrate the kind of work being done, and indicate what to expect this year.
</p>
</details><br>

Session 2 / distributed / [Democratizing R with Plumber APIs](https://bit.ly/2TXfFR5)<br>
Speaker: James Blair - [twitter](https://twitter.com/Blair09M), [github](https://github.com/blairj09), [linkedin](https://www.linkedin.com/in/blairjm/)
<details><summary>Abstract</summary>
<p>The Plumber package provides an approachable framework for exposing R functions as HTTP API endpoints. This allows R developers to create code that can be consumed by downstream frameworks, which may be R agnostic. In this talk, we’ll take an existing Shiny application that uses an R model and turn that model into an API endpoint so it can be used in applications that don’t speak R.
</p>
</details><br>

Session 2 / teaching / [Teaching R using inclusive pedagogy: Practices and lessons learned from over 700 Carpentries workshops](https://docs.google.com/presentation/d/1yZTOcm0hO3sq8nz24luNoxL2Tk4IWfwoeYSXa09-zB8/edit#slide=id.g4d9835a148_0_218)<br>
Speaker: Tracy Teal -	[website](http://idyll.org/~tracyt/), [twitter](https://twitter.com/tracykteal), [github](https://github.com/tracykteal), [linkedin](https://www.linkedin.com/in/tracy-teal-059136b/)
<details><summary>Abstract</summary>
<p>The Carpentries is an open, global community teaching researchers the skills to turn data into knowledge. Since 2012 we have taught 700+ R workshops & trained 1600+ volunteer instructors. Our workshops use evidence-based teaching, focus on foundational and relevant skills and create an inclusive environment. Teaching the tidyverse allows learners to start working with data quickly, and keeps them motivated to begin and sustain their learning. Our assessment show that these approaches have been successful in attracting diverse learners, building confidence & increasing coding usage. Through our train-the-trainer model and open, collaborative lessons, this approach scales globally to reach more learners and further democratize data.
</p>
</details><br>

# Session 3

Session 3 / modeling / [Solving the model representation problem with broom](https://buff.ly/2FGKFkj)<br>
Speaker: Alex Hayes - [website](http://www.alexpghayes.com),	[twitter](https://twitter.com/alexpghayes),	[github](https://github.com/alexpghayes),	[linkedin](https://www.linkedin.com/in/alexpghayes/)
<details><summary>Abstract</summary>
<p>The R objects used to represent model fits are notoriously inconsistent, making data analysis inconvenient and frustrating. The broom package resolves this issue by defining a consistent way to represent model fits. By summarizing essential information about fits in tidy tibbles, broom makes it easy to programmatically work with model objects. Combining broom with list-columns results in an especially powerful way to work with many model fits at once. This talk will feature several case studies demonstrating how broom resolves common problems in data analysis.
</p>
</details><br>

Session 3 / tidyverse-ext / [Melt the clock: Tidy time series analysis](https://slides.earo.me/rstudioconf19)<br>
Speaker: Earo Wang -	[website](https://earo.me/), 	[twitter](https://twitter.com/earowang),	[github](https://github.com/earowang)
<details><summary>Abstract</summary>
<p>Time series can be frustrating to work with, particularly when processing raw data into model-ready data. This work presents two new packages that address a gap in existing methodology for time series analysis (raised in rstudio::conf 2018). The tsibble package supports organizing and manipulating modern time series, leveraging tidy data principles along with contextual semantics: index and key. The tsibble data structure seamlessly flows into forecasting routines. The fable package is a tidy renovation of the forecast package. It promotes transparent forecasting practices and concise model representations, to empower analysts tackling a broad domain of forecasting problems. This collection of packages form the tidyverts, which facilitates a fluent and fluid workflow for analyzing time series.
</p>
</details><br>

Session 3 / workflow / Using R, the Tidyverse, H2O, and Shiny to Reduce Employee Attrition<br>
Speaker: Matt Dancho -	[website](https://www.business-science.io/),	[twitter](https://twitter.com/mdancho84), [github](https://github.com/mdancho84),	[linkedin](https://www.linkedin.com/in/mattdancho/)
<details><summary>Abstract</summary>
<p>An organization that loses 200 high-performing employees per year has a lost productivity cost of about $15M/year. This cost is massive, yet many organizations don’t know it exists. It doesn’t show up on a financial statement. Therefore, it goes unnoticed. This presentation showcases how several open source tools integrate to form a solution to the employee attrition problem. Specifically: (1) How the tidyverse enables problem identification through visualization. (2) How recipes + H2O can be combined to explain key relationships to attrition and predict employee attrition. (3) How Shiny can be used to create a powerful dashboard that empowers business leaders to make data-driven decisions across the organization.
</p>
</details><br>

Session 3 / modeling / [Why TensorFlow eager execution matters](https://github.com/skeydan/rstudio_conf_2019_eager_execution)<br>
Speaker: Sigrid Keydana -	[website](https://recurrentnull.wordpress.com), 	[twitter](https://twitter.com/zkajdan), 	[github](https://github.com/skeydan), 	[linkedin](https://www.linkedin.com/in/sigrid-keydana-9a16b410/)
<details><summary>Abstract</summary>
<p>In current deep learning with Keras and TensorFlow, when you've mastered the basics and are ready to dive into more involved applications (such as generative networks, sequence-to-sequence or attention mechanisms), you may find that surprisingly, the learning curve doesn't get much flatter. This is largely due to restrictions imposed by TensorFlow's traditional static graph paradigm. With TensorFlow Eager Execution, available since summer and announced to be the default mode in the upcoming major release, model architectures become more flexible, readable, composable, and last not least, debuggable. In this session, we'll see how with Eager, we can code sophisticated architectures like Generative Adversarial Networks (GANs) and Variational Autoencoders (VAEs) in a straightforward way.
</p>
</details><br>

Session 3 / tidyverse-ext / 3D mapping, plotting, and printing with rayshader<br>
Speaker: Tyler Morgan-Wall -	[website](http://www.tylermw.com/),	[twitter](https://twitter.com/tylermorganwall),	[github](https://github.com/tylermorganwall), 	[linkedin](https://www.linkedin.com/in/tyler-morgan-wall-88227015/)
<details><summary>Abstract</summary>
<p>Is there ever a place for the third dimension in visualizing data? Is the 3D pie chart truly bad, or just misunderstood? In this talk, I will show you how you can create beautiful 3D maps and visualizations with the rayshader package. In addition, I will talk about the value of 3D plotting, how interactions with the R community helped drive the development of rayshader, and how writing/blogging about your projects can vastly improve your code. And, of course—lots of beautiful 3D maps and figures.
</p>
</details><br>

Session 3 / workflow / [Empowering a data team with RStudio addins](http://bit.ly/rstudioaddin19) ([example/demo](https://github.com/hebrewseniorlife/addin_demo))<br>
Speaker: Hao Zhu	- [website](https://haozhu233.github.io/),	[twitter](https://twitter.com/haozhu233),	[github](https://github.com/haozhu233),	[linkedin](https://www.linkedin.com/in/haozhu233/)
<details><summary>Abstract</summary>
<p>RStudio addins provide a mechanism to extend RStudio in various ways. Addins can interact with the RStudio IDE through RStudio API. It can also provide users a graphical interface with the power of Shiny. In practice, we found it very useful for enhancing or streamlining interaction with data and computing infrastructure. In this talk, we will demonstrate how our team develops and uses RStudio addins to empower our work. You will see some internal tools created to help us manage database connections, and an addin which helps us access external cloud computing resources. We will also show an example of using the addins in rcrossref and citr to download and manage citation and literature databases during rmarkdown document development.
</p>
</details><br>

Session 3 / modeling / [parsnip - a tidy model interface](https://github.com/rstudio/rstudio-conf/tree/master/2019/Parsnip--Max_Kuhn)<br>
Speaker: Max Kuhn -	[website](http://appliedpredictivemodeling.com/about/),	[twitter](https://twitter.com/topepos),	[github](https://github.com/topepo),	[linkedin](https://www.linkedin.com/in/max-kuhn-864a9110/)
<details><summary>Abstract</summary>
<p>parsnip is a new tidymodels package that generalizes model interfaces across packages. The idea is to have a single function interface for types of specific models (e.g. logistic regression) that lets the user choose the computational engine for training. For example, logistic regression could be fit with several R packages, Spark, Stan, and Tensorflow. parsnip also standardizes the return objects and sets up some new features for some upcoming packages.
</p>
</details><br>

Session 3 / tidyverse-ext / [Spatial data science in the Tidyverse](https://edzer.github.io/rstudio_conf/2019/index.html)<br>
Speakers: Edzer Pebesma,  Michael Sumner,  Etienne Racine 
<details><summary>Abstract</summary>
<p>Package sf (simple feature) and ggplot2::geom_sf have caused a fast uptake of tidy spatial data analysis by data scientists. Important spatial data science challenges are not handled by them, including raster and vector data cubes (e.g. socio-economic time series, satellite imagery, weather forecast or climate predictions data), and out-of-memory datasets. Powerful methods to analyse such datasets have been developed in packages stars (spatiotemporal tidy arrays) and tidync (tidy analysis of NetCDF files). This talk discusses how the simple feature and tidy data frameworks are extended to handle these challenging data types, and shows how R can be used for out-of-memory spatial and spatiotemporal datasets using tidy concepts.
</p>
</details><br>

Session 3 / workflow / [R/qtl2: Rewrite of a very old R package](https://bit.ly/rstudio2019)<br>
Speaker: Karl Broman -	[website](https://kbroman.org),	[twitter](https://twitter.com/kwbroman), 	[github](https://github.com/kbroman)
<details><summary>Abstract</summary>
<p>For nearly 20 years, I've been developing, maintaining, and supporting an R package, R/qtl, for mapping quantitative trait loci (genetic loci that contribute to variation in quantitative traits, such as blood pressure) in experimental crosses (such as in mice). It's a rather large package, with 39k lines of R code, 24k lines of C code, and nearly 300 user-accessible functions. In the past several years, I've been working on rewriting the package, to better handle high-dimensional data and more complex experimental crosses. This has been a good opportunity to take advantage of many new tools, including Rcpp, Roxygen2, and testthat. I'll describe my efforts to avoid repeating the mistakes I made the first time around.
</p>
</details><br>
	
Session 3 / modeling /  [Visualizing uncertainty with hypothetical outcomes plots](https://docs.google.com/presentation/d/1zMuBSADaxdFnosOPWJNA10DaxGEheW6gDxqEPYAuado/edit?usp=sharing)<br>
Speaker: Claus Wilke -	[website](https://serialmentor.com/),	[twitter](https://twitter.com/clauswilke),	[github](https://github.com/clauswilke),	[linkedin](https://www.linkedin.com/in/clauswilke/)
<details><summary>Abstract</summary>
<p>Uncertainty is a key component of statistical inference. However, uncertainty is not easy to convey effectively in data visualizations. For example, viewers have a tendency to interpret visualizations of the most likely outcome as the only possible one. Viewers may also misjudge the likelihood of different possible outcomes or the extent to which moderately rare outcomes may deviate from the expectation. One way in which we can help the viewer grasp the amount of uncertainty present in a dataset is by showing a variety of different possible modeling outcomes at once. For example, in a linear regression, we could plot a number of different regression lines with slopes and intercepts drawn from the range of likely values, as determined by the variation in the data. Such visualizations are called Hypothetical Outcomes Plots (HOPs). HOPs can be made in static form, showing the various hypothetical outcomes all at once, or preferably in an animated form, where the display cycles between the different hypothetical outcomes. With recent progress in ggplot2-based animation, via gganimate, as well as packages such as tidybayes that make it easy to generate hypothetical outcomes, we can easily produce animated HOPs in a few lines of R code. This presentation will cover the key concepts, packages, and techniques to generate such visualizations.
</p>
</details><br>

Session 3 / tidyverse-ext / [gganimate live cookbook](https://www.data-imaginist.com/slides/rstudioconf2019/assets/player/keynotedhtmlplayer#0)<br>
Speaker: Thomas Lin Pedersen - [website](https://www.data-imaginist.com/),	[twitter](https://twitter.com/thomasp85),	[github](https://github.com/thomasp85),	[linkedin](https://www.linkedin.com/in/thomas-lin-pedersen-9b17572/)
<details><summary>Abstract</summary>
<p>Animation of data visualisation is becoming increasingly popular both as an attention grabber on social media and as a way to tell small data stories. gganimate is a package that extends ggplot2 for making animations and provides a grammar of animation on top of the grammar of graphics. This talk will quickly introduce gganimate, and then dive into a series of different animation and show how they were made and how they could be changed or expanded.
</p>
</details><br>

Session 3 / workflow / [Getting it right: Writing reliable and maintainable R code](https://github.com/rstudio/rstudio-conf/tree/master/2019/Testing_R_Code--Amanda_Gadrow)<br>
Speakers: Amanda Gadrow
<details><summary>Abstract</summary>
<p>How can you tell that your scripts, applications, and package functions are working as expected? Are you sure that when you make changes in one part of the code, it won't break something in another part? Have you thought deeply about how the consumers of your code (including Future You) will use it, maintain it, fix it, and improve it? Code quality is essential not only for reliable results but also for your script's maintainability and your users' satisfaction. Quality can be measured in part with targeted testing, and fortunately, there are several effective and easy-to-use code testing tools available in R. This talk will discuss some of the most useful testing packages, covering both concepts and examples.
</p>
</details><br>

---

# Day 2

**Keynote Two** - Explicit Direct Instruction in Programming Education<br>
Speaker: Felienne, LIACS – Universiteit Leiden - [website](http://www.felienne.com/),	[twitter](https://twitter.com/Felienne),	[github](https://github.com/Felienne),	[linkedin](https://www.linkedin.com/in/felienne/)
<details><summary>Abstract</summary>
<p>In education, there is and has always been debate about how to teach. One of these debates centers around the role of the teacher: should their role be minimal, allowing students to find and classify knowledge independently, or should the teacher be in charge of what happens in the classroom, explaining students all they need to know? These forms of teaching have many names, but the most common ones are exploratory learning and direct instruction respectively. While the debate is not settled, more and more evidence is presented by researchers that explicit direct instruction is more effective than exploratory learning in teaching language and mathematics and science. These findings raise the question whether that might be true for programming education too. This is especially of interest since programming education is deeply rooted in the constructionist philosophy, leading many programmers to follow exploratory learning methods, often without being aware of it. This talk outlines this history of programming education and additional beliefs in programming that lead to the prevalence of exploratory forms of teaching. We also explain the didactic principles of direct instruction, explore them in the context of programming, and hypothesize how it might look like for programming.
</p>
</details><br>

**Keynote Three** - [The unreasonable effectiveness of public work](https://bit.ly/drob-rstudio-2019)<br>
David Robinson, DataCamp - [website](http://varianceexplained.org/about/),	[twitter](https://twitter.com/drob), [github](https://gumroad.com/l/empirical-bayes),	[linkedin](https://www.linkedin.com/in/david-robinson-3584642a/)
<details><summary>Abstract</summary>
<p>In this talk, I'll lay out the reasons that blogging, open source contribution, and other forms of public work are a critical part of a data science career. For beginners, a blog is a great accompaniment to data science coursework and tutorials, since it gives you experience applying practical data science skills to real problems. For data scientists at any stage of their careers, open source development offers practice in collaboration, documentation, and interface design that complement other kinds of software development. And for data scientists more advanced in their careers, writing a book is a great way to crystallize your expertise and ensure others can build on it. All of these practices build skills in communication and collaboration that form an essential component of data science work. Each also lets you build a public portfolio of your skills, get feedback from your peers, and network with the larger data science community.
</p>
</details><br>

# Session 4

Session 4 / org-thinking / [Putting empathy in action: Building a `community of practice' for analytics in a global corporation](https://cerebralmastication.com/prez/rstudio_conf_2019_main.html)<br>
Speaker: James (JD) Long - [linkedin](https://www.linkedin.com/in/jamesdlong/)
<details><summary>Abstract</summary>
<p>JD Long, Vice President of Risk Management & Data Philosophy at the global reinsurer Renaissance Re will share his experience with creating a "Community of Practice" for analytics inside of a global corporation. The theme of "empathy" will be recurring as he discusses how he worked to create a supportive learning environment focused on helping analysts "kick ass" regardless of their tool set. This means creating a community that's supportive of Excel, SQL, Python, and, of course, R.
</p>
</details><br>

Session 4 / programming / pkgman: a fresh approach to package installation<br>
Speaker: Gábor Csárdi - [website](http://gaborcsardi.org),	[twitter](http://twitter.com/gaborcsardi),	[github](http://github.com/gaborcsardi),	[linkedin](https://www.linkedin.com/in/gaborcsardi/)
<details><summary>Abstract</summary>
<p>The main goals of pkgman is to make package installation fast and more reliable. This allows new, simpler and safer workflows, such as separate package libraries for projects. In this talk, we will show the features that make pkgman fast, convenient and reliable. Features that make pkgman fast: * Concurrency: pkgman performs all downloads, package builds and installations concurrently by default. * Metadata and package cache: pkgman caches all metadata and all downloaded and locally built packages in its cache. * Lazyness: pkgman only downloads and installs packages if needed. Features that make pkgman convenient: * BioC and GitHub packages are supported seamlessly. * Informative UI. pkgman can lay out the installation/update plan, that the user needs to confirm. It returns data about downloads, builds, installations, etc. Features that make pkgman reliable: * Dependency solver. pkgman makes sure that you end up in consistent, working state of dependencies. * Private library: pkgman's own dependencies do not affect your regular package library, and vice versa. pkgman does not load any packages from your regular library.
</p>
</details><br>

Session 4 / publication / [R Markdown: The bigger picture](https://github.com/garrettgman/rmarkdown-the-bigger-picture)<br>
Speaker: Garrett Grolemund - [twitter](https://twitter.com/StatGarrett),	[github](https://github.com/garrettgman),	[linkedin](https://www.linkedin.com/in/garrett-grolemund-49328411/)
<details><summary>Abstract</summary>
<p>Statistics has made science resemble math, so much so that we've begun to conflate p-values with mathematical proofs. We need to return to evaluating a scientific discovery by its reproducibility, which will require a change in how we report scientific results. This change will be a windfall to commercial data scientists because reproducible means repeatable, automatable, parameterizable, and schedulable.
</p>
</details><br>

Session 4 / org-thinking / The Resilient R Champion<br>
Speaker: Tonya Filz - [twitter](https://twitter.com/tonyafilz),	[github](https://github.com/tonyafilz), 	[linkedin](https://www.linkedin.com/in/tonyafilz/)
<details><summary>Abstract</summary>
<p>Merriam-Webster defines resilience as the ability to recover from or adjust easily to misfortune or change. As a Customer Success Representative who works alongside data scientists using RStudio’s toolchain, I’ve had a front row seat to the challenges faced by data scientists as they aim to promote the use of RStudio’s toolchain in their organization. This talk will focus on effective strategies that have been used to overcome some of the most difficult organizational barriers that are faced by data scientists using R. Specific topics will include funding barriers, IT support, server space, the “open source mentality”, and political pressures within organizations.
</p>
</details><br>

Session 4 / programming / [It depends: A dialog about dependencies](https://speakerdeck.com/jimhester/it-depends)<br>
Speaker:Jim Hester - 	[website](https://jimhester.com/),	[twitter](https://twitter.com/jimhester_),	[github](https://github.com/jimhester),	[linkedin](https://www.linkedin.com/in/jim-hester/)
<details><summary>Abstract</summary>
<p>Software dependencies can often be a double-edged sword. On one hand, they let you take advantage of others' work, giving your software marvelous new features and reducing bugs. On the other hand, they can change, causing your software to break unexpectedly and increasing your maintenance burden. These problems occur everywhere, in R scripts, R packages, Shiny applications and deployed ML pipelines. So when should you take a dependency and when should you avoid them? Well, it depends! This talk will show ways to weigh the pros and cons of a given dependency and provide tools for calculating the weights for your project. It will also provide strategies for dealing with dependency changes, and if needed, removing them. We will demonstrate these techniques with some real-life cases from packages in the tidyverse and r-lib.
</p>
</details><br>

Session 4 / publication / [pagedown: Creating beautiful PDFs with R Markdown and CSS](https://bit.ly/pagedown)
([pagedown github repo](https://github.com/rstudio/pagedown))<br>
Speaker: Yihui Xie - [website](https://bookdown.org/yihui/blogdown/),	[twitter](https://twitter.com/xieyihui),	[github](https://github.com/yihui),	[linkedin](https://www.linkedin.com/in/yihuixie/)
<details><summary>Abstract</summary>
<p>The traditional way to beautiful PDFs is often through LaTeX or Word, but have you ever thought of printing a web page to PDF? Web technologies (HTML/CSS/JavaScript) are becoming more and more amazing. It is entirely possible to create high-quality PDFs through Google Chrome or Chromium now. Web pages are usually single-page documents, but they can be paginated thanks to the JavaScript library Paged.js, so that you can have elements like headers, footers, and page margins for the printing purpose. In this talk, we introduce a new R package, pagedown (https://github.com/rstudio/pagedown), to create PDF documents based on R Markdown and Paged.js. Applications of pagedown includes, but not limited to, books, articles, posters, resumes, letters, and business cards. With the power of CSS and JavaScript, you can typeset your documents with amazing elegance (e.g., a single line of CSS, "tr:nth-child(even) { background: #eee; }", will give you a striped table, and "border-radius: 50%;" gives you a circular element) and power (e.g., HTML Widgets).
</p>
</details><br>

Session 4 / org-thinking / [Cultivating creativity in data work](https://www.slideshare.net/mobile/hilaryparker/rstudioconf2019l)<br>
Speaker: Hilary Parker - [website](http://nssdeviations.com/),	[twitter](https://twitter.com/hspter),	[github](https://github.com/hilaryparker),	[linkedin](https://www.linkedin.com/in/parkerhilary/)
<details><summary>Abstract</summary>
<p>Traditionally, statistical training has focused primarily on mathematical derivations, proofs of statistical tests, and the general correctness of what methods to use for certain applications. However, this is only one dimension of the practice of doing analysis. Other dimensions include the technical mastery of a language and tooling system, and most importantly the construction of a convincing narrative tailored to a specific audience, with the ultimate goal of them accepting the analysis. These "softer" aspects of analysis are difficult to teach, perhaps more so when the field is framed as mathematics and often housed in mathematics departments. In this talk, I discuss an alternative framework for viewing the field, borrowing upon the past work in other fields such as design. Looking forward, we as a field can borrow from these fields to cultivate and hone the creative lens so necessary to the success of applied work.
</p>
</details><br>

Session 4 / programming / [A preview of Rtools 4.0](https://jeroen.github.io/rstudio2019)<br>
Speaker: Jeroen Ooms - [twitter](https://twitter.com/opencpu	),	[linkedin](https://www.linkedin.com/in/datajeroen/)
<details><summary>Abstract</summary>
<p>Rtools is getting a major upgrade. In addition to the latest gcc, it now includes a full build system and package manager to build, install, and distribute external c/c++/fortran libraries needed by R packages. Thereby it bridges the long-standing gap between Windows and MacOS/Linux with respect to the availability of high quality, up-to-date system libraries. In this talk, we will show how to build and install system libraries with Rtools, and manage your Rtools build environment. It should be interesting both for Windows users as well as non-Windows package authors that are interested in reducing the pain of making things work on Windows.
</p>
</details><br>

Session 4 / publication / [Introducing the gt package](https://github.com/rich-iannone/presentations/tree/master/2019_01-19-rstudio_conf_gt)<br>
Speaker: Rich Iannone - [website](http://rich-iannone.github.io/DiagrammeR/),	[twitter](https://twitter.com/riannone),	[github](https://github.com/rich-iannone),	[linkedin](https://www.linkedin.com/in/richard-iannone-a5640017/)
<details><summary>Abstract</summary>
<p>With the gt package, anyone can make great-looking display tables. Though the package is still early in development, you can do some really great things with it right now! I'll walk through a few examples that touch upon the more common table-making use cases. These will include features like adding table parts, integrating footnotes, styling/transforming table cells, using tables in R Markdown documents, and even including gt tables in email messages.
</p>
</details><br>

Session 4 / org-thinking / [Data science as a team sport](https://github.com/angelabassa/rstudioconf-2019)<br>
Speaker: Angela Bassa -	[website](https://www.angelabassa.com),	[twitter](https://twitter.com/AngeBassa),	[github](https://github.com/angelabassa),	[linkedin](https://www.linkedin.com/in/angelabassa/)
<details><summary>Abstract</summary>
<p>How do you data science as a team sport? Oftentimes a data scientific initiative starts with just a single, lonesome data scientist. But when that germ of a team is successful and starts expanding, should the team be embedded in other disciplines or should it be centralized into its own function? Where should it live in the organizational structure? Should you focus on recruiting senior data scientists or is there a benefit to attracting junior talent as well? And in terms of capabilities, should you hold out for unicorns or hire several specialists to get all jobs done? Data scientists need to work on almost every aspect of a business, so how should a team composition set the data science discipline up for success? Great data scientists have career options and won’t abide bad managers for very long: if you want to retain them, you’ll need to care about their work, connect it to the business, and design a diverse, resilient, high-performing team.
</p>
</details><br>

Session 4 / programming / [Our colour of magic: The open sourcery of fantastic R packages](https://github.com/MilesMcBain/rstudioconf_talk)<br>
Speaker: Miles McBain - [twitter](https://twitter.com/milesmcbain),	[github](https://github.com/milesmcbain),	[linkedin](https://www.linkedin.com/in/miles-mcbain-58941365/)
<details><summary>Abstract</summary>
<p>What does it mean to say software is, to quote one Twitter user, ‘so f***ing magical!’? In the context of our popular community hobby of rating and sharing R packages, the term ‘magic’ seems reserved for our most powerful expressions of visceral approval. Why is this? And what does it say about how we value software? Can this magical quality be quantified? We will consider these questions in examination of magical specimens, and in the process reveal the surprising depths at which notions of magic are embedded in the R zeitgiest.
</p>
</details><br>

Session 4 / publication / [The lazy and easily distracted report writer: Using rmarkdown and parameterized reports](https://github.com/MikeKSmith/RStudioConf2019)<br>
Speaker: Mike K Smith - [twitter](https://twitter.com/mikeksmith),	[github](https://github.com/MikeKSmith),	[linkedin](https://www.linkedin.com/in/mike-k-smith-b200245/)
<details><summary>Abstract</summary>
<p>My brain is lazy, shallow and easily distracted. Learn how I use notebooks to keep my present-self organised, my future-self up to speed with what I was thinking months ago, and also how I use parameterised reports to share results for both quantitative and non-quantitative audiences across multiple endpoints. I can update and render outputs for a variety of outputs from a single markdown notebook or report. I’ll show you how I organise my work using the tidyverse, use child documents with parameterisation and also how this is served out to my colleagues via RStudio Connect.
</p>
</details><br>

# Session 5

Session 5 / programming / vctrs: tools for making size and type consistent functions<br>
Speaker: Hadley Wickham 
<details><summary>Abstract</summary>
<p>vctrs is a new package that provides tools (cognitive and computational) to ensure that functions behave consistently with respect to inputs of varying length and type. The end goal of vctrs is to be invisible to the end user of the tidyverse (simply enabling their predictions about function outputs to be more correct), but will help developers write functions that "just work".
</p>
</details><br>

Session 5 / shiny / [Effective use of Shiny modules in application development](https://rpodcast.github.io/rsconf-2019)<br>
Speaker: Eric Nantz -	[website](https://r-podcast.org/),	[twitter](https://twitter.com/thercast),	[github](https://github.com/thercast), [linkedin](https://www.linkedin.com/in/eric-nantz-6621617/)
<details><summary>Abstract</summary>
<p>As a Shiny application grows in scale, organizing code into reusable and streamlined components becomes vital to manage future enhancements and avoid unnecessary duplication. Shiny modules are customized R functions that are easily reused multiple times within an application by avoiding namespace collisions and assist with organizing the code base. Like R functions, modules can be simple utilities or elaborate pieces with multiple inputs and outputs. While the process of creating a module is uncomplicated, application developers can quickly encounter challenges including communication among modules, defining logical compositions, and avoiding hidden state modifications. In this talk, we will introduce practical principles and techniques developers can leverage to address these issues head-on such as documenting modules, passing parameters and return values effectively between modules, and how nesting modules enables dynamic user interfaces with minimal overhead.
</p>
</details><br>

Session 5 / teaching / Learning from Eight Years of Data Science Mistakes<br>
Speaker: Caitlin Hudon 
<details><summary>Abstract</summary>
<p>Over the past eight years of doing data science, I’ve made plenty of mistakes, and I’d love to share them with you -- including what I’ve learned and what I’d do differently with some hindsight. This talk will cover mistakes made during analyses (including communication when delivering results) team and infrastructure mistakes, plus some advice for incoming data scientists.
</p>
</details><br>

Session 5 / programming / Lazy evaluation [Tidy eval in context](https://rstd.io/tidy-eval-context)<br>
Speaker: Jenny Bryan -	[website](http://stat545.com),	[twitter](https://twitter.com/jennyBryan/),	[github](https://github.com/jennybc)
<details><summary>Abstract</summary>
<p>The "tidy eval" framework is implemented in the rlang package and is rolling out in packages across the tidyverse and beyond. There is a lively conversation these days, as people come to terms with tidy eval and share their struggles and successes with the community. Why is this such a big deal? For starters, never before have so many people engaged with R's lazy evaluation model and been encouraged and/or required to manipulate it. I'll cover some background fundamentals that provide the rationale for tidy eval and that equip you to get the most from other talks.
</p>
</details><br>

Session 5 / shiny / [Reactlog 2.0: Debugging the state of Shiny](http://github.com/schloerke/presentation-2019-01-18-reactlog)<br>
Speaker: Barret Schloerke -	[website](http://schloerke.com/),	[twitter](https://twitter.com/schloerke),	[github](https://github.com/schloerke),	[linkedin](https://www.linkedin.com/in/schloerke/)
<details><summary>Abstract</summary>
<p>The revamped reactlog provides an updated visual display to traverse through the reactive behavior within your shiny application. Using live shiny applications, we will use reactlog’s directed dependency graph to find missing reactive dependencies in “working” applications and address suboptimal reactive coding patterns. Correcting these coding patterns will reduce the amount of calculations done by shiny and keep reactive objects from being created unnecessarily.
</p>
</details><br>

Session 5 / teaching / [Catching the R wave: How R and RStudio are revolutionizing statistics education in community colleges (and beyond)](https://github.com/mrshrbrmstr/RStudioConf2019)<br>
Speaker: Mary Rudis - [twitter](https://twitter.com/mrshrbrmstr),			[linkedin](https://www.linkedin.com/in/maryrudis/)
<details><summary>Abstract</summary>
<p>Catching the R Wave: How R and RStudio are revolutionizing statistics education in community colleges (and beyond) There is no doubt that RStudio has had an impact on how introductory statistics is taught in colleges today. When we consider the sheer dominance that giants like Texas Instruments, IBM, and Pearson Publishing have had in academic curriculum development it’s no small wonder that tools like R and Python have been able to gain a foothold. Projects like DataCamp, ModernDive.com, “Introductory Statistics with Randomization and Simulation” courtesy of openintro.org, Wickham’s “R for Data Science” and Peng’s “R Programming for Data Science” are great resources for the student who has already some fundamental math or statistical background and has become comfortable around computing and applications-driven computational exercises. But many of us know that Data Science cannot simply be relegated to the privileged few that stumble into it by virtue of circumstance. My passion, and the purpose of my talk, is to provide educators with a digestible guidebook that would be appropriate for introduction to statistical concepts in high school, college, and under-resourced schools looking for ways to increase diversity in STEM. Organized in small, adaptable activities designed to be the amuse-esprit enticing both the timid and the skeptical to the proverbial banquet table that is RStudio, this exploration into the world of statistics education should be of interest to a wide audience. My hope is to increase data literacy in real world context – with primary emphasis on descriptive statistics and distributions.
</p>
</details><br>

Session 5 / programming / [Working with names and expressions in your tidy eval code](https://speakerdeck.com/lionelhenry/selecting-and-doing-with-tidy-eval)<br>
Speaker: Lionel Henry - [twitter](https://twitter.com/_lionelhenry),	[github](https://github.com/lionel-)
<details><summary>Abstract</summary>
<p>In practice there are two main flavors of tidy eval functions: functions that select columns, such as `dplyr::select()`, and functions that operate on columns, such as `dplyr::mutate()`. While sharing a common tidy eval foundation, these functions have distinct properties, good practices, and available tooling. In this talk, you'll learn your way around selecting and doing tidy eval style.
</p>
</details><br>

Session 5 / shiny / Integrating React.js and Shiny<br>
Speakers: Alan Dipert 
<details><summary>Abstract</summary>
<p>React.js is a thriving JavaScript library that eases encapsulating and sharing sophisticated component libraries. The React.js ecosystem is filled with components for doing everything from color selection (react-color) to animation (react-spring). While it's always been technically possible to integrate React.js components with Shiny applications, it hasn't always been particularly obvious how. To make it easier, we augmented the excellent reactR package with functions specifically designed to make it easier to create new htmlwidgets, inputs, and outputs based on React.js components. In this talk, I will further motivate and demonstrate these new tools and do my best to empower the audience to try them out.
</p>
</details><br>

Session 5 / teaching / [The next million R users](https://github.com/rstudio/learning-r-survey/blob/master/slides/Next-Million-R-Users.pdf)<br>
Speaker: Carl Howe [twitter](https://twitter.com/cdhowe),	[github](https://github.com/cdhowe),	[linkedin](https://www.linkedin.com/in/carlhowe/)
<details><summary>Abstract</summary>
<p>Many students believe that R is obsure, complex, and difficult to write. However, data from a new large-scale survey of R users conducted by RStudio shows that new R users are taking dramatically different learning paths from those who learned R as recently as 2 years ago, and these new learning paths are changing its perception. In this talk, we'll present this new survey data, describe how new tools and techniques for teaching R can satisfy the demands of today's R learners, and outline a vision for adding millions of new R users to our community.
</p>
</details><br>

Session 5 / programming / [Learning and using the tidyverse for historical research](https://github.com/jessesadler/rstudioconf-2019-slides)<br>
Speaker: Jesse Sadler -	[website](https://www.jessesadler.com/),	[twitter](https://twitter.com/vivalosburros),	[github](https://github.com/jessesadler)
<details><summary>Abstract</summary>
<p>My talk will discuss how R, the tidyverse, and the community around R helped me to learn to code and create my first R package. My positive experiences with the resources for learning R and the community itself led me to create a blog detailing my experiences with R as a way to pass along the knowledge that I gained. The next step was to develop my first package. The debkeepr package integrates non-decimal monetary systems of pounds, shillings, and pence into R, making it possible to accurately analyze and visualize historical account books. It is my hope that debkeepr can help bring to light crucial and interesting social interactions that are buried in economic manuscripts, making these stories accessible to a wider audience.
</p>
</details><br>

Session 5 / shiny / Introducing ipc for Shiny<br>
Speakers: Ian Fellows 
<details><summary>Abstract</summary>
<p>Don’t Let Long Running Tasks Hang Your Users: Introducing ipc for Shiny Long running tasks in Shiny are not cancelable and typically lock the user interface while running. This talk introduces the ipc package, which helps you build dynamic applications when non-trivial computations are involved. ipc allows your Shiny Async workers to be cancelable and communicate intermediate results/progress back to the user interface.
</p>
</details><br>

Session 5 / teaching / RStudio Cloud for Education<br>
Speakers: Mel Gregory
<details><summary>Abstract</summary>
<p>RStudio Cloud aims to take the friction out of doing data science with R, allowing students (and instructors) to skip over installation, setup, and IT challenges and go straight to the good stuff. In this talk, you will learn about RStudio Cloud, how it can streamline the learning process, and how to use it to facilitate teaching classes, workshops, and other learning situations. Additionally, we will highlight some best practices for using RStudio Cloud in an educational setting, and talk about other learning resources available.
</p>
</details><br>

## posit::conf(2024)

This is where we will store all of the materials and links for posit::conf(2024)!

### A Future of Data Science
💬 Allen Downey

In the hype cycle of data science, I suggest that the "peak of inflated expectations" was in 2012, the "trough of disillusionment" was in 2016, and since then, we have climbed the "slope of enlightenment". Now, as we approach the "plateau of productivity", it's a good time to figure out how we got here and what future we want. Can we use data to answer questions, resolve debates, and make better decisions? What tools and processes make data science work? What can we learn when it does, and what goes wrong when it doesn't? In this talk, I will present my answers, and then I would like to hear yours.

[Slides](https://docs.google.com/presentation/d/e/2PACX-1vSdoq58S1DbhSKikfu3m52B4oMB5DFgyvxr0qy4Rhilojq6G2oRqTLmWMKuKtEBQVoDEr-XXv0--10H/pub#slide=id.p)

### Beyond Dashboards: Dynamic Data Storytelling with Python, R, and Quarto Emails
💬 Sean Nguyen

In this talk, I’ll confront the traditional dependence on dashboards for business intelligence, pointing out their shortcomings in delivering prompt insights to business professionals. I will propose a shift in strategy that employs Python and R to generate dynamic, customized emails, utilizing Quarto and Posit Connect for seamless automation. This technique guarantees direct and effective delivery of actionable insights to users' inboxes, enhancing informed decision-making and boosting engagement. This recommendation not only redefines the method of data delivery for optimal impact but also prompts a fundamental change in mindset among data practitioners, urging them towards a more engaged and individualized form of data narration.



Slides | GitHub Repo

### Quarto, AI, and the Art of Getting Your Life Back
💬 Tyler Morgan-Wall

Tired of endless server issues and maintenance headaches? Want to reclaim your time for coding, writing, and creating? Join me as I share my journey of switching from the server-based headaches of WordPress to Quarto with a little help from AI. In this talk, I’ll describe the simple trick I used to convert an existing WordPress blog—complete with custom scripts, styles, and beautiful 3D data viz content—into a slick Quarto site. I'll then demonstrate some lesser-known features of Quarto to automate deploying a website entirely from a Quarto project file. Finally, I’ll show you how I used AI to customize and style my new Quarto site and provide several useful strategies to employ if you decide to get some help from AI on your own Quarto journey.

Slides | GitHub Repo

### Creating reproducible static reports.
💬 Orla Doyle

In clinical trials, we work in interdisciplinary teams where the discussion of outputs is often facilitated using static documents. We wanted to bring the advantages of modern tools (R, markdown, git) and software development practices to the production of company documents. We used an object-oriented approach to create classes for report items with a suite of tests. Finally, the report is rendered programmatically in docx format using a company template. This enables our statisticians to work in a truly end-to-end fashion within a GxP environment with the end product in a format suitable for interdisciplinary collaboration. We are currently piloting this package internally before we release it in the open-source community.

[Slides](https://orladoylenvs.github.io/positconf24_rdocx/#/title-slide) | GitHub Repo

### Quarto: A Multifaceted Publishing Powerhouse for Medical Researchers
💬 Joshua J. Cook

Traditional medical research dissemination is slow and cumbersome, often culminating in a diverse array of outputs: reports for our sponsors and regulators, manuscripts for peer-reviewed journals, summaries for online platforms, and presentations for conferences. However, it takes a great deal of time and effort to organize all these outputs so that our findings can enter the patient setting. Quarto can change that. It's a tool that lets us efficiently create various polished formats from a single source while meeting diverse submission requirements. This talk will showcase how Quarto can revolutionize our communication, making research more impactful and speeding up the delivery of treatments to our patients.

[Slides](https://1drv.ms/u/s!Aqkk_opBQPkyjOQ79CnnFHt8zPio-Q?e=5d9Xpq) | [GitHub Repo](https://github.com/jjc54/posit_2024_quarto_presentation)

### Adequate Tables? No, We Want Great Tables.
💬 Richard Iannone

Tables are great, and we’ve been doing a lot on both the R and Python sides to make it possible to generate aesthetically pleasing tables. The gt package for R has been under continuous development for six years, and there are still so many things we can do to make it better. Great Tables, our new Python package, brings beautiful tables to Python users and provides an API that’s in tune with that ecosystem.

While we have made great strides and unlocked new table-making possibilities for our users, our ambitions are huge! So, we’d like to show you the state of things on this front and also where we intend to go with our collective table efforts.

[Slides](https://github.com/rich-iannone/presentations/blob/main/2024-08-13-posit_conf_adequate_tables/gt_GT_talk_posit_conf.pdf) | [GitHub Repo](https://github.com/rich-iannone/presentations/tree/main/2024-08-13-posit_conf_adequate_tables)

### Context is King
💬 Shannon Pileggi

The quality of data science insights is predicated on the practitioner’s understanding of the data. Data documentation is the key to unlocking this understanding; with minimal effort, this documentation can be natively embedded in R data frames via variable labels. Variable labels seamlessly provide valuable data context that reduces human error, fosters collaboration, and ultimately elevates the overall data analysis experience. As an avid, daily user of variable labels, I am excited to help you discover new workflows to create and leverage variable labels in R!

[Slides](https://shannonpileggi.github.io/context-is-king/#/title-slide) | [GitHub Repo](https://github.com/shannonpileggi/context-is-king)

### gtsummary: Streamlining Summary Tables for Research and Regulatory Submissions
💬 Daniel Sjoberg

The gtsummary R package empowers researchers and analysts to create publication-ready summary tables efficiently. Developed at Memorial Sloan Kettering Cancer Center, it quickly gained traction and has become the most downloaded package for summary tables on CRAN. 2024 marked a significant expansion for gtsummary. A comprehensive codebase update enhanced performance and introduced new features. Further, the adoption of CDISC’s Analysis Results Data standard enables compliance with emerging FDA submissions standards, maintaining relevance for various research and regulatory needs. gtsummary offers a robust solution for generating clear, informative tables, saving time, and ensuring quality for researchers and analysts across diverse fields.

[Slides](https://docs.google.com/presentation/d/19bjd9wuo6zVjBzvCGHmHJ3a49GbEXpf4Wcs1tEXzycw/pub?start=false&loop=false&delayms=3000)

### Stitch by Stitch: The Art of Engaging New Users
💬 Becca Krouse

In the world of crochet, the Woobles kit simplifies yarn, hooks, and stitches for beginners, alleviating decision fatigue and fostering early success. This model unexpectedly extends to the domain of R. Newcomers, especially in industries less familiar with open-source, may find mastering new tools daunting. We grappled with this while developing {tfrmt}, a table-making package for pharma. This talk will draw parallels with crochet to explore strategies for engaging and retaining new users. Attendees will grasp the role of a starter kit for easing the learning curve and the value of nurturing experts with transferable skills. They'll glean insights to support their own audiences, whether in creating an R package or crafting a cuddly unicorn.

Slides | GitHub Repo

### Open Source Software in Action: Expanding the Spatial Equity Data Tool
💬 Gabriel Morrison

The Urban Institute’s Spatial Equity Data Tool enables users to upload their own data and quickly assess whether place-based programs and resources—such as libraries or Wi-Fi hotspots—are equitably distributed across neighborhoods and demographic groups. Our (forthcoming) API and R package also enable users to seamlessly incorporate equity analytics into existing workflows and exciting new tools.

In this talk, I will share how we've expanded access to the tool using multi-language software. I'll discuss our updates to Python-based tool and API; R package wrapping the API; and Quarto-based documentation. I will also share how our partners in the City of Los Angeles have used the API and RShiny to build a custom budget equity tool.

[Slides](https://urbanorg.box.com/s/vecuwuwhtj1zkha09nznq9p0qxdttl9r) | [GitHub Repo](https://github.com/UrbanInstitute/ui-equity-tool)

### Making Waves with R, Python, and Quarto
💬 Regina Lionheart

Wave models are powerful tools for understanding coastal erosion, but analyzing their outputs poses challenges. Proprietary formats produce inaccessible data that require manual extraction. Final results must also be approachable to a diverse audience of engineers, governments, and coastal communities. In 2022, a project was proposed to investigate how a restored beach could respond to waves while mitigating erosion and protecting a cultural resource. Using R and Python wrapped in Quarto, wave model outputs were fully scripted to create a single reproducible document flexible enough to answer multiple modeling questions. As coasts change, rapid modeling and analysis may help preserve coastal access for years to come.

Slides | GitHub Repo

### Why You Should Think Like an End-to-end Data Scientist, and How
💬 Adam Wang

Machine learning (ML) solutions are becoming ubiquitous when tackling challenging problems, enabling end-users to access reliable, insightful information. However, many components of these solutions rely on domains outside traditional data science — e.g., data, DevOps, and software engineering.

In this talk, I'll walk through an end-to-end ML solution we built for transplant centers to identify likely stem cell donors. We'll then focus on how interacting with domains outside traditional data science can immensely help a project succeed and increase your impact.

You will take away specific examples of why thinking end-to-end can enhance your ML solutions and how to start applying these principles in your own organization.

Slides | GitHub Repo

### earthaccess: Accelerating NASA Earthdata science through open, collaborative development
💬 Luis Lopez

earthaccess is a python library to search, download or stream NASA Earth science data with just a few lines of code.

Open science is a collaborative effort; it involves people from different technical backgrounds, and the data analysis to solve the pressing problems we face cannot be limited by the complexity of the underlying systems. Therefore, providing easy access to NASA Earthdata and reducing the complexity and "time to science" is the main motivation behind this Python library.

[Slides](https://docs.google.com/presentation/d/1Ot879tfrjhok3BzSwSUr2Xpd26dX-hyVGHQzATLVRTo/) | [GitHub Repo](https://github.com/nsidc/earthaccess)

### Data Wrangling [for Python or R] Like a Boss With DuckDB
💬 Hannes Mühleisen

Data wrangling is the thorny hedge that higher powers have placed in front of the enjoyable task of actually analyzing or visualizing data. Common struggles come from importing data from ill-mannered CSV files, the tedious task of orchestrating efficient data transformation, or the inevitable management of changes to tables. Data wrangling is rife with questionable ad-hoc solutions, which can sometimes even make things worse. The design rationale of DuckDB is to support the task of data wrangling by bringing the best of decades of data management research and best practices to the world of interactive data analysis in R or Python. For example, DuckDB has one of the world's most advanced CSV readers, native support for Parquet files and Arrow structures, an efficient parallel vectorized query processing engine, and support for efficient atomic updates to tables. All of this is wrapped up in a zero-dependency package available in a programming language near you for free. In my talk, I will discuss the above as well as the design rationale of DuckDB, which was designed and built in collaboration with the Data Science community in the first place.

[Slides](https://blobs.duckdb.org/posit-conf-2024-keynote-hannes-muehleisen-data-wrangling-duckdb.pdf) | GitHub Repo

### Data Contracts: Keep Your Weekend Work-Free!
💬 Nick Pelikan

This talk will discuss data contracts – agreements between data producers and data consumers that ensure data is always available in the expected form. We'll delve into processes and techniques I've developed that can help teams easily create data contracts. This talk will also introduce a literate programming framework that can enable data producers and data consumers who work on different teams in completely different programming languages (or no programming language at all!) to collaborate on creating data contracts and allow them to be enforced automatically.

[Slides](https://docs.google.com/presentation/d/1R9nm_8LHJpkc32XAf3LYRbh9Sr97-Y8OFHHE7Ds5L18/edit#slide=id.g28004ec81db_0_5) | [GitHub Repo](https://github.com/npelikan/positconf2024-datacontracts)

### Demystifying Data Modeling
💬 Kshitij Aranke

Data Modeling – what is it, why is it useful, and how dbt makes it easy.

As a previous R user, I was very skeptical of the value of data modeling when I first came across it. But over time, I realized that it helped organizations scale up analytics practices by standardizing consistent definitions for metrics, improving debuggability for data pipelines, and even enabling rapid experimentation. I want to share this magic with the posit::conf community, and especially how dbt is a tool that's oriented around this practice.

Slides | GitHub Repo

### {mirai} and {crew}: next-generation async to supercharge {promises}, Plumber, Shiny, and {targets}
💬 Charlie Gao and Will Landau

{mirai} is a minimalist, futuristic, and reliable way to parallelise computations – either on the local machine, or across the network. It combines the latest scheduling technologies with fast, secure connection types. With built-in integration to {promises}, {mirai} provides a simple and efficient asynchronous back-end for Shiny and Plumber apps. The {crew} package extends {mirai} to batch computing environments for massively parallel statistical pipelines, e.g. Bayesian modeling, simulations, and machine learning. It consolidates tasks in a central {R6} controller, auto-scales workers, and helps users create plug-ins for platforms like SLURM and AWS Batch. It is the new workhorse powering high-performance computing in {targets}.

[Slides](https://wlandau.github.io/posit2024) | [GitHub Repo](https://github.com/wlandau/posit2024) | [`mirai`](https://shikokuchuo.net/mirai/) | [`crew`](https://wlandau.github.io/crew/)

### Deploying data applications and documents to the cloud
💬 Alex Chisholm

Creating engaging data content has never been easier, yet easily sharing remains a challenge. And that's the point, right? You cleaned the data, wrangled it, and summarized everything for others to benefit. But where do you put that final result? If you're still using R Markdown, perhaps it's rpubs.com. If you've adopted Quarto, it could be quartopub.com. Have a Jupyter notebook? Well, that's a different service. And this is just for docs. Want to deploy a streamlit app? Head to streamlit.io. Shiny? Log into shinyapps.io. Dash? You could use ploomber.io, if you have a docker file - and know what that is. This session summarizes the landscape for online data sharing and describes a new tool that Posit is working on to simplify your process.

[Slides](https://docs.google.com/presentation/d/1zulnuaT2Dm_vM0l9Gd3vS26KWJuAf0gJ1pcFKjTUNbI/edit?usp=sharing)

### Data Wrangling for Advocacy: Tidy Data to Support the Affordable Connectivity Program
💬 Christine Parker

We sought to create a dashboard to highlight some frequently asked statistics about the Affordable Connectivity Program. Although the program data were "available" to the public, they were not accessible. Wrangling messy datasets is not new to data scientists, and our work included pretty straightforward summary statistics, yet this work became a leading resource for advocacy groups, academics, and policymakers, and ultimately led us to a meeting where we shared guidance about the program funding needs with the White House. While I give a shout-out to a few of my favorite R packages, in this talk, I focus on the strategies you can employ to make your data tool has an impact. 

[Slides](https://www.canva.com/design/DAGKFckt2-Y/Lkf8VC3nCfYfwD1hYOydDg/view?utm_content=DAGKFckt2-Y&utm_campaign=designshare&utm_medium=link&utm_source=editor) | [ACP Dashboard](https://acpdashboard.com/)

### Leveraging Data in a Volunteer Fire Department
💬 Joseph Richey

The majority of fire departments in the United States are volunteer-based organizations. As an emerging professional in the field of data science, I was able to help my local fire department track, manage, and analyze data using R Shiny, Python, and AWS. This has allowed for increased efficiency within the department, and better transparency for fire department and local government officials.

[Slides](https://docs.google.com/presentation/d/1JjjjfDBox7W1MK6CwBmu3cIFpzSEnLu_/edit?usp=sharing&ouid=117509225446346298730&rtpof=true&sd=true) | [GitHub Repo](https://github.com/JosephRichey/fire-data)

### Novice to data scientist: how a pediatric anesthesiologist used R Studio to help disadvantaged kids access surgical care
💬 Nick Pratap

When a surgical procedure gets canceled, a child gains no health benefit, families' time off work and pre-op anxiety is in vain, and our not-for-profit children's hospital loses ~$1 per second. To understand cancellation, I needed to analyze thousands of patient records. Despite zero formal training, I learned to tidy and then visualize data – and even do geocoding and machine learning. Once we identified children at high risk, we could target additional support to their families. Furthermore, we showed that surgery cancellation contributes to health inequality. The R Studio/tidyverse ecosystem allows novices to do sophisticated analytics, and is helping us improve access to health care for the most disadvantaged children in our communities.

Slides | GitHub Repo

### A Machine Learning Approach to Protect Patients from Blood Tube Mix-Ups
💬 Brendan Graham

A wrong blood-in-the-tube (WBIT) error occurs when blood collected from one patient is labeled as though it was collected from a different patient. While rare, these errors can cause serious, potentially life-threatening patient safety events. This talk is about how a team of pathology informaticists and data scientists developed and deployed a multi-analyte WBIT detection model at the Children's Hospital of Philadelphia. We describe how machine learning models can potentially identify previously undetectable WBIT errors and improve upon the current detection methodology. Furthermore, we demonstrate how using R markdown, tidymodels, vetiver, and Posit Connect allowed for rapid model iteration, reproducibility, deployment, and monitoring.

Slides | GitHub Repo

### Breaking Barriers: Adopting R in Biotech with Posit
💬 Nicole Jones

In recent years, there has been a notable surge in R adoption in the pharmaceutical and biotech sectors, demanding regulated environments for R-based workflows. Posit offers a comprehensive ecosystem of tools designed to meet these needs. While these tools offer advantages, there is an additional burden placed on companies to maintain the environment. One notable challenge is integrating the Posit tools with a regulated Statistical Computing Environment(SCE) while ensuring standardized environments across the development and regulated systems. In this talk, we will share the benefits, challenges and lessons learned leveraging the Posit ecosystem in a mid-sized biotech company.

Slides | GitHub Repo

### Mastering the Art of Adopting R and Python: Innovative Strategies for Effective Change Management
💬 Mark Bynens

Mastering the Art of Adopting R and Python: Innovative Strategies for Effective Change Management' is more than just a presentation; it's a roadmap to navigate the complexities to integrate R and Python into our daily operations in a world that never slows down. Through an in-depth look at some real-world examples from Janssen R&D moving towards R and Python, we will show you how it's done. This isn't just theory; it's practical, actionable advice.

As we embark on a journey to weave R and Python into the fabric of our organization, let's keep these insights and strategies at the forefront. Together, we can redefine what it means to be adaptable and resilient in an ever-changing world.

Slides | GitHub Repo

### A New Era for Shiny-based Clinical Submissions using WebAssembly
💬 Eric Nantz

In life sciences, Shiny has enabled tremendous innovations to produce web interfaces as front-ends to sophisticated analyses, interactive visualizations, and clinical reporting. While industry sponsors have widely adopted Shiny, a relatively unexplored frontier has been the inclusion of a Shiny application inside a submission package to the FDA. The R Consortium R-Submissions Working Group has continued the momentum of previous submission pilots, such as the successful Shiny app submission to the FDA in 2023. In this talk, I will share the journey of how we used containers and WebAssembly for a new and innovative approach to sharing a Shiny application directly with the FDA, paving the way for new innovation in the clinical submission process.

[Slides](https://github.com/rpodcast/shiny-webr-posit2024) | [GitHub Repo](https://github.com/RConsortium/submissions-pilot4-webR)

### Open-Source Initiatives in Pharma - What's Out There and Why You Should Join
💬 Nicholas Masel

The pharmaceutical industry has come a long way when it comes to using open-source and collaborating on initiatives to solve complex industry issues. The number of initiatives and working groups that are now available have grown so much over the last 5 to 10 years that understanding what to join, or even just what to keep track of, can feel like selecting an R package, you’ve got a lot of options! This is a good problem to have, but it can also feel like a barrier to entry for companies or individuals in the industry who are looking to learn and/or contribute. In this talk, I will present guidance to the pharmaceutical industry to help them navigate the open-source collaboration landscape to help companies and individuals get involved.

[Slides](https://nicholas-masel.github.io/posit2024/2024_posit_conf.html#/open-source-initiatives-in-pharma) | [GitHub Repo](https://nicholas-masel.github.io/posit2024_supplemental/Supplemental%20Material.html)

### Modernizing the Data Science Toolkit of a 40-year-old Market Research Company
💬 Keaton Wilson

This presentation outlines the efforts undertaken by the Decision Sciences and Innovation (DSI; which focuses on statistical consulting and end-to-end quantitative analysis) team at KS&R to modernize their data science toolkit over the past year. The main goals were to foster collaboration, improve our legacy codebase, and deliver high-quality data products. Key topics covered include teamwide adoption of version control and GitHub, building and deploying internal R packages, Quarto-based documentation, and strategies for gaining buy-in across teams and leadership. Attendees can expect practical insights and tools for instigating change in their own organizations.

Slides | GitHub Repo

### Building scalable data pipelines through R and global health information systems' API
💬 Karishma Srikanth

Efficient and scalable analytics workflows are critical for an adaptive and data-driven organization. How can we scale systems to support an office charged with implementing USAID's $6 billion HIV/AIDS program? Our team leveraged R and global health APIs to build more efficient workflows through automation by developing custom R packages to access health program data. Our investment in creating an automated data infrastructure with flexible, open-source tools like R enabled us to build reproducible workflows for analysts in over 50 partner countries. We would like to share our experience in a federal agency integrating APIs with R to develop scalable data pipelines, as inspiration for organizations facing similar resource & data challenges.

Slides | GitHub Repo

### Shiny in Action: Transforming Film Production with TARS
💬 Marcin Dubel

Behind every 'Lights! Camera! Action!' is a complex choreography of 20+ departments, complicated by the manual creation of 50+ weekly or monthly reports over each production's 2-3 year span. Our R/Shiny app ("TARS") streamlines communication and coordination of this process via data integrations, interactive UIs, customizable notifications, and reports. This presentation will unpack the layers of our app's functionality, spotlighting Shiny and R's pivotal roles in modernizing the business of film production, data confidentiality, and inter-departmental synergy. Developers will learn about methodologies for enhancing data flow, security measures, and custom notifications, offering inspiration for navigating similar challenges.

Slides | GitHub Repo

### Computing and recommending company-wide employee training pair decisions at scale via an AI matching and administrative workflow platform developed completely in-house
💬 Regis A. James

Regis A. James developed MAGNETRON AI, an innovative, patent-pending tool that automates at-scale generation of high-quality mentor/mentee matches at Regeneron to enable rapid, yet accurate, company-wide pairings between employees seeking skill training/growth in any domain and others specifically capable of facilitating it. Built using R, Python, LLMs, shiny, MySQL, Neo4j, JavaScript, CSS, HTML, and bash, it transforms months of manual collaborative work into days. The reticulate, bs4dash, DT, plumber API, dbplyr, and neo4r packages were particularly helpful in enabling its full-stack data science. The expert recommendation engine of the AI tool has been successfully used for training a 400-member data science community of practice, and also for larger career development mentoring cohorts for thousands of employees across the company, demonstrating its practical value and potential for wider application.

[Slides]( https://drive.google.com/file/d/1jq-WjuFz1Lp3m6v0SYjNoW1WcCBKPMs3/view?usp=sharing ), [Referenced talks]( https://www.youtube.com/@datadrivendecisionmaking )

### Wait, that’s Shiny? Building feature-full, user-friendly interactive data explorers with Shiny and friends
💬 Kiegan Rice

In my work I am often asked to develop interactive data explorers for public-use data sets, with an emphasis on making the tools engaging, easy to use, and understandable for a general audience. I’d like to talk about the work my team does to develop user-friendly Shiny applications that look and feel like full websites and share some of the tools we use. This includes things like designing landing pages, creating detailed “About” pages, letting users share links to specific charts or download static versions, adding social media sharing links, site meta tags, sub-URLs, and so much more. After attending this talk, I hope others are excited about leveraging tools to make their users say “Wait, that’s Shiny?”

[GitHub Repo](https://github.com/kiegan/wait-thats-shiny)

### Shiny Templates
💬 Greg Swinehart

The Shiny team has made big steps to help apps' UI and UX scale more thoughtfully and elegantly. We've built a cohesive theme that refreshes all of our colors and components. Our layouts will better serve your apps as they grow. And we've created Shiny Templates, which are opinionated boilerplate code to help users create small, simple apps or large, complicated, multi-page dashboards that just look right.

Slides | GitHub Repo

### Making an App a System
💬 Andrew Bates

What data processing in your Shiny app is redundant or must happen within the app at all? What makes Shiny beautiful is how it blends data visualization into a compact bundle of code. That said, there are challenges to overcome to get from a developer’s console to users’ screens. Tools like Posit Connect help with this process, but as an app matures, developers and their users may encounter different performance issues. To address this, sometimes this means evolving and introducing separate data pipelines. In this presentation, we will overview some different types of scaling issues for a Shiny app. Additionally, we will introduce the new package {matte}, which provides support for adding data pipelines to your app that live outside Shiny.

Slides | GitHub Repo

### Empowering Decisions: Advanced Portfolio Analysis and Management through Shiny
💬 Lovekumar Patel

This talk explores the creation of an advanced portfolio analysis system using Shiny and Plumber API. Focused on delivering real-time insights and interactive tools, the system transforms financial analysis with user-centric design and reusable Shiny modules. The talk will delve into how complex financial data is made dynamic and interactive via an internal R package integrating with an ag-grid javascript library to enhance user engagement and decision-making efficiency. A highlight is the Plumber API's dual role: powering the current system and hosting other enterprise applications in other languages (python), demonstrating remarkable cross-platform integration. This system exemplifies the innovative potential of R in financial analytics.

Slides | GitHub Repo

### "Please Let Me Merge Before I Start Crying": And Other Things I've Said at The Git Terminal
💬 Meghan Harris

This talk is geared towards those who may feel comfortable working independently with Git but need some confidence when working collaboratively. Just like novice drivers can learn to confidently (and safely!) merge onto (seemingly) intimidating highways, those new to collaborating with Git can also conquer Git merges with some exposure and preparation.

This talk will go over:

- Different ways R users can interact with Git
- What Git merges and Git merge conflicts are
- Real-life examples of Git merges
- Advice on resolving Git merges
- Suggestions for cleaner workflows to promote better Git merges

[Slides](https://meghansaha.github.io/please_let_me_merge/) | [GitHub Repo](https://github.com/Meghansaha/please_let_me_merge)

### Easing the pain of connecting to databases
💬 Edgar Ruiz

Overview of the current and planned work to make it easier to connect to databases. We will review packages such as odbc, dbplyr, as well as the documentation found on our Solutions site (https://solutions.posit.co/connections/db/databases/), which will soon include the best practices we find on how to connect to these vendors via Python.

Slides | GitHub Repo

### Saving time (and pain) with Posit Public Package Manager
💬 Joe Roberts

CRAN, Bioconductor, and PyPI are incredible resources for packages that make performing data science in R and Python better. But there’s also a better way to obtain those packages! Companies like Databricks are leveraging Posit Public Package Manager to make their users’ package installation faster and more reproducible. Learn why, and how anyone – anywhere – can easily get started using Public Package Manager.

Slides | GitHub Repo

### Auth is the product, making data access simple with Posit Workbench
💬 Aaron Jacobs

Accessing data is a critical early step in data science projects, but is often complicated by security and technical challenges in enterprises. This talk will explore how Posit Workbench facilitates secure data access in IDEs like RStudio, JupyterLab, and VS Code through authentication and authorization aligned with existing data governance frameworks. Workbench manages and refreshes short-lived credentials on behalf of users for AWS, Azure, Databricks, and Snowflake, simplifying secure data access for open-source data science teams. Attendees will gain insights into overcoming data access challenges and leveraging Posit Workbench for secure, efficient data science workflows in an enterprise environment.

Slides | GitHub Repo

### Balancing Global Infrastructure and Local Autonomy: Lessons from R-Ladies Global
💬 Shannon Pileggi

As a global non-profit established in 2016, R-Ladies has more than 100k members from 233 chapters in 63 countries to support the mission of increasing gender diversity in the R community. Empowering local chapters is challenging as accessibility and awareness of communication methods, software choices, social platforms, and support avenues vary internationally. Join us for insights into our journey of developing a global, technical, and social infrastructure while fostering collaboration and growth and granting chapters the freedom to tailor their activities to local contexts. Walk away with practical, technical, and social strategies to empower and diversify your own data science communities based on learning from continuous feedback.

[Slides](https://github.com/rladies/rladies_global_presentations/blob/master/20240813_positconf/posit_conf2024.pdf) | [GitHub Repo](https://github.com/rladies/rladies_global_presentations/blob/master/20240813_positconf/README.md)

### bRewing code: Ingredients for successful tribal collaboration
💬 Alena Reynolds and Angie Reed

Everyone will have their own recipe for bRewing a great collaboration, but we wanted to share ours. Ingredients: equal parts learner and teacher, 90 kg of supportive management, 1 whole database, complete or incomplete, a dash of creativity, 60 hours of time (recipe included in the main presentation), fun to taste. First, make sure your ingredients are organized, and the prep area is tidy. Sift data into a central database and simmer and stir into separate R scripts. In a large cauldron, combine scripts and narrative into one giant Rmarkdown. Lubridate your pan and knit into the desired format. We want to share the rest of our recipe to make a delicious report that builds confidence in the learner, new and strong friendships, and lifelong skills.

Slides | GitHub Repo | [Volunteer Form](https://docs.google.com/forms/d/e/1FAIpQLSdHj47P0OAbPunyP6zbIihVeOOthiKsrCXWXoUQym_v9XdUog/viewform?pli=1)

### Art of R Packages: Forging Community with Hex Stickers
💬 Hubert Halun

Hex logotypes in the R community are not just for show. They represent identity, unity, and the collaborative nature of open-source projects. This talk will explore how these stickers blend design and visual storytelling, turning R packages into symbols of community. I'll cover the hex sticker creation process, from idea to design, and their impact on brand recognition and user pride. Using examples from the Tidyverse, Rhinoverse, Nest, and others, I'll highlight how hex stickers unite the R community. The aim is to show how mixing design with data science in creating R packages can build a strong community, highlighting the importance of both looks and usefulness.

Slides | GitHub Repo

### Converting Posit-Enthusiasm into Posit-Action
💬 Tyler McInnes

How did posit::conf(2023) influence my role as coordinator of a nationwide bioinformatics training programme in Aotearoa New Zealand? Inspired by the talks and workshops I attended at last year's conference, I set myself 17 tasks that would strengthen the local data science community, showcase Posit tools, and improve my own skill set. Post-conference enthusiasm was at an all-time high. Could I translate this enthusiasm into action to improve the data science training community? This talk will demonstrate how I was able to implement skills and tools from posit::conf to improve my community and highlight the current state of training in New Zealand, including the methods used to connect a small but widely dispersed group of researchers.

[Slides](https://drive.google.com/drive/folders/1pwYni_LFFCifS5ANlFOePbFkfjoLVyeP)

### Mixing R, Python, and Quarto: Crafting the Perfect Open Source Cocktail
💬 Alenka Frim and Nic Crane

Collaborating effectively on a cross-language open-source project like Apache Arrow has a lot in common with data science teams, where the most productivity is seen when people are given the right tools to enable them to contribute to the programming language they are most familiar with. In this talk, we share a project we created to combine information from different sources to simplify project maintenance and monitor important metrics for tracking project sustainability, using Quarto dashboards with both R and Python components. We'll share the lessons we learned collaborating on this project - what was easy, where things got tougher, and concrete principles we discovered were key to effective cross-language collaboration.

[Slides](https://github.com/arrow-maintenance/arrowdash/blob/main/other/PositConfTalk2024.pdf) | [GitHub Repo](https://github.com/arrow-maintenance/arrowdash)

### Python Rgonomics
💬 Emily Riederer

Data science languages are increasingly interoperable with advances like Arrow, Quarto, and Posit Connect. But data scientists are not. Learning the basic syntax of a new language is easy, but relearning the ergonomics that help us be hyperproductive is hard. In this talk, I will explore the influential ergonomics of R's tidyverse. Next, I will recommend a curated stack that mirrors these ergonomics while also being genuinely truly Pythonic. In particular, we will explore packages (polars, seaborn objects, greattables), frameworks (Shiny, Quarto), dev tools (pyenv, ruff, and pdm), and IDEs (VS Code extensions). The audience should leave feeling inspired to try Python while benefiting from their current knowledge and expertise.

Slides | GitHub Repo

### Empowering Reproducible Finance through Tidy Finance with R and Python
💬 Christoph Scheuch

Tidy Finance merges cutting-edge research in financial economics with the principles of transparency and reproducibility, providing a novel, open-source toolkit available in both R and Python. This multi-language approach simplifies financial data analysis while teaching best practices for reproducible research, integrating narrative with clean, easy-to-read code and replicable results. By promoting transparent code, public sharing, and multi-language support, Tidy Finance equips researchers, educators, and students with critical tools that foster a more reproducible academic environment. This talk will explore the development and impact of Tidy Finance, offering inspiration for attendees from various fields to advance open-source and reproducibility in their own work.

[Slides](https://talks.tidy-finance.org/#positconf2024) | [GitHub Repo](https://github.com/tidy-finance/website)

### CI madness with Ibis: testing 20 query engines on every commit
💬 Phillip Cloud

Tidy Finance merges financial economics research with the principles of transparency and reproducibility, offering a novel open-source toolkit in R and Python. Our multi-language approach simplifies empirical studies in finance and teaches reproducible research with clean, understandable code. In my talk, I'll showcase how Tidy Finance improves finance research and education, aiding finance professionals in applying its principles for better teaching and research. Attendees from diverse backgrounds will learn about fostering open-source initiatives in their fields. Join us to support a transparent, reproducible research environment.

Slides | GitHub Repo

### Level up! Empowering industry R users with different levels of experience
💬 Seth Colbert-Pollack

How can we level up the R skills of a team with varied backgrounds and levels of experience in R? At PicnicHealth, a health tech company that collects and abstracts patient medical records for use in research, we've come up with a number of strategies to share. We'll discuss building internal packages that assist with common tasks and distributing them with Posit Package Manager, hosting dashboards on Posit Connect and integrating them with other internal apps, maintaining a wiki, and holding regular Office HouRs to give folks a place to ask for advice. We'll share examples and show some projects that have benefited from this approach. This talk is suitable for anyone who has at least one coworker using R.

Slides | GitHub Repo

### Partnering with Posit for progress on Environmental Stewardship
💬 Saumiitha Leelakrishnan

Do you know R helps reduce tailpipe emissions like Carbon, NOX and other emissions.

I am Saumiitha Leelakrishnan, mom of 3 kids who cares for our environment, Technical Specialist leading Diagnostics and Emissions Data Analysis projects in Cummins - A 100+ year Engine Manufacturing company. In this talk, I will be sharing how R helps meet global product compliance and deliver solutions that lead to a cleaner environment. You will learn the transition from MATLAB to R and Python, how I utilized R's seamless integration, statistical capabilities, advanced modeling techniques, Quarto, ML algorithms to develop and maintain web applications in Posit Connect. This talk will benefit the Data Science Community with examples of harnessing the power of R.

[Slides](https://github.com/rstudio/rstudio-conf/blob/master/2024/saumiithaleelakrishnan/posit_environmentalstewardship.pptx)

### Coding in a Cyclone: open-source and the public sector in the birthplace of R
💬 Lee Durbin

When I started working at Te Kaunihera o Tāmaki Makaurau Auckland Council, I knew that R had been invented at the University of Auckland, and I knew that using R for data wrangling was a better way than using Excel. So I set about learning how to code with R, supported by the generosity of the R community and a plethora of freely-available online resources. During my journey, I discovered that a mature data culture is underpinned by three components, but when I was asked to use my data skills to help out during a cyclone, I realised that I was missing one of the three. In this talk I discuss how I reached that point, and what I did about it.

[Slides](https://effervescent-yeot-53625b.netlify.app/#/title-slide) | [GitHub Repo](https://github.com/lddurbin/coding_in_a_cyclone)

### Quarto for Knowledge Management
💬 Cynthia Huang

Have you ever considered using the power and flexibility of Quarto for note-taking and knowledge management? I did, and now I use Quarto websites to track my PhD progress, document insights from conferences, manage collaborative research projects, and more. Let me show you how easy it is to implement standard knowledge management system features, such as cross-referencing, search indexing, and custom navigation. But what if you want more advanced features like glossaries, document listings and summaries of datasets? Well, with some creative use of Quarto's many features and extensions, almost anything is possible. Whether you're new to Quarto or a seasoned expert, consider adding Quarto to your note-taking toolkit.

[Slides](https://github.com/cynthiahqy/positconf2024/blob/main/slides.pdf) | [GitHub Repo](https://github.com/cynthiahqy/positconf2024)

### rainbowR - a community that supports, connects and promotes LGBTQ+ people who code in R
💬 Ella Kaye

rainbowR's mission is to connect, support, and promote LGBTQ+ people in the R community and to spread awareness of LGBTQ+ issues through data-driven activism.

In this lightning talk, you'll learn about the community, our activities, and how you can get involved, whether as a member of the LGBTQ+ community or an ally. 

For more, see <https://rainbow.org>.

[Slides](https://r-lgbtq.github.io/posit-conf-2024/) | [GitHub Repo](https://github.com/r-lgbtq/posit-conf-2024)

### Breaking data identities: Making a case for language-agnosticity
💬 Albert Rapp

Slides | GitHub Repo

### JSquarto: Bridging JavaScript Documentation with Quarto's Power
💬 Richie Moluno

Slides | GitHub Repo

### Detecting Coordinated Disinformation Networks with R
💬 Richard Ngamita

Slides | GitHub Repo

### Ten Simple Rules for Teaching an Introduction to R
💬 Ava Hoffman

Many of us feel unprepared to teach R, either because of a lack of guidance or time to prepare. We’ve distilled our award-winning teaching experience into our top 10 takeaways so you can get up and running teaching R quickly. This includes advice for setting yourself up for success, keeping it practical, and knowing your learners. To see our tips in more detail, check out our paper: https://doi.org/10.1371/journal.pcbi.1012018

[Slides](https://docs.google.com/presentation/d/1TjilsiAIltuZINSuMvhVhiNIfgguMXMRRIPA_fkKDGI/edit?usp=sharing) | [GitHub Repo](https://github.com/jhudsl/Intro_to_r)

### R Scripts to Databricks: Lessons in Production Workflow
💬 Eric Leung

Slides | GitHub Repo

### The Expanse - Navigating the R Package Universe
💬 Benjamin Arancibia

Slides | GitHub Repo

### Translating clinical guidance to actionable insights with R
💬 Claire Bai

COTA’s team of oncologists and data scientists curate real-world data used by life science companies and healthcare partners to inform drug development and patient care. Over time, we have received many of the same questions from our data users, which indicated a dire need for translating our internal clinical guidance and data model knowledge into a tool for successfully navigating our data. We developed rwnavigator, an R package that helps users easily prepare COTA data for analysis with time-to-event packages. As first-time package developers, we ran into many challenges as we created, tested, and deployed rwnavigator. We hope to share with the greater R community our motivations for developing this package and best practices we learned along the way.

[Slides](https://github.com/rstudio/rstudio-conf/blob/master/2024/clairebai/rwnavigator_FINAL.pptx)

### Templated Analyses within R Packages for Collaborative, Reproducible Research
💬 Christopher T. Kenny

Slides | GitHub Repo

### Teaching and learning data science in the era of AI
💬 Andrew Gard

Slides | GitHub Repo

### Why’d you load that package for?
💬 Luis D. Verde Arregoitia

Packages enhance programming languages, and working with code makes workflows repeatable. However, the number of existing packages can be overwhelming to the point of obscuring their roles within projects. This talk discusses the importance of scripts, and introduces ways to enhance package load calls. First, by building annotations with the annotater R package and also by learning from code comments across GitHub. The value of recording information such as package source, version, title, or even which functions or data are used in a script is discussed in both data science and teaching environments.

[Slides](https://liomys.mx/posit24.html) | GitHub Repo | [annotater](https://annotater.liomys.mx/)  

### Datapages for interactive data sharing using Quarto
💬 Mika Braginsky

Findable, accessible, interoperable, and reusable (FAIR) data sharing is a key component of open science but presents a challenge for researchers, especially those with limited technical expertise or resources. If datasets are shared, it's most often as static files, restricting the FAIRness of the data. We use Quarto and Observable JS to develop Datapages, tools and templates that bridge this gap. Datapages enables researchers and other data distributors to easily share versioned datasets along with interactive visualizations, rich documentation, and user-friendly access functionality.

[Slides](https://docs.google.com/presentation/d/106HdcsSveZa7j52HLue_sa6iEl-YuToMZC8yUYZo2M4/pub?start=false&loop=false&delayms=60000) | [GitHub Repo](https://github.com/datapages/datapage) | [Website](https://datapages.github.io/)

### Event Automation with Posit Connect
💬 Kelly O'Briant

Slides | GitHub Repo

### Using the Kyber R package to connect Google Sheets, RMarkdown, GitHub, and Agenda docs for open education
💬 Stefanie Butland

As we work in open data science spaces, we frequently peer-teach coding and collaboration skills. The setup work is often grossly underestimated and unseen. I’ll share how Openscapes automates setup with the Kyber R package that uses googlesheets4 and creates RMarkdown documents that become collaborative Google Doc agendas, and sets up repositories and organizes people on GitHub. Kyber replaces manual steps with R functions while maintaining the ability to edit outputs so we’re not constrained by the automation. It has enabled us to teach workshops repeatedly in less time – in 2022, we led four concurrent learning cohorts with 160 government scientists! Kyber is openly available to fork, reuse, and extend, and other groups are doing just that.

[Slides](https://docs.google.com/presentation/d/1p_EXdYEVGY07VVMGdcvvwjjbwFihHsC_5oXRPW_8tVU/) | [Kyber GitHub Repo](https://github.com/openscapes/kyber) | [Openscapes](https://openscapes.org/)

### Making sense of marginal effects
💬 Demetri Pananos

The marginaleffects package for R and Python offers a single point of entry to easily interpret over 100 types of models using a simple and consistent interface. Marginaleffects has become an indispensable tool for moving away from tables of regression coefficients and towards easily interpretable estimates. In addition to making regression models more interpretable, marginaleffects offers flexible plotting tools, efficient implementations, validated results against Stata, and a thoroughly documented website abundant with examples and vignettes.


This talk is for data scientists and data analysts who analyze data with regression models. We’ll cover how to estimate and visualize a variety of effect summaries with marginaleffects.

Slides | GitHub Repo

### Understanding, Generating, and Evaluating Prediction Intervals
💬 Bryan Shalloway

For many problems concerning prediction, providing intervals is more useful than just offering point estimates. This talk will provide an overview of:

- How to think about uncertainty in your predictions (e.g., noise in the data vs uncertainty in estimation)
- Approaches to producing prediction intervals (e.g., parametric vs conformal)
- Measures and considerations when evaluating and training models for prediction intervals

While I will touch on some similar topics as Max Kuhn’s posit::conf(2023) talk on conformal inference, my talk will cover different points and have a broader focus. I hope attendees gain an understanding of some of the key tools and concepts related to prediction intervals and that they leave inspired to learn more.

[Slides](https://github.com/brshallo/posit-2024/blob/main/shalloway-posit-conf.pdf) | [GitHub Repo](https://github.com/brshallo/posit-2024)

### Keras 3: Deep Learning made easy
💬 Tomasz Kalinowski

Keras 3 is a ground-up rewrite of Keras 2, keeping everything that was already great the same, while refining and simplifying parts of the API based on lessons accumulated over the past few years. Come to this talk to learn about all the features (new and old) in Keras that make it easy to build, train, evaluate and deploy deep learning models.

[GitHub Repo](https://github.com/t-kalinowski/posit-conf-2024)

### Quality Control to avoid GIGO in Deep Learning Models.
💬 Vasant Marur

Deep Learning models help answer scientific questions, but they are only as accurate as the data we feed them. To ensure accurate models, we can implement quality control (QC) methods to ensure only high-quality data is used in training these models. Scientists generate thousands of images as part of Image-Based High Content Screening assays. To help them quickly assess the quality of these images before considerable time is spent analyzing them, we developed an interactive tool using Shiny that displays which images were flagged as part of QC. In this talk, I’ll explain how we created this QC tool and share ideas on how you could leverage your existing code and turn it into a stand-alone web app your stakeholders can use.

Slides | GitHub Repo

### Democratizing Organizational Surveys with Quarto and Shiny
💬 Brennan Antone

When gathering data from groups (e.g., surveys), where does it go, and who does it help? How can we deliver value directly back to all survey participants, not just top organizational decision-makers?

In this talk, I discuss re-designing how we report on organizational feedback surveys, moving from a top-down to a bottom-up approach to organizational change. Interactive dashboards can make data and feedback accessible to all. This tackles challenges with data quality, privacy, and power - allowing everyone to benefit directly from their data. I examine how Quarto and Shiny enable the creation of "flipped reports", and describe takeaways from implementing them with two Fortune 500 companies.

This talk teaches how personalized tools can make data accessible to all, and can alter the power dynamics around how organizations enact change.

[Slides](https://github.com/BrennanAntone/positconf24) | [Professional Website](https://brennanantone.com/)

### CONNECTing with our clients
💬 Sep Dadsetan

Leveraging Posit Connect, our company transforms client engagement by providing direct support, extensive documentation (built with Quarto), and no-code applications for data exploration and analysis of real-world oncology data. This strategy provides us the greatest flexibility for subject matter experts to deliver client value, provide client assistance, enhance self-service learning, and lower the technical barrier for data insights. Our commitment to client success and innovation is evidenced by our use of Posit Connect, providing tools for a competitive edge and data-driven culture.

[Slides](https://drive.google.com/file/d/1let_qEC94x3GS5E_hjLkqp0F4GrqLkwe/view?usp=sharing)

### Giving your scientific computing environment (SCE) a voice: experiences and learnings leveraging operational data from our SCE and Posit products to help us serve our users better
💬 James Black

Platform owners often ask questions like ‘how quickly do users migrate to new versions of R’, ‘what programming languages are used’, and ‘how are internal packages, dashboards and outputs consumed’?

The answer to these questions and many more lives within the operational logs collected by systems like Posit Connect, Github, and AWS. I’ll share examples of how we use this data at Roche to shape our product roadmap. I’ll also share some ideas we are exploring to use this data to help empower our data scientists to understand the hidden consequence of how they work through feeding back personal cost and environmental impact - enabling informed decisions, e.g. what it means to schedule a pin to update daily, or request 2 vs 8 cores.

Slides | GitHub Repo

### To Explore or To Exploit: Decoding Human Decision Making with R and Python
💬 Erin Bugbee

Every day, we face decisions, such as when to purchase a flight ticket to Seattle for posit::conf(2024) when prices change dynamically over time. As a decision scientist, I aim to understand these choices and the cognitive processes underlying them. In my talk, I'll delve into how I leverage both R and Python to decode human decision-making. I'll focus on optimal stopping problems, a common predicament we all encounter, in which a decision-maker must determine the right moment to stop exploring options and make a choice based on their accumulated knowledge. Attendees will be introduced to the field of decision science and learn how R and Python can assist in advancing the study of the human mind.

[Slides](https://erinbugbee.quarto.pub/2024positconf-decoding-decisions/) | [GitHub Repo](https://github.com/erinbugbee/2024positconf-decoding-decisions)

### Beyond the Classroom: Unspoken Realities of a Data Science Career
💬 Brandon Sucher

Embarking on a data science career extends well beyond academic knowledge. In many ways, the learning has just begun. Soft skills have become increasingly valuable, with effective collaboration being essential for success. Additionally, there may be moments when advocating for your own work is crucial, turning data scientists into persuasive salespeople for their own insights and contributions. In this talk, I'll touch on some of the aspects of a data science job that aren't talked about as frequently, including onboarding successfully, becoming a subject matter expert, and understanding the end-to-end data workflow.

[Slides](https://github.com/rstudio/rstudio-conf/blob/master/2024/brandonsucher/Posit_Conf_2024_Slides.pdf)

### GitHub: How To Tell Your Professional Story
💬 Abigail Haddad


GitHub is more than just a version control tool, it's a way of explaining your professional identity to prospective employers and collaborators – and you can build your profile now, before you're looking for new opportunities. This talk is about how to think of GitHub as an opportunity, not a chore, and how to represent yourself well without making developing your GitHub profile into a part-time job. I'll talk about why GitHub adds value beyond a personal website, what kinds of projects are helpful to share, and some good development practices to get in the habit of, regardless of your project specifics.

Slides | GitHub Repo

### Getting Data Done with a Pragmatic Data Team
💬 Alan Schussman

Data work comes in lots of forms, and large organizations with reliable pipelines of similar problems can be very specialized in how they tackle this work. My contention is that many organizations doing data work don't get to be so picky: Instead of specialized roles in focused parts of a data process, many of us work from end to end, and projects often differ in the tools and domain knowledge they require. Identifying and making use of good, reusable practices in this environment is hard, and there's not a consistent supply of some of the work that's most appealing to ambitious data people. This talk explores some successes and failures in building flexible, effective, empowered teams in this environment.

Slides | GitHub Repo

### Oops I'm A Manager - Finding your Minimal Viable Process
💬 Andrew Holz

In today's fast-paced, data-driven landscape, transitioning to a leadership role can be daunting. This talk is designed for emerging data team leaders, offering insights into striking the right balance between a clear effective process and the flexibility required for team members to do their best work. It emphasizes the importance of iterative process design, establishing effective feedback loops, and empowering team members with autonomy. These key strategies are put into action as team habits provide a blueprint for an adaptable workflow relevant to a range of different organizations. The talk aims to create a framework where both efficiency and creativity can thrive together.

[Slides](https://icarusz.github.io/OopsImAManager-MVP/#/title-slide) | [GitHub Repo](https://github.com/icarusz/OopsImAManager-MVP)

### Elevating enterprise data through open source LLMs
💬 Zac Davies

In an era where data privacy and security are paramount, many organizations are keen on leveraging Large Language Models (LLMs) in conjunction with their proprietary data without exposing it to third-party services. Recognizing this need, our talk, "Elevating Enterprise Data Through Open Source LLMs," showcases an approach that integrates the capabilities of Databricks and Posit, enabling businesses to maintain ownership and control over their data and LLMs while delivering value to their customers. The core of our discussion revolves around a system architecture that synergizes the strengths of Databricks and Posit technologies, providing a comprehensive solution for enterprise data and open-source LLMs. Databricks is responsible for data management and processing, offering a seamless environment for hosting, serving, and fine-tuning open-source LLMs. Keeping data and models in the secure perimeter of Databricks lowers the risk of data exfiltration tremendously, and also benefits from the scalable data processing and machine learning capabilities - including the recent acquisition MosaicML - that Databricks delivers. Posit steps in to streamline the process through Posit Workbench, the developer platform for data science with custom integrations for working with Databricks. This allows developers to write, test, and refine their code in a familiar and powerful setting while still being able to access the data, compute, and model serving offered by Databricks. In addition, Posit Connect offers an easy-to-use platform for deploying these applications, ensuring that the end-to-end process, from development to deployment, is efficient, secure, and aligned with enterprise standards.

Attendees of this talk will gain valuable insights into constructing and deploying LLM-powered applications using their enterprise data. By the end of the session, you will have a clear understanding of how to leverage Databricks for optimal data management and LLM operations, alongside Posit's streamlined development and deployment processes. This knowledge will empower you to deliver secure, effective, and scalable LLM-powered applications, driving innovation and value from your enterprise data while upholding the highest standards of data privacy and security.

Slides | GitHub Repo

### Using GitHub Copilot in R Shiny Development
💬 Mark Wang

Generative AI tools, like the GitHub Copilot, are revolutionizing software development, and R Shiny is no exception. However, some important features of Shiny, including modularization, reactivity, interaction with CSS/JavaScript, and simulation-based testing, pose unique opportunities and challenges to the use of GitHub Copilot. The talk will start with integrating CoPilot with local and cloud Shiny development environments. Then, it will discuss best practices around context information and prompt engineering to improve the accuracy and specificity of Copilot suggestions. It will then demonstrate how Copilot can assist in various use cases of Shiny development, including UI/UX design, interactions with front-end languages, and testing.

Slides | GitHub Repo

### Uniquely Human: Data Storytelling in the Age of AI
💬 Laura Gast

In an era of overwhelming data and increasing reliance on AI, the enduring power of human storytelling becomes essential. Our brains are wired for narrative – it evokes emotion, builds connection, and motivates action. Data storytelling marries insightful analysis with captivating narratives that move audiences.

This presentation emphasizes the crucial role of data storytelling in an AI-driven world. It explores techniques for crafting impactful narratives from data, balancing human creativity with the speed of AI. The talk also touches on principles of ethical storytelling, highlighting how to build trust and transparency when leveraging AI.

Slides | GitHub Repo

### Using Generative AI to Increase the Impact of Your Data Science Work
💬 Alok Pattani

Over the past year plus, generative AI has taken the world by storm. While use cases for helping people with writing, code generation, and creative endeavors are abundant, less attention has been paid to how generative AI tools can be used to do new things within data science workflows. This talk will cover how Google's generative AI models, including Gemini, can be used to help data practitioners work with non-traditional data (text, images, videos) and create multimodal outputs from analysis, increasing the scale, velocity, and impact of data science results. Attendees should expect to come away with ideas of how to apply Google generative AI tools to real-world data science problems in both Python and R.

[Slides](https://docs.google.com/presentation/d/18lS3d3pn-ImyOO0gE0DSLreH4iA6-YSZbRJq-I44j0c/) | [GitHub Repo](https://github.com/alokpattani/gcp-datascience/tree/master/olympics-medals-analysis) | [Blog Post](https://medium.com/google-cloud/achieving-gold-medal-level-data-science-communication-with-gemini-and-vertex-ai-536078880191)

### Introducing Positron, a new data science IDE
💬 Julia Silge, Isabel Zimmerman, Tom Mock, Jonathan McPherson, Lionel Henry, Davis Vaughan, and Jenny Bryan

Positron is a next-generation data science IDE that is newly available to the community for early beta testing. This new IDE is an extensible tool built to facilitate exploratory data analysis, reproducible authoring, and publishing data artifacts. Positron currently supports these data workflows in either or both Python and R and is designed with a forward-looking architecture that can support other data science languages in the future. In this session, learn from the team-building Positron about how and why it is designed the way it is, what will feel familiar or new coming from other IDEs, and whether it might be a good fit for your own work.

[Slide deck 1](https://speakerdeck.com/juliasilge/introducing-positron) | [Slide deck 6](https://speakerdeck.com/jennybc/positron-for-r-and-rstudio-users)

### Report Design in R: Small Tweaks that Make a Big Difference
💬 David Keyes

If you've ever tried to improve how your Quarto-based reports look, you probably felt overwhelmed. I'm a data person, you may have thought, not a designer. It's easy to drown in a sea of design advice, but we at R for the Rest of Us have found that a few small tweaks can make a big difference. In this talk, we will discuss ways that we have learned to make high-quality reports in R. These include ways you can consistently use brand fonts and colors in your report text and in your plots. All of these tweaks are small on their own, but, when combined, have the potential to make a big difference in the quality of your report design.

[Slides](https://positconf2024.rfortherestofus.com/slides.html) | [GitHub Repo](https://github.com/rfortherestofus/report-design)

### Reproducible, dynamic, and elegant books with Quarto
💬 Mine Cetinkaya-Rundel

Building on my experience writing books with Quarto for various audiences (R learners, statistics learners, and Quarto learners), for various venues (self-published and publisher-published), in various formats (HTML books hosted online and PDF books printed), I will share best practices and tips and tricks for authoring reproducible, dynamic, and elegant books with Quarto. I will also highlight a few features from the recent releases of Quarto that pertain to books (e.g., flexible and custom cross-references, embedding computations from notebooks, and inline code in multiple languages) as well as share examples of how to make your web-hosted books more interactive with tools like webR and shinylive.

[Slides](https://mine-cetinkaya-rundel.github.io/quarto-books-conf24) | [GitHub Repo](https://github.com/mine-cetinkaya-rundel/quarto-books-conf24)

### Designing and Deploying Internal Quarto Templates
💬 Meghan Hall

Quarto is a game-changer for creating reproducible, parameterized documents. But the beauty of Quarto—that it has so many different use cases with various output formats—can lead to disarray with numerous .qmd files floating around an organization and too much copy-paste when creating something new. Quarto templates are perfect for easing the burden of developing a report and instead standardizing the structure, style, and initial content of your projects, no matter the output format. We’ll discuss tips and tricks for implementing enough HTML and CSS to create beautiful documents that match your organization’s branding and also explore how easy it can be to deploy those Quarto templates with a single function within an internal R package.

Slides | GitHub Repo | [Text of talk](https://meghan.rbind.io/blog/2024-08-14-quarto-templates/)

### Closeread: bringing Scrollytelling to Quarto
💬 Andrew Bray

Scrollytelling is a style of web design that transitions graphics and text as a user scrolls, allowing stories to progress naturally. Despite its power, scrollytelling typically requires specialist web dev skills beyond the reach of many data scientists. Closeread is a Quarto extension that makes a wide range of scrollytelling techniques available to authors without traditional web dev experience, with support for cross-fading plots, graphics and other chunk output alongside narrative content. You can zoom in on poems, prose and images, as well as highlighting important phrases of text.

Finally, Closeread allows authors with experience in Observable JS to write their own animated graphics that update smoothly as scrolling progresses.

Slides | GitHub Repo

### Practical Tips for using Generative AI in Data Science Workflows
💬 Melissa van Bussel

Now that we're a couple of years into the age of Generative AI, it's clear that this technology has the power to transform the way that we work. As Generative AI continues to evolve, the ways that we use these models should evolve, too. In this talk, we'll explore how we, as data professionals, can maximize the benefits of these tools in 2024 and how they can be incorporated into our everyday workflows. We'll also look at creative use cases that might not seem immediately obvious, but that will allow us to combine Generative AI with other data science tools that we already know and love, like Quarto and Shiny.

[Slides](https://github.com/melissavanbussel/posit-conf-2024/blob/main/slides.pdf) | [GitHub Repo](https://github.com/melissavanbussel/posit-conf-2024)

### Shiny x AI
💬 Joe Cheng

These days, you can’t turn around without encountering a large language model—they’re embedded in everything from Google search results to the lower-right corner of every Windows desktop.

But… in your Shiny app?

In this talk, we’ll discuss some ways the Shiny team is combining the magical chaos of LLMs with the structure and control of Shiny. You’ll learn how to use modern chat models to add features to your Shiny apps that will feel like science fiction to your users while minimizing the risks of hallucination, irreproducibility, and data exposure.

[GitHub Repo](https://github.com/jcheng5/py-sidebot)

### Editable data frames in Py-Shiny: Updating original data in real-time
💬 Barret Schloerke

Integrating editable data frames into Py-Shiny and Shinylive applications streamlines data scientists' workflows by allowing real-time data manipulation directly within interactive web applications. This new feature enables users to edit cells within the data frame output. Using the empowered data frame renderer, we can facilitate immediate analysis and visualization feedback. It simplifies the process of data exploration and hypothesis testing, as changes to the data set can be instantly reflected in the application's outputs without the requirement to update the original data, keeping data scientists “scientists”, not data janitors.

[Slides](http://schloerke.com/presentation-2024-08-13-posit-shiny-data-frame/) | [Slides GitHub Repo](https://github.com/schloerke/presentation-2024-08-13-posit-shiny-data-frame) | [Shiny](https://shiny.posit.co/) | [Shiny for Python](https://shiny.posit.co/py/) | [Component gallery](https://shiny.posit.co/py/components/) | [Edit `Data Grid` table cells](https://shiny.posit.co/py/components/outputs/data-grid/#edit-table-cells)

### Building ML and AI apps with Shiny for Python
💬 Winston Chang

In the last few months, the best LLMs have taken a big step forward in their ability to help write code. We’ve been building a tool that uses an LLM to help you learn Shiny and build Shiny applications much faster than ever before.

If you feel like you don’t have the time to invest in learning Shiny, this might change your mind. You’ll get up and running with Shiny in no time, and you’ll be able to learn from the AI as you go. If you already know Shiny, you’ll be able to dramatically accelerate your development process, and you’ll find yourself trying out new things that wouldn’t have been worth the effort before.

Slides | GitHub Repo

### Supercharge Your Shiny (for Python) App: Unleashing Jupyter Widgets for Interactivity
💬 Carson Sievert

Most Python packages that provide interactive web-based visualizations (e.g., altair, plotly, bokeh, ipyleaflet, etc.) can render in Jupyter notebooks via the ipywidgets standard. The shinywidgets package brings that ipywidgets standard to Shiny, enabling the use of 100s of Jupyter Widgets as Shiny outputs. In this talk, you'll not only learn how to render Jupyter Widgets in Shiny to get interactive output, but also how to leverage user interaction with widgets to create delightful and bespoke experiences.

[Slides](https://talks.cpsievert.me/20240814/) | [GitHub Repo](https://github.com/cpsievert/talks/tree/gh-pages/20240814)

### Give me the Data
💬 Colin Gillespie

For the last 20+ years, I've been reading data into R. It all started with the humble scan() function. Then, I used fancy new-fangled file formats, such as parquet and arrow, before progressing onto trendy databases, such as duckdb, for analytics. Besides the fun you can have by messing around with new technologies, when should you consider the above formats? In this talk, I'll cover a variety of methods for importing data and highlight the good, the bad, and the annoying.

### Contributing to the R Project
💬 Heather Turner

Posit provides an amazing set of products to support data science, and we will learn about many great packages and approaches from both Posit and the wider community at posit::conf(2024). But underlying it all are a number of open source tools, notably R and Python. How can we contribute to sustaining these open source projects, so that we can continue to use and build on them?

In this talk I will address this question in the context of the R project. I will give an overview of the ways we can contribute as individuals or companies/organizations, both financially and in kind. Together we can build a more sustainable future for R!

Slides | [GitHub Repo](https://github.com/hturner/positconf2024)

### What I learned resurrecting an R package
💬 Dave Slager

We hear a lot about creating R packages, but R packages don't last forever on their own. I describe my experience resurrecting rvertnet, an abandoned ROpenSci project that had become stale on CRAN. I talk about how I found out the package needed a new maintainer, how I took ownership of the package, and how I decided what needed fixing. I discuss several examples of package repairs I implemented, including fixing outdated CI, removing unnecessary files and dependencies, writing workarounds for deprecated functions, and fixing the building of a vignette. Finally, I'll describe my positive experiences communicating with the old maintainer and submitting a package to CRAN for the first time.

Slides | GitHub Repo

### Building sustainable open-source ecosystems: Lessons from the #rstats community and an NSF grant.
💬 Kelly Bodwin

The blessing and the curse of open-source software is that it lacks the infrastructure of a corporation. It can often be difficult to ensure that projects have stability and longevity. In this talk, I will discuss ongoing work on an NSF "Pathways in Open-Source Ecosystems" grant focused on the {data.table} package. Like many R packages, {data.table} has incredible functionality and thousands of users - but no cohesive community or governance structure to support it long-term. We are working to build this ecosystem. I will provide my advice and insight for key aspects of a sustainable open-source project: Engaging casual users, supporting developers, generating content, emphasizing education, and creating a home base for the community.

[Slides](kbodwin.github.io/positconf_2024) | [GitHub Repo](https://github.com/kbodwin/positconf_2024)

### Deep Learning is Just LEGO: and Other Hands on Machine Learning Activities
💬 Chelsea Parlett-Pelleriti

Machine Learning involves a lot of math, and a lot of code. But it can also involve LEGO, coloring sheets, and 3D-printed gradients! Hands-on, kinesthetic activities help people learn complex technical concepts in an intuitive way, and, to be honest, provide a welcome break from all the formulas and function definitions. These activities not only increase engagement but make the topic more accessible to a wider range of people. Come learn how to use and design these activities for yourself, or for a class!

Slides | GitHub Repo

### Posit Academy in the Age of Generative AI - Lessons from the Frontlines
💬 James Wade

The rise of generative AI is fundamentally changing how we learn to code. At Dow, we've had nearly 200 learners participate in Posit Academy to learn R or Python and apply it to their work. As coders embrace these new tools, we are witnessing a "before and after" moment. This talk will share real-world examples of how researchers at Dow are learning by using code generation, highlighting the most effective tools including copilots and chat agents, to grapple with the challenges and opportunities of learning to code in this transformative era.

Slides | GitHub Repo

### Supporting Social Good Through Community-Based Data Science Education
💬 Carrie Wright

In this data-centric era, the demand for responsible data science practitioners is more crucial than ever. However many data science education programs don’t adequately emphasize data ethics. To address this need, my colleagues, Ava Hoffman, Michael Rosenblum, and I have developed a course at Johns Hopkins, offering students hands-on experiences collaborating with community-based organizations on diverse data science projects. We've partnered with organizations championing various causes, including youth leadership, voting rights, transportation advocacy, and community tool banks. We've gained valuable insights about hands-on data ethics education and demonstrated that even data science education itself can support social good.

[Slides](https://bit.ly/posit_community_data_science)

### AI for Gaming: How I Built a Bot to Play a Video-Game with R and Python
💬 Aleksander Dietrichson

I recently undertook to build a robot to play a video game online. Using reinforcement learning, a custom computer vision model, and browser automation –all implemented in R/Python– I was able to create an AI that played the game to perfection. In this presentation, I will share the lessons learned as I went through this process and some hints to avoid the pitfalls I tackled. I will present some real-world business cases to answer the obvious why-question. For colleagues who teach Data Science and AI, I will show how an activity such as this can provide the entry point and basis for discussion for more than half a dozen topics, ranging from formal logic, game theory, and empirical inference, all the way to Shiny and Quarto.

Slides | GitHub Repo

### Updates from Posit
💬 Hadley Wickham, James Blair, Charlotte Wickham, and George Stagg

Please join us for our first Posit keynote, where we’ll tell you about our mission, our products, and some of the exciting things we’ve been working on over the last year. Hadley Wickham, Chief Scientist, will talk briefly about Posit’s mission and products, before introducing the three speakers who will update you on some of the coolest projects we’ve worked on over the last year. James Blair, Senior Product Manager, will give you the latest on our partnerships with Databricks and Snowflake, and how we’re building seamless integrations that let you focus on data science instead of dealing with technical details. Charlotte Wickham, Developer Educator, will show you what’s new in Quarto, focusing on new ways to build beautiful PDFs with Typst. Finally, George Stagg, Senior Software Engineer, will tell you about the latest innovations in teaching using webR, a tool that lets you compile your R code into standalone HTML files.

### Your journey from data science to animated web graphics
💬 James Goldie

Quarto makes web graphics accessible to data scientists, letting them write Observable JavaScript (OJS) right alongside the languages they already use, like R and Python. OJS is powerful, but making graphics that animate and transition can be a challenge. In this talk I'll demonstrate ways to use Quarto and OJS with graphics libraries to make them react and animate according to your data. We'll even look at making bespoke, reactive graphics with Svelte and D3.js using Sverto, a Quarto extension designed to help you on your web graphics journey.

[Slides](https://positconf2024.talks.jamesgoldie.dev) | [GitHub Repo](https://github.com/jimjam-slam/talk-positconf-aug2024)

### API-first package design — and learning patchwork in the process
💬 Thomas Lin Pedersen

Data visualisation frameworks have an inherent need for good API design in order to be effective due to the potential for unbounded features their creative problem space holds. This talk will go through some of the ways taking an API-first approach to package development can play out, drawing on the experience of developing and maintaining the patchwork package over many years. Through the talk, the audience will also get an introduction to the use of patchwork, a package designed to make it effortless to combine multiple plots into a single composite figure.

### From idea to code to image: Creative data visualizations in R
💬 Georgios Karamanis

In this talk, we will walk through the process of converting an idea into a creative visualization in R and ggplot2, from finding inspiration to writing the code. We’ll look at handy tips to make the creative and coding process smoother, how to create more personal plots, as well as the importance (and fun!) of sharing your work with a great community.

[Slides](https://github.com/gkaramanis/posit_conf_2024/blob/main/From%20idea%20to%20code%20to%20image%20-%20creative%20data%20visualizations%20in%20R%20-%20Georgios%20Karamanis.pdf) | [GitHub Repo](https://github.com/gkaramanis/posit_conf_2024)

### Be Kind, Rewind
💬 Ellis Hughes

Imagine a world where crafting a stunning, insightful data visualization is not just about the end product, but the journey. A world where every decision, every tweak, every step in your creative process is not just a fleeting moment, but a valuable artifact. {camcorder} is an innovative R package that revolutionizes the way you create and share your data visualizations. It not only allows you to preview your visualizations exactly as they will be saved but also records every plot you create, turning your creative process into a compelling narrative.

Discover the inspiration behind {camcorder}’s creation, its use, and explore the ways you can leverage it to tell captivating stories to your stakeholders. Are you ready to press play?

Slides | [GitHub Repo](https://github.com/thebioengineer/posit_conf_2024_be_kind_rewind)

### Fair machine learning
💬 Simon Couch

In recent years, high-profile analyses have called attention to many contexts where the use of machine learning deepened inequities in our communities. After a year of research and design, the tidymodels team is excited to share a set of tools to help data scientists develop fair machine learning models and communicate about them effectively. This talk will introduce the research field of machine learning fairness and demonstrate a fairness-oriented analysis of a machine learning model with tidymodels.

[Slides](https://simonpcouch.github.io/conf-24) | [GitHub Repo](https://github.com/simonpcouch/conf-24)

### tidymodels for time-to-event data
💬 Hannah Frick

Time-to-event data can show up in a broad variety of contexts: the event may be a customer churning, a machine needing repairs or replacement, a pet being adopted, or a complaint being dealt with. Survival analysis is a methodology that allows you to model both aspects, the time and the event status, at the same time. tidymodels now provides support for this kind of data across the framework.

[Slides](https://hfrick.github.io/2024-posit-conf/) | [GitHub Repo](https://github.com/hfrick/2024-posit-conf)

### Evaluating Time-to-Event Models is Hard
💬 Max Kuhn

Censoring in data can frequently occur when we have a time-to-event. For example, if we order a pizza that has not yet arrived after 5 minutes, it is censored; we don't know the final delivery time, but we know it is at least 5 minutes. Censored values can appear in clinical trials, customer churn analysis, pet adoption statistics, or anywhere a duration of time is used. I'll describe different ways to assess models for censored data and focus on metrics requiring an evaluation time (i.e., how well does the model work at 5 minutes?). I'll also describe how you can use tidymodel's expanded features for these data to tell if your model fits the data well. This talk is designed to be paired with the other tidymodels talk by Hannah Frick.

[Slides](https://topepo.github.io/2024-posit-conf/) | [GitHub Repo](https://github.com/topepo/2024-posit-conf)

### Tidypredict with recipes, turn workflow to SQL, spark, duckdb and beyond
💬 Emil Hvitfeldt

Tidypredict is one of my favorite packages. Being able to turn a fitted model object into an equation is very powerful! However, in tidymodels, we use recipes more and more to do preprocessing. So far, tidypredict didn’t have support for recipes, which severely limited its uses. This talk is about how I fixed that issue. After spending a couple of years thinking about this problem, I finally found a way! Being able to turn a tidymodels workflow into a series of equations for prediction is super powerful. For some uses, being able to turn a model to predict inside SQL, spark or duckdb allows us to handle some problems with more ease.

[Slides](https://emilhvitfeldt.github.io/talk-orbital-positconf/) | [GitHub Repo](https://github.com/EmilHvitfeldt/talk-orbital-positconf/tree/main)

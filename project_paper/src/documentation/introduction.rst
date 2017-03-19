.. _introduction:


************
Introduction
************

* We cloned the template from the repository.

* Author names, affiliation and project title are changed: Isa Marques, Xi Sun, Xueying Liu; SIX; Semiparametric Single Index Models: Ichimura and Klein and Spady's methods.

* The project is run through following steps:

    * python waf.py configure
    * python waf.py build
    * python waf.py install

* Extra modifications are necessary to prevent error when calling biber:

    * Change ctx.load('biber') to ctx.load('tex') in main wscript.
    * Change similarly in src/paper/research_paper.tex and src/paper/research_pres_30min.tex backend=biber by bibtex.

* The logic of the project works by step of the analysis: 

    1. Data management;
    2. The actual estimations / simulations;
    3. Visualisation and results formatting;
    4. Research paper and presentations. 

* In this project, tasks are divided across directories in **src/** in the following way:

    1. The **data management** directory contains random draws of simulation data. These draws correpond to model specifications in **model specs**. 
    2. The **model specs** directory includes models characterized by parameters, which are differentiated by sample size and error distribution.
    3. The **model code** directory is empty in the present case as testing is more favourable to the situation in which all files are in one folder, in which instructions for build can be given.
    4. The **analysis** directory provides the estimation code for the two methods: Ichimura's and Klein and Spady's. Each of the two is subject to testing. Simulation code for calculation of figures and tables is also provided.
    5. The **empirical data** directory saves a .csv file which provides a set of data for an empirical application of the semi-parametric methods.
    6. The **empirical analysis** directory contains codes analysing this empirical data set with our estimation models and calculating results for table.
    7. The **final** directory has the code that creates all figures and tables from the content calculated in **analysis** and **empirical analysis**. This content is transported from one directory to the other with the help of *pickle*.

Documentation on the rationale, Waf, and more background is at http://hmgaudecker.github.io/econ-project-templates/
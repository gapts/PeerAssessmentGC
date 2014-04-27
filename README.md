# Peer Assessment 1 - Getting and Cleaning Data

<img src="http://www.sudcamp.com/wp-content/uploads/2013/02/accelorometer-sensor-1.png" align="right" height="175" width="175"/>

------

Author: **Stagirite (Pseudonym)**  
Created: **April-26-2014** 

------


The files in this repository contain the archives required for the **Peer Assessment 1 of the Getting and Cleaning Data course**.

### Description

The purpose of this project was to collect, work with, and clean the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) data set using the knowledge adquired in the [Getting and Cleaning Data](https://www.coursera.org/course/getdata) course offered by [Coursera](https://www.coursera.org/). The goal is to prepare a tidy data set  that can be used for later analysis.  

### File Organization

There are three files:
* `README.md` (this one): Explains how all of the files work and how they are connected.  
* `CodeBook.md`: Describes the variables, the data, and any transformations or work made to clean up the data.
* `run_analysis.R`: Contains the code to collect, work with, and clean the data in order to get a tidy data set.

### Reproduce the project

In order to reproduce the project you should run the `run_analysis.R` in [R](http://www.r-project.org/).  The script will create a folder __STAGIRITE_PA01__ that containt:

* A file called `DataDownloadDate.txt` with the date when the data was download.
* A folder called __RAW_DATA__ with the raw data.  
* A folder called __PROCESSED_DATA__ with the processed data stored in a file `TidyAverageDataSet.csv`.

__Note__: This script was written and executed on a Mac, you could have some difficults in other operating systems.

### Session Info

The `run_analysis.R` script was executed in [RStudio](http://www.rstudio.com/) (v. 0.98.501) with the following R session:

```{S}
R version 3.1.0 (2014-04-10)
Platform: x86_64-apple-darwin10.8.0 (64-bit)

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets 
[6] methods   base     

other attached packages:
[1] plyr_1.8.1   reshape2_1.4

loaded via a namespace (and not attached):
[1] Rcpp_0.11.1   stringr_0.6.2 tools_3.1.0
```

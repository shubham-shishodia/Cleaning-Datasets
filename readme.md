#Getting and Cleaning Data - Week 4 - Final Assignment

## Problem Statement

To obtain a tidy dataset conforming to the guidelines provided by the assignment instructions as well as general tidy dataset principles
from Samsung Galaxy S2 accelerometer and gyroscope data. The description of the data is given below.

## About the Data

The data is available at UCI's Machine Learning [Archive](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The data contains various movement data recorded by a smartphone attached to the waists of 30 volunteers. 70% of the recorded data
was randomly chosen as training data and the rest 30% as the test data. More details about the data is available at the link mentioned
above.

## Repository Contents

The repository contains the following files:

| File Name      | Description                                                                                                |
|----------------|------------------------------------------------------------------------------------------------------------|
| readme.md      | Documentation explaining the contents of the repository and what each of the files do                      |
| codebook.md    | File containing description of the variables of the final, tidy dataset                                    |
| run_analysis.R | R script containing functions that process raw data and output a tidy dataset conforming to the guidelines |

## Function of the **run_analysis.R** Script

The R script reads in the training, and test data, along with their activity, and volunteer (subject) label from various files and
binds them to form a large single dataset. It then extracts measurements on mean and standard deviation of the measurements. The script
also provides descriptive activity names for the numeric labels in the data and assigns descriptive variable names to the measurements.
The variable names are constructed from the "features.txt" file and are formatted according to the rules that were mentioned during the 
Week 4 course lectures (lowercase names without special characters). The script does so with the help of 4 functions. Details of the 4 
functions are provided in the script comments.

## References and Help

1. Mentor Leonard Greski's [blogpost](https://github.com/lgreski/acsexample) were helpful for writing readme and codebook for the assignment
2. David Hood's [blogpost](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) was really helpful to 
   provide hints and a general procedure on how to go about writing the script
3. I learnt basic markdown formatting from the [link](https://blog.ghost.org/markdown/) here.
4. The tables in the "readme" and "codebook" were generated using this [website](http://www.tablesgenerator.com/markdown_tables)

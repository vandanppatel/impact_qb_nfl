# Impact of QBs in NFL

## Overview
Quarterbacks (QBs) are often seen as pivotal to the success of NFL teams, yet the extent of their influence remains 
debated. This paper explores the relationship between quarterback performance metrics—such as passing yards, touchdowns, 
and interceptions—and team-level outcomes, including total wins, playoff qualification, and average point differential. 
Using Bayesian regression models, we quantify these relationships, emphasizing the complex interplay between individual 
contributions and team success. Our findings reveal that while QBs are important, their role is part of a larger system 
where team cohesion, defensive strength, and coaching strategies also play crucial roles. This analysis contributes to 
the ongoing conver- sation about building balanced NFL teams, offering insights for sports analysts, coaches, and 
strategists alike.

## File Structure

The repo is structured as:

-   `data/pbp_data_2023.csv.zip` contains the raw data as obtained from nflfastR.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

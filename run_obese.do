clear
set more off

* define global macro: path ----------------------------------------------------
global obesedrg "/Users/azfar/Documents/Stata Files/Research/Obesity Drug"
global obesedrgdata "/Users/azfar/Documents/Stata Files/Research/Obesity Drug/Data"
global figure "/Users/azfar/Documents/Stata Files/Research/Obesity Drug/Figure"

* define global macro: covariates (for list) -----------------------------
global cov_l_dmg "sex age31x race usborn marry" // demographics
global cov_l_edc "hideg" // education
global cov_l_ecn "wagep ttlp povlev" // economics
global cov_l_ins "inscov pmdins" // insurance

* define global macro: covariates (for regression) -----------------------------
global cov_dmg "i.sex age31x i.race i.usborn i.marry" // demographics
global cov_edc "i.hideg" // educatiom
global cov_ecn "wagep ttlp povlev" // economics
global cov_ins "i.inscov i.pmdins" // insurance

do generate_yearfiles.do // download, link and produce consolidated year files

do move_yearfiles.do // copy, move and rename yearfiles to a different folder

do append_yearfiles.do // produce a single data file

do generate_month.do // generate month variable

do generate_variables.do // generate consolidated variables

do generate_analysis_dataset.do // produces a smaller dataset for analysis

do generate_tables.do // generate pre-analysis tables

do generate_graphs.do // generate pre-analysis graphs

do analysis_did2.do // run DiD analysis                        

do analysis_did2_hetero.do // run heterogeneity DiD analysis  

do analysis_did2_othrx.do // run DiD analysis on other obesity rx

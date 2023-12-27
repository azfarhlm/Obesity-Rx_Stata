cd "$obesedrgdata"
use compile.dta

* quaterly variable ------------------------------------------------------------
*gen t_rxbeg_qr = yq(year, ceil(t_rxbeg/3))

* number of patients begin taking liraglutide in a given month-year ------------
bysort t_rxbeg : egen num_beg_lir = count(t_rxbeg) if t_rxbeg != 0 & ///
!missing(t_rxbeg) & obesitydrug_multum_lir == 1 

* br t_rxbeg num_beg_lir obesitydrug_multum_lir year rxbegyr num_coh rt_beg_lir rtbeglir if obesitydrug_multum_lir == 1
 
* number of patients begin taking other obesity medication in a given month-year
* // use rxname for these drugs to observe long period
bysort t_rxbeg : egen num_beg_top = count(t_rxbeg) if t_rxbeg != 0 & ///
!missing(t_rxbeg) & rxname == "TOPIRAMATE" & year == rxbegyr

bysort t_rxbeg : egen num_beg_phe = count(t_rxbeg) if t_rxbeg != 0 & ///
!missing(t_rxbeg) & rxname == "PHENTERMINE" & year == rxbegyr

bysort t_rxbeg : egen num_beg_bup = count(t_rxbeg) if t_rxbeg != 0 & ///
!missing(t_rxbeg) & rxname == "BUPROPION" & year == rxbegyr

bysort t_rxbeg : egen num_beg_oth = count(t_rxbeg) if t_rxbeg != 0 & ///
!missing(t_rxbeg) & obesitydrug_multum_non_lirsem == 1 & year == rxbegyr


* standardize dupersid variable ------------------------------------------------
/*
- panel_dupersid is the standardized version 
- dupersid 2018 onwards begin with panel number, need to substr it out
- gen dupersid_18 = real(substr(string(dupersid,"%14.0g"),3,10)) if year >= 2018 
*/

tostring dupersid, gen(dupersid_s) 
gen dupersid_subs_18 = substr(dupersid_s,3,10) if year >= 2018
destring dupersid_subs_18, gen(dupersid_n_18)
replace dupersid = dupersid_n_18 if year >= 2018

gen panel_l = panel*100000000
describe panel_l
recast double panel_l 
format panel_l %14.0g

gen panel_dupersid = .
describe panel_dupersid
recast double panel_dupersid
format panel_dupersid %14.0g
replace panel_dupersid = panel_l + dupersid // unique person identifier across panels

* standardize bmi variable -----------------------------------------------------
bysort panel_dupersid: egen bmi = max(adbmi42) if year >= 2017
replace bmi = bmindx53 if year <= 2016

* number of patients in a year -------------------------------------------------
egen tag = tag(panel_dupersid)
egen num_coh = total(tag), by(rxbegyrx)

* rate of patients begin taking liraglutide and other obesity drugs in a \\
* given month-year -------------------------------------------------------------
gen rt_beg_lir = num_beg_lir/num_coh
gen rt_beg_top = num_beg_top/num_coh
gen rt_beg_phe = num_beg_phe/num_coh
gen rt_beg_bup = num_beg_bup/num_coh
gen rt_beg_oth = num_beg_oth/num_coh
 
* obese based on BMI -----------------------------------------------------------
gen obese_1 = inrange(bmi,30, 34.9) // class 1 obesity
gen obese_2 = inrange(bmi,35, 39.9) // class 2 obesity 
gen obese_3 = inrange(bmi,40, 100) // class 3 obesity 
gen obese = (obese_1) | (obese_2) | (obese_3) // any obesity

* diabetes based on survey diagnosis question ----------------------------------
gen diabd = 1 if diabdx == 1 | diabdx_m18 == 1
replace diabd = 0 if diabdx == 2 | diabdx_m18 == 2

* diabetes based on ICD code ---------------------------------------------------
gen diab = (icd9codx == "250") | (icd10cdx == "E11") // ICD-10 starts 2016

* non-diabetic, obese ----------------------------------------------------------
gen obese_nondiab = (obese == 1) & (diab == 0) // ICD diabetic def
gen obese_nondiabd = (obese == 1) & (diabd == 0) // survey diagnostic diabetic def


* diabetic, non-obese ----------------------------------------------------------
gen diab_nonobese = (diab == 1) & bmi < 30
**# Bookmark #1

* treatment variables ----------------------------------------------------------
gen treat_obese_v_nonobese = (obese == 1)

gen treat_obesenondiab_v_diab = (obese == 1) // based on ICD code diabetes
replace treat_obesenondiab_v_diab = 0 if treat_obesenondiab_v_diab == 0 & diab == 1 // treatment: obese nondiab, control: all diabetic
replace treat_obesenondiab_v_diab = . if treat_obesenondiab_v_diab == 0 & diab == 0

gen treat_obesenondiabd_v_diabd = (obese == 1) & diabd == 0 // based on survey diagnosis diabetes
replace treat_obesenondiabd_v_diabd = . if treat_obesenondiabd_v_diabd == 0
replace treat_obesenondiabd_v_diabd = 0 if diabd == 1 // treatment: obese nondiabd, control: all diabetic

* treatment_post variables -----------------------------------------------------
gen post = 1 if rxbegyrx >= 2015 // indicate post treatment period
replace post = 0 if rxbegyrx < 2015

gen treat_obese_v_nonobese_post = treat_obese_v_nonobese*post
gen treat_obesenondiab_v_diab_post =  treat_obesenondiab_v_diab*post
gen treat_obesenondiabd_v_diabd_post =  treat_obesenondiabd_v_diabd*post

* liraglutide utilizatio with insurance variables ------------------------------
gen ins_util_lir = 1 if rxxp - rxsf >= 0 & obesitydrug_multum_lir == 1 // non-zero non-OOP i.e. insurance utilization
replace ins_util_lir = 0 if rxxp - rxsf  == 0 & obesitydrug_multum_lir == 1 // full OOP, i.e. no ins utilization

* rx utilization by treatment group -----------------------------------
bysort t_rxbeg treat_obesenondiabd_v_diabd : egen rtbeglir = max(cond(!missing(rt_beg_lir), rt_beg_lir, 0))
bysort t_rxbeg : egen rtbeglir2 = max(cond(!missing(rt_beg_lir), rt_beg_lir, 0))
bysort rxbegyrx : egen rtbeglir3 = mean(cond(!missing(rt_beg_lir), rt_beg_lir, 0))
bysort t_rxbeg treat_obesenondiabd_v_diabd : egen rtbeglir_m = max(cond(!missing(rt_beg_lir), rt_beg_lir, .))
bysort t_rxbeg : egen rtbeglir2_m = max(cond(!missing(rt_beg_lir), rt_beg_lir, .))
bysort rxbegyrx : egen rtbeglir3_m = mean(cond(!missing(rt_beg_lir), rt_beg_lir, .))

bysort t_rxbeg : egen rtbeglir4_m = max(cond(!missing(rt_beg_lir), rt_beg_lir, .)) if treat_obesenondiabd_v_diabd != .


bysort t_rxbeg : egen rtbegtop2_m = max(cond(!missing(rt_beg_top), rt_beg_top, .))
bysort t_rxbeg : egen rtbegphe2_m = max(cond(!missing(rt_beg_phe), rt_beg_phe, .))
bysort t_rxbeg : egen rtbegbup2_m = max(cond(!missing(rt_beg_bup), rt_beg_phe, .))

* race, consolidated -----------------------------------------------------------
clonevar race = racex if year <= 2011
replace race = racev1x if year >= 2012 & year <= 2019

* born in the usa, consolidated ------------------------------------------------
clonevar usborn = bornusa if year >= 2014 & year <= 2019
replace usborn = usborn42 if year <= 2013 

* marital status, consolidated -------------------------------------------------
clonevar marry = marry10x if year == 2010  // initiate
local yr "11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace marry = marry`x'x if year == 20`x'
}

* student status, consolidated -------------------------------------------------
clonevar stu = ftstu10x if year == 2010  // initiate
local yr "11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace stu = ftstu`x'x if year == 20`x'
}

* education level, consolidated ------------------------------------------------
replace eduyrdg = 1 if eduyrdg == 2 | eduyrdg == 5 
replace eduyrdg = 2 if eduyrdg == 3
replace eduyrdg = 3 if eduyrdg == 4
replace eduyrdg = 7 if eduyrdg == 6 | eduyrdg == 7
replace eduyrdg = 4 if eduyrdg == 8
replace eduyrdg = 5 if eduyrdg == 9
replace eduyrdg = 8 if eduyrdg == 10

replace hideg = eduyrdg if year == 2013 | year == 2014
replace hideg = 5 if hideg == 6 // no separate doctorate degree option in 2013, 2014

  
* wage, consolidated -----------------------------------------------------------
gen wagep = . // initialize
local yr "10 11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace wagep = wagep`x'x if year == 20`x'
}

* bysort year: sum wagep
* income, consolidated ---------------------------------------------------------
gen ttlp = . // initialize
local yr "10 11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace ttlp = ttlp`x'x if year == 20`x'
}

* income, consolidated ---------------------------------------------------------
gen povlev = . // initialize
local yr "10 11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace povlev = povlev`x' if year == 20`x'
}

* insurance eligibility unit, categoricalized ----------------------------------
* encode hieuidx, gen(hieu) // long computation; not saved as of 6/13/23 6.15pm

* insurance coverage, consolidated ---------------------------------------------
clonevar inscov = inscov10 // initialize
local yr "11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace inscov = inscov`x' if year == 20`x'
}

* prescription medicine insurance coverage, consolidated -----------------------
clonevar pmdins = pmdins10 // initialize
local yr "11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace pmdins = pmdins`x' if year == 20`x'
}

* total healthcare expenditure, consolidated -----------------------
clonevar totexp = totexp10 // initialize
local yr "11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace totexp = totexp`x' if year == 20`x'
}

* total OOP healthcare expenditure, consolidated -----------------------
clonevar totslf = totslf10 // initialize
local yr "11 12 13 14 15 16 17 18 19"
foreach x in `yr'{
	replace totslf = totslf`x' if year == 20`x'
}

* label variables --------------------------------------------------------------
label variable age31x "Age"
label variable sex "Sex"
label variable obesitydrug_multum_lir "Liraglutide"
label variable bmi "Body Mass Index (BMI)"
label variable obese "Obese"
label variable diab "Diabetic"
label variable diabd "Diabetic Diagnosis"
label variable race "Race"
label variable usborn "Born in the US"
label variable marry "Marital Status"
label variable stu "Student Status"
label variable educ "Years of Education"
label variable hideg "Education Level"
label variable wagep "Personal Wage"
label variable ttlp "Personal Total Income"
label variable povlev "Family Income as a Percentage of Poverty Line"
label variable inscov "Health Insurance Coverage"
label variable pmdins "Prescription Medicine Insurance Coverage"
label variable rt_beg_lir "Utilization (Initiation) Rate of Liraglutide"
label variable rt_beg_top  "Utilization (Initiation) Rate of Topiramate"
label variable rt_beg_phe  "Utilization (Initiation) Rate of Phentermine"
label variable rt_beg_bup  "Utilization (Initiation) Rate of Bupropion"
label variable rt_beg_oth  "Utilization (Initiation) Rate of Non-Liraglutide"
label variable totexp "Total Healthcare Expenditure"
label variable totslf "Out-of-Pocket Healthcare Expenditure"

save compile.dta, replace
cd "$obesedrg"

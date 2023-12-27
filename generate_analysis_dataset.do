cd "$obesedrgdata"
use rt_beg_lir  rtbeglir rtbeglir2 rtbeglir3 rtbeglir_m rtbeglir2_m  rtbegtop2_m  rtbegphe2_m  rtbegbup2_m rtbeglir3_m rtbeglir4_m num_beg_lir num_coh rt_beg_top rt_beg_phe rt_beg_bup rt_beg_oth treat_obese_v_nonobese treat_obese_v_nonobese_post treat_obesenondiab_v_diab treat_obesenondiab_v_diab_post treat_obesenondiabd_v_diabd treat_obesenondiabd_v_diabd_post year ins_util_lir obesitydrug_multum_lir obese_nondiab obese_nondiabd duid dupersid panel_dupersid obese diab diabd bmi $cov_l_dmg $cov_l_edc $cov_l_ecn $cov_l_ins obese_1 obese_2 obese_3 post t_rxbeg rxbegyrx totexp totslf perwtf varstr varpsu using compile.dta

* recode negative values
replace age31x = . if age31x < 0

replace marry = . if marry <= 0

replace usborn = . if usborn <= 0
replace usborn = 0 if usborn == 2

replace inscov = 0 if inscov == 3

replace pmdins = . if pmdins <= 0
replace pmdins = 0 if pmdins == 2

replace hideg = hideg + 16
replace hideg = 1 if hideg == 7 // consolidate values

* create value labels
label define hideg_l 1 "Cannot be Computed" 7 "Not Ascertained" 8 "Don't Know" 9 "Refused" 15 "Inapplicable" 17 "No Degree" 18 "GED" 19 "High School Diploma" 20 "Bachelor's Degree" 21 "Advanced Degree" 23 "Other Degree" 24 "Under 16 (Inapplicable)"
label define sex_l 1 "Male" 2 "Female"
label define race_l 1 "White" 2 "Black" 3 "Native" 4 "Asian" 6 "Multiple"
label define yesno_l 1 "Yes" 0 "No"
label define marry_l 1 "Married" 2 "Widowed" 3 "Divorced" 4 "Separated" 5 "Never Married" 
label define inscov_l 1 "Any Private" 2 "Public Only" 0 "No"

* attach value labels
label values hideg hideg_l
label values sex sex_l
label values race race_l
label values usborn yesno_l
label values marry marry_l
label values hideg hideg_l
label values inscov inscov_l
label values pmdins yesno_l

* linear trend variable
gen trend = 1 if rxbegyrx == 2010
replace trend = 2 if rxbegyrx == 2011
replace trend = 3 if rxbegyrx == 2012
replace trend = 4 if rxbegyrx == 2013
replace trend = 5 if rxbegyrx == 2014
replace trend = 6 if rxbegyrx == 2015
replace trend = 7 if rxbegyrx == 2016
replace trend = 8 if rxbegyrx == 2017
replace trend = 9 if rxbegyrx == 2018
replace trend = 10 if rxbegyrx ==  2019

* rename treatment variables, too long error
rename treat_obese_v_nonobese_post treat1
rename treat_obesenondiab_v_diab_post treat2
rename treat_obesenondiabd_v_diabd_post treat3
rename treat_obesenondiabd_v_diabd treat3grp

* post trend variables
gen trendtreat2 = trend*obese_nondiab
gen trendtreat3 = trend*treat3grp
gen trendcontrol3 = trend if obese_nondiabd == 0

* heterogeneity treatment variables
gen treat3grpo1 = (treat3grp == 1) if obese_1 == 1
gen treat3grpo2 = (treat3grp == 1) if obese_2 == 1
gen treat3grpo3 = (treat3grp == 1) if obese_3 == 1

gen treat3o1 = treat3grpo1*post
gen treat3o2 = treat3grpo2*post
gen treat3o3 = treat3grpo3*post

gen trendtreat3o1 = trend*treat3grpo1
gen trendtreat3o2 = trend*treat3grpo2
gen trendtreat3o3 = trend*treat3grpo3

* lead and lag years
* interact lead and lag with treatment group; set control group as 0 in all lead and lag
* drop lead1 lead2 lead3 lead4 lead5 lag1 lag2 lag3 lag4 lag5
* overall obesity
gen ld1 = (rxbegyrx == 2014) & (treat3grp == 1) 
gen ld2 = (rxbegyrx == 2013) & (treat3grp == 1)
gen ld3 = (rxbegyrx == 2012) & (treat3grp == 1)
gen ld4 = (rxbegyrx == 2011) & (treat3grp == 1)
gen ld5 = (rxbegyrx == 2010) & (treat3grp == 1)
gen lg1 = (rxbegyrx == 2015) & (treat3grp == 1)
gen lg2 = (rxbegyrx == 2016) & (treat3grp == 1)
gen lg3 = (rxbegyrx == 2017) & (treat3grp == 1)
gen lg4 = (rxbegyrx == 2018) & (treat3grp == 1)
gen lg5 = (rxbegyrx == 2019) & (treat3grp == 1)

replace ld1 = 0 if treat3grp == 0 & rxbegyrx == 2014
replace ld2 = 0 if treat3grp == 0 & rxbegyrx == 2013
replace ld3 = 0 if treat3grp == 0 & rxbegyrx == 2012
replace ld4 = 0 if treat3grp == 0 & rxbegyrx == 2011
replace ld5 = 0 if treat3grp == 0 & rxbegyrx == 2010
replace lg1 = 0 if treat3grp == 0 & rxbegyrx == 2015
replace lg2 = 0 if treat3grp == 0 & rxbegyrx == 2016
replace lg3 = 0 if treat3grp == 0 & rxbegyrx == 2017
replace lg4 = 0 if treat3grp == 0 & rxbegyrx == 2018
replace lg5 = 0 if treat3grp == 0 & rxbegyrx == 2019

* obesity 1
gen ld1o1 = (rxbegyrx == 2014) & (treat3grpo1 == 1) 
gen ld2o1 = (rxbegyrx == 2013) & (treat3grpo1 == 1)
gen ld3o1 = (rxbegyrx == 2012) & (treat3grpo1 == 1)
gen ld4o1 = (rxbegyrx == 2011) & (treat3grpo1 == 1)
gen ld5o1 = (rxbegyrx == 2010) & (treat3grpo1 == 1)
gen lg1o1 = (rxbegyrx == 2015) & (treat3grpo1 == 1)
gen lg2o1 = (rxbegyrx == 2016) & (treat3grpo1 == 1)
gen lg3o1 = (rxbegyrx == 2017) & (treat3grpo1 == 1)
gen lg4o1 = (rxbegyrx == 2018) & (treat3grpo1 == 1)
gen lg5o1 = (rxbegyrx == 2019) & (treat3grpo1 == 1)

replace ld1o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2014
replace ld2o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2013
replace ld3o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2012
replace ld4o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2011
replace ld5o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2010
replace lg1o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2015
replace lg2o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2016
replace lg3o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2017
replace lg4o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2018
replace lg5o1 = 0 if treat3grpo1 == 0 & rxbegyrx == 2019


* obesity 2
gen ld1o2 = (rxbegyrx == 2014) & (treat3grpo2 == 1) 
gen ld2o2 = (rxbegyrx == 2013) & (treat3grpo2 == 1)
gen ld3o2 = (rxbegyrx == 2012) & (treat3grpo2 == 1)
gen ld4o2 = (rxbegyrx == 2011) & (treat3grpo2 == 1)
gen ld5o2 = (rxbegyrx == 2010) & (treat3grpo2 == 1)
gen lg1o2 = (rxbegyrx == 2015) & (treat3grpo2 == 1)
gen lg2o2 = (rxbegyrx == 2016) & (treat3grpo2 == 1)
gen lg3o2 = (rxbegyrx == 2017) & (treat3grpo2 == 1)
gen lg4o2 = (rxbegyrx == 2018) & (treat3grpo2 == 1)
gen lg5o2 = (rxbegyrx == 2019) & (treat3grpo2 == 1)

replace ld1o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2014
replace ld2o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2013
replace ld3o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2012
replace ld4o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2011
replace ld5o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2010
replace lg1o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2015
replace lg2o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2016
replace lg3o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2017
replace lg4o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2018
replace lg5o2 = 0 if treat3grpo2 == 0 & rxbegyrx == 2019

* obesity 3
gen ld1o3 = (rxbegyrx == 2014) & (treat3grpo3 == 1) 
gen ld2o3 = (rxbegyrx == 2013) & (treat3grpo3 == 1)
gen ld3o3 = (rxbegyrx == 2012) & (treat3grpo3 == 1)
gen ld4o3 = (rxbegyrx == 2011) & (treat3grpo3 == 1)
gen ld5o3 = (rxbegyrx == 2010) & (treat3grpo3 == 1)
gen lg1o3 = (rxbegyrx == 2015) & (treat3grpo3 == 1)
gen lg2o3 = (rxbegyrx == 2016) & (treat3grpo3 == 1)
gen lg3o3 = (rxbegyrx == 2017) & (treat3grpo3 == 1)
gen lg4o3 = (rxbegyrx == 2018) & (treat3grpo3 == 1)
gen lg5o3 = (rxbegyrx == 2019) & (treat3grpo3 == 1)

replace ld1o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2014
replace ld2o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2013
replace ld3o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2012
replace ld4o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2011
replace ld5o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2010
replace lg1o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2015
replace lg2o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2016
replace lg3o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2017
replace lg4o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2018
replace lg5o3 = 0 if treat3grpo3 == 0 & rxbegyrx == 2019

save compile_ana.dta, replace
cd "$obesedrg"

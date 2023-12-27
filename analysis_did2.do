cd "$obesedrgdata"
use compile_ana.dta, clear
set seed 012
sample .2
* ssc install outreg2, replace
 
* obese non-diabetic vs diabetic: survey diagnosis  ----------------------------
* basic ------------------------------------------------------------------------
preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo clear
eststo m1: ///
didregress (rtbeglir2_m) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate " "
global trend " "
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3_obesenondiab_diab_treatvardef_basic.png, replace
cd "$obesedrg"
restore

* with controls ----------------------------------------------------------------
preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m2: ///
didregress (rtbeglir2_m ${cov_dmg}) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_dmg}"
global trend ""
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3_obesenondiab_diab_treatvardef_dmg.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m3: ///
didregress (rtbeglir2_m ${cov_edc}) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_edc}"
global trend ""
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3_obesenondiab_diab_treatvardef_edc.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m4: ///
didregress (rtbeglir2_m ${cov_ecn}) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_ecn}"
global trend ""
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3_obesenondiab_diab_treatvardef_ecn.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m5: ///
didregress (rtbeglir2_m ${cov_ins}) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_ins}"
global trend ""
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3_obesenondiab_diab_treatvardef_ins.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m6: ///
didregress (rtbeglir2_m ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend ""
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins.png, replace
cd "$obesedrg"
restore

cd "$obesedrg/Table"
esttab m1 m2 m3 m4 m5 m6 using did2_tv3_est.tex, compress se label replace star(* 0.10 ** 0.05 *** 0.01) 
cd "$obesedrg"


* obese non-diabetic vs diabetic: survey diagnosis; linear trend control  ------
* basic ------------------------------------------------------------------------
preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo clear
eststo m1: ///
didregress (rtbeglir2_m trendtreat3) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate " "
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obesenondiab_diab_treatvardef_basic.png, replace
cd "$obesedrg"
restore

* with controls ----------------------------------------------------------------
preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m2: ///
didregress (rtbeglir2_m ${cov_dmg} trendtreat3) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_dmg}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obesenondiab_diab_treatvardef_dmg.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m3: ///
didregress (rtbeglir2_m ${cov_edc} trendtreat3) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_edc}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obesenondiab_diab_treatvardef_edc.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m4: ///
didregress (rtbeglir2_m ${cov_ecn} trendtreat3) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_ecn}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obesenondiab_diab_treatvardef_ecn.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m5: ///
didregress (rtbeglir2_m ${cov_ins} trendtreat3) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_ins}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obesenondiab_diab_treatvardef_ins.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m6: ///
didregress (rtbeglir2_m ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins} trendtreat3) (treat3) [pweight = perwtf], group(treat3grp) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins.png, replace
cd "$obesedrg"
restore

cd "$obesedrg/Table"
esttab m1 m2 m3 m4 m5 m6 using did2_tv3lt_est.tex, compress se label replace star(* 0.10 ** 0.05 *** 0.01) 
cd "$obesedrg"

save compile_ana.dta, replace
cd "$obesedrg"

cd "$obesedrgdata"
use compile_ana.dta, clear
set seed 012
sample .2

preserve
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo clear
eststo m1: ///
didregress (rtbegtop2_m trendtreat3 ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}) (treat3) if year <= 2019 [pweight = perwtf], group(treat3grp) time(rxbegyrx) vce(cluster duid)
global outcome "rtbegtop2_m"
global treatment "treat3"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_othrx_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obese_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins_top.png, replace
cd "$obesedrg"
restore


preserve
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m2: ///
didregress (rtbegphe2_m trendtreat3 ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}) (treat3) if year <= 2019 [pweight = perwtf], group(treat3grp) time(rxbegyrx) vce(cluster duid)
global outcome "rtbegphe2_m"
global treatment "treat3"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_othrx_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_obese_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins_phe.png, replace
cd "$obesedrg"
restore

/*preserve
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m3: ///
didregress (rtbegbup2_m trendtreat3 ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}) (treat3) if year <= 2019 [pweight = perwtf], group(treat3grp) time(rxbegyrx) vce(cluster duid)
global outcome "rtbegbup2_m"
global treatment "treat3"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3"
cd "$obesedrg"
do analysis_es_othrx_run2.do
cd "$obesedrg/Figure"
graph export  did2_tv3lt_obese_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins_bup.png, replace
cd "$obesedrg"
restore*/


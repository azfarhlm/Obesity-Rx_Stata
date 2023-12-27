cd "$obesedrgdata"
use compile_ana.dta, clear
set seed 012
sample .2

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m1: ///
didregress (rtbeglir2_m ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins} trendtreat3o1) (treat3o1) [pweight = perwtf] if obese_1 == 1, group(treat3grpo1) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3o1"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3o1"
global cls "o1"
cd "$obesedrg"
do analysis_es_hetero_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_heteroObes1_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m2: ///
didregress (rtbeglir2_m ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins} trendtreat3o2) (treat3o2) [pweight = perwtf], group(treat3grpo2) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3o2"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3o2"
global cls "o2"
cd "$obesedrg"
do analysis_es_hetero_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_heteroObes2_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins.png, replace
cd "$obesedrg"
restore

preserve 
drop if rxbegyr < 2010 | rxbegyr > 2019
eststo m3: ///
didregress (rtbeglir2_m ${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins} trendtreat3o3) (treat3o3) [pweight = perwtf], group(treat3grpo3) time(rxbegyr) vce(cluster duid)
global outcome "rtbeglir2_m"
global treatment "treat3o3"
global covariate "${cov_dmg} ${cov_edc} ${cov_ecn} ${cov_ins}"
global trend "trendtreat3o3"
global cls "o3"
cd "$obesedrg"
do analysis_es_hetero_run2.do
cd "$obesedrg/Figure"
graph export did2_tv3lt_heteroObes3_obesenondiab_diab_treatvardef_dmg_edc_ecn_ins.png, replace
cd "$obesedrg"
restore

cd "$obesedrg/Table"
esttab m1 m2 m3 using did2_tv3lt_hetero_est.tex, compress se label replace star(* 0.10 ** 0.05 *** 0.01) 
cd "$obesedrg"

save compile_ana.dta, replace
cd "$obesedrg"

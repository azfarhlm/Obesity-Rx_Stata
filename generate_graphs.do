cd "$obesedrgdata"
use compile_ana.dta

* line: obese 1, obese 2 and obese 3 -------------------------------------------

* ------------------------------------------------------------------------------
* baseline comparisons
* ------------------------------------------------------------------------------

* line, monthly: obese, non-obese ----------------------------------------------
preserve
collapse rt_beg_lir, by(t_rxbeg obese)
twoway ///
|| line rt_beg_lir t_rxbeg if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir t_rxbeg if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(61, lpattern(dash)) ///
xlabel(5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130, angle(45) labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Month") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_nonobese.png, replace
cd "$obesedrg"
restore

* line, yearly: obese, non-obese -----------------------------------------------
preserve
collapse rt_beg_lir, by(year obese)
twoway ///
|| line rt_beg_lir year if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_nonobese_year.png, replace
cd "$obesedrg"
restore

* line, yearly: obese, diabetic ------------------------------------------------
preserve
collapse rt_beg_lir, by(year obese diab)
twoway ///
|| line rt_beg_lir year if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir year if diab == 1, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_diab_year.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabetic, diabetic  ----------------------------------
preserve
collapse rt_beg_lir, by(year obese_nondiab diab)
twoway ///
|| line rt_beg_lir year if obese_nondiab == 1, sort lpattern(solid) ///
|| line rt_beg_lir year if diab == 1, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diab_year.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabetic, diabetic; treatment variable definition  ---
preserve
collapse rt_beg_lir, by(year treat_obesenondiab_v_diab)
twoway ///
|| line rt_beg_lir year if treat_obesenondiab_v_diab == 1, sort lpattern(solid) ///
|| line rt_beg_lir year if treat_obesenondiab_v_diab == 0, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diab_treatvardef_year.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabetic, diabetic; treatment variable (treat3grp) definition
preserve
collapse rt_beg_lir, by(year treat3grp)
twoway ///
|| line rt_beg_lir year if treat3grp == 1, sort lpattern(solid) ///
|| line rt_beg_lir year if treat3grp == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiabd_diabd_treatvardef3_year.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabetic, diabetic non-obese -------------------------
preserve
collapse rt_beg_lir, by(year obese_nondiab diab_nonobese)
twoway ///
|| line rt_beg_lir year if obese_nondiab == 1, sort lpattern(solid) ///
|| line rt_beg_lir year if diab_nonobese == 1, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic and Non-Obese") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diabnonobese_year.png, replace
cd "$obesedrg"
restore

* ------------------------------------------------------------------------------
* residualized comparisons
* ------------------------------------------------------------------------------

* residualize utilization trends -----------------------------------------------
* obese vs non-obese
reg rt_beg_lir $cov_dmg if obese == 1
predict rt_beg_lir_obese_dmg, xb
reg rt_beg_lir $cov_dmg if obese == 0
predict rt_beg_lir_nonobese_dmg, xb

reg rt_beg_lir $cov_edc if obese == 1
predict rt_beg_lir_obese_edc, xb
reg rt_beg_lir $cov_edc if obese == 0
predict rt_beg_lir_nonobese_edc, xb

reg rt_beg_lir $cov_ecn if obese == 1
predict rt_beg_lir_obese_ecn, xb
reg rt_beg_lir $cov_ecn if obese == 0
predict rt_beg_lir_nonobese_ecn, xb

reg rt_beg_lir $cov_ins if obese == 1
predict rt_beg_lir_obese_ins, xb
reg rt_beg_lir $cov_ins if obese == 0
predict rt_beg_lir_nonobese_ins, xb

* obese non-diabetic vs diabetic (based on ICD code (diab))
reg rt_beg_lir $cov_dmg if treat_obesenondiab_v_diab == 1
predict rt_beg_lir_obesenondiab_dmg, xb
reg rt_beg_lir $cov_dmg if treat_obesenondiab_v_diab == 0
predict rt_beg_lir_diab_dmg, xb

reg rt_beg_lir $cov_edc if treat_obesenondiab_v_diab == 1
predict rt_beg_lir_obesenondiab_edc, xb
reg rt_beg_lir $cov_edc if treat_obesenondiab_v_diab == 0
predict rt_beg_lir_diab_edc, xb

reg rt_beg_lir $cov_ecn if treat_obesenondiab_v_diab == 1
predict rt_beg_lir_obesenondiab_ecn, xb
reg rt_beg_lir $cov_ecn if treat_obesenondiab_v_diab == 0
predict rt_beg_lir_diab_ecn, xb

reg rt_beg_lir $cov_ins if treat_obesenondiab_v_diab == 1
predict rt_beg_lir_obesenondiab_ins, xb
reg rt_beg_lir $cov_ins if treat_obesenondiab_v_diab == 0
predict rt_beg_lir_diab_ins, xb


* obese non-diabetic vs diabetic (survey diagonosis (diabd))
reg rt_beg_lir $cov_dmg if treat3grp == 1
predict rt_beg_lir_obesenondiabd_dmg, xb
reg rt_beg_lir $cov_dmg if treat3grp == 0
predict rt_beg_lir_diabd_dmg, xb

reg rt_beg_lir $cov_edc if treat3grp == 1
predict rt_beg_lir_obesenondiabd_edc, xb
reg rt_beg_lir $cov_edc if treat3grp == 0
predict rt_beg_lir_diabd_edc, xb

reg rt_beg_lir $cov_ecn if treat3grp == 1
predict rt_beg_lir_obesenondiabd_ecn, xb
reg rt_beg_lir $cov_ecn if treat3grp == 0
predict rt_beg_lir_diabd_ecn, xb

reg rt_beg_lir $cov_ins if treat3grp == 1
predict rt_beg_lir_obesenondiabd_ins, xb
reg rt_beg_lir $cov_ins if treat3grp == 0
predict rt_beg_lir_diabd_ins, xb

* graph residualized utilization trends ----------------------------------------

* obese vs non-obese -----------------------------------------------------------
* line, yearly: obese, non-obese; control: demographics ------------------------
preserve
collapse rt_beg_lir_obese_dmg rt_beg_lir_nonobese_dmg, by(year obese)
twoway ///
|| line rt_beg_lir_obese_dmg year if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir_nonobese_dmg year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small))
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_nonobese_year_ctrl_dmg.png, replace
cd "$obesedrg"
restore

* line, yearly: obese, non-obese; control: education ---------------------------
preserve
collapse rt_beg_lir_obese_edc rt_beg_lir_nonobese_edc, by(year obese)
twoway ///
|| line rt_beg_lir_obese_edc year if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir_nonobese_edc year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_nonobese_year_ctrl_edc.png, replace
cd "$obesedrg"
restore

* line, yearly: obese, non-obese; control: economics ---------------------------
preserve
collapse rt_beg_lir_obese_ecn rt_beg_lir_nonobese_ecn, by(year obese)
twoway ///
|| line rt_beg_lir_obese_ecn year if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir_nonobese_ecn year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_nonobese_year_ctrl_ecn.png, replace
cd "$obesedrg"
restore

* line, yearly: obese, non-obese; control: insurance ---------------------------
preserve
collapse rt_beg_lir_obese_ins rt_beg_lir_nonobese_ins, by(year obese)
twoway ///
|| line rt_beg_lir_obese_ins year if obese == 1, sort lpattern(solid) ///
|| line rt_beg_lir_nonobese_ins year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obese_nonobese_year_ctrl_ins.png, replace
cd "$obesedrg"
restore

* obese non-diabetic vs diabetic -----------------------------------------------
* line, yearly: obese non-diab, diab; control: demographics --------------------
preserve
collapse rt_beg_lir_obesenondiab_dmg rt_beg_lir_diab_dmg, by(year treat_obesenondiab_v_diab)
twoway ///
|| line rt_beg_lir_obesenondiab_dmg year if treat_obesenondiab_v_diab == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diab_dmg year if treat_obesenondiab_v_diab == 0, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diab_treatvardef_year_ctrl_dmg.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diab, diab; control: education -----------------------
preserve
collapse rt_beg_lir_obesenondiab_edc rt_beg_lir_diab_edc, by(year treat_obesenondiab_v_diab)
twoway ///
|| line rt_beg_lir_obesenondiab_edc year if treat_obesenondiab_v_diab == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diab_edc year if treat_obesenondiab_v_diab == 0, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diab_treatvardef_year_ctrl_edc.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diab, diab; control: economics -----------------------
preserve
collapse rt_beg_lir_obesenondiab_ecn rt_beg_lir_diab_ecn, by(year treat_obesenondiab_v_diab)
twoway ///
|| line rt_beg_lir_obesenondiab_ecn year if treat_obesenondiab_v_diab == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diab_ecn year if treat_obesenondiab_v_diab == 0, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diab_treatvardef_year_ctrl_ecn.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diab, diab; control: insurance -----------------------
preserve
collapse rt_beg_lir_obesenondiab_ins rt_beg_lir_diab_ins, by(year treat_obesenondiab_v_diab)
twoway ///
|| line rt_beg_lir_obesenondiab_ins year if treat_obesenondiab_v_diab == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diab_ins year if treat_obesenondiab_v_diab == 0, sort lpattern(longdash_dot) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Initiation Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiab_diab_treatvardef_year_ctrl_ins.png, replace
cd "$obesedrg"
restore


* obese non-diabetic vs diabetic (survey diagnosis def (diabd)) ----------------
* line, yearly: obese non-diabd, diabd; control: demographics --------------------
preserve
collapse rt_beg_lir_obesenondiabd_dmg rt_beg_lir_diabd_dmg, by(year treat3grp)
twoway ///
|| line rt_beg_lir_obesenondiabd_dmg year if treat3grp == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diabd_dmg year if treat3grp == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiabd_diabd_treatvardef3_year_ctrl_dmg.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabd, diabd; control: education -----------------------
preserve
collapse rt_beg_lir_obesenondiabd_edc rt_beg_lir_diabd_edc, by(year treat3grp)
twoway ///
|| line rt_beg_lir_obesenondiabd_edc year if treat3grp == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diabd_edc year if treat3grp == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiabd_diabd_treatvardef3_year_ctrl_edc.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabd, diabd; control: economics -----------------------
preserve
collapse rt_beg_lir_obesenondiabd_ecn rt_beg_lir_diabd_ecn, by(year treat3grp)
twoway ///
|| line rt_beg_lir_obesenondiabd_ecn year if treat3grp == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diabd_ecn year if treat3grp == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiabd_diabd_treatvardef3_year_ctrl_ecn.png, replace
cd "$obesedrg"
restore

* line, yearly: obese non-diabd, diabd; control: insurance -----------------------
preserve
collapse rt_beg_lir_obesenondiabd_ins rt_beg_lir_diabd_ins, by(year treat3grp)
twoway ///
|| line rt_beg_lir_obesenondiabd_ins year if treat3grp == 1, sort lpattern(solid) ///
|| line rt_beg_lir_diabd_ins year if treat3grp == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xline(2015, lpattern(dash)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Utilization (Initiation) Rate") ///
legend(order(1 "Obese and Non-Diabetic" 2 "Diabetic") size(small)) // t_rxbeg == 61 : Jan 2015
cd "$obesedrg/Figure"
graph export rt_beg_lir_obesenondiabd_diabd_treatvardef3_year_ctrl_ins.png, replace
cd "$obesedrg"
restore

* graph total expenditure by condition -----------------------------------------
* total medical expenditure ----------------------------------------------------
preserve
collapse totexp, by(year obese)
twoway ///
|| line totexp year if obese == 1, sort lpattern(solid) ///
|| line totexp year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Medical Expenditure") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small))
cd "$obesedrg/Figure"
graph export totexp.png, replace
cd "$obesedrg"
restore

* OOP medical expenditure ----------------------------------------------------
preserve
collapse totslf, by(year obese)
twoway ///
|| line totslf year if obese == 1, sort lpattern(solid) ///
|| line totslf year if obese == 0, sort lpattern(longdash_dot) ///
graphregion(fcolor(white) color(white) icolor(white)) ///
xlabel(, labsize(small) valuelabel) ///
ylabel(, labsize(small)) ///
xtitle("Year") ///
ytitle("Medical Expenditure") ///
legend(order(1 "Obese" 2 "Non-Obese") size(small))
cd "$obesedrg/Figure"
graph export totslf.png, replace
cd "$obesedrg"
restore


save compile_ana.dta, replace
cd "$obesedrg"

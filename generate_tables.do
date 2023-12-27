cd "$obesedrgdata"
use compile_ana.dta

* treatment variable 2 definition (Diabetic based on ICD code)
balancetable treat_obesenondiab_v_diab obesitydrug_multum_lir obese diab bmi $cov_l_dmg $cov_l_edc $cov_l_ecn $cov_l_ins using "$obesedrg/Table/balance_table.tex" if age31x > 0 [aweight = perwtf], vce(robust) pval ctitles("Control Group" "Treatment Group" "Difference") varlabels replace

* treatment variable 3 definition (Diabetic based on survey diagnosis)
balancetable treat3grp obesitydrug_multum_lir obese diabd bmi $cov_l_dmg $cov_l_edc $cov_l_ecn $cov_l_ins using "$obesedrg/Table/balance_table_tv3.tex" if age31x > 0 [aweight = perwtf], vce(robust) pval ctitles("Control Group" "Treatment Group" "Difference") varlabels replace


save compile_ana.dta, replace
cd "$obesedrg"

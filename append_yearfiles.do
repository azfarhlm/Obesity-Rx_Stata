clear
set more off

global obesedrg "/Users/azfar/Documents/Stata Files/Research/Obesity Drug"
global obesedrgdata "/Users/azfar/Documents/Stata Files/Research/Obesity Drug/Data"
global figure "/Users/azfar/Documents/Stata Files/Research/Obesity Drug/Figure"

* -------- append all year files

cd "$obesedrgdata/Year_Files"
local files : dir "$obesedrgdata/Year_Files" files "*.dta" 

tempfile compile // temporary file to compile data
save `compile', replace empty

foreach x of local files {
	*use year files
	qui: use "`x'", clear 
	qui: gen yrid = subinstr("`x'", ".dta", "", .) // generate year id
	

	*append to compile file
	append using `compile', force
	save `compile', replace
}
qui : destring yrid, gen(year)
qui : destring dupersid, replace

* ------ generate time (interview rounds) variable

gen t = 1 if panel == 14 & purchrd == 3 & year == 2010 // initialize

local panelvar ///
"14	14	15	15	15	15	15	15	16	16	16	16	16	16	17	17	17	17	17	17	18	18	18	18	18	18	19	19	19	19	19	19	20	20	20	20	20	20	21	21	21	21	21	21	22	22	22	22	22	22	23	23	23	23	23	23	24	24	24	23	23	24	24	24	25	25	25"

local purchrdvar ///
"4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	6	7	3	4	5	1	2	3"

local yearvar ///
"2010	2010	2010	2010	2010	2011	2011	2011	2011	2011	2011	2012	2012	2012	2012	2012	2012	2013	2013	2013	2013	2013	2013	2014	2014	2014	2014	2014	2014	2015	2015	2015	2015	2015	2015	2016	2016	2016	2016	2016	2016	2017	2017	2017	2017	2017	2017	2018	2018	2018	2018	2018	2018	2019	2019	2019	2019	2019	2019	2020	2020	2020	2020	2020	2020	2020	2020"

local n : word count `yearvar'

local j = 2

forvalues i = 1/`n'{
	local a : word `i' of `panelvar'
	local b : word `i' of `purchrdvar'
	local c : word `i' of `yearvar'
	replace t = `j++' if panel == `a' & purchrd == `b' & year == `c'
	
}

* ------- label time variable

local panelvar ///
"14	14	15	15	15	15	15	15	16	16	16	16	16	16	17	17	17	17	17	17	18	18	18	18	18	18	19	19	19	19	19	19	20	20	20	20	20	20	21	21	21	21	21	21	22	22	22	22	22	22	23	23	23	23	23	23	24	24	24	23	23	24	24	24	25	25	25"

local purchrdvar ///
"4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	3	4	5	1	2	3	6	7	3	4	5	1	2	3"

local yearvar ///
"2010	2010	2010	2010	2010	2011	2011	2011	2011	2011	2011	2012	2012	2012	2012	2012	2012	2013	2013	2013	2013	2013	2013	2014	2014	2014	2014	2014	2014	2015	2015	2015	2015	2015	2015	2016	2016	2016	2016	2016	2016	2017	2017	2017	2017	2017	2017	2018	2018	2018	2018	2018	2018	2019	2019	2019	2019	2019	2019	2020	2020	2020	2020	2020	2020	2020	2020"

local n : word count `yearvar'

local k = 1

forvalues i = 1/`n'{
	local a : word `i' of `panelvar'
	local b : word `i' of `purchrdvar'
	local c : word `i' of `yearvar'
	label define tlabel `k++' "`c'" , modify
}

label values t tlabel

* -------- consolidate weight variables

gen perwtf = .
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	replace perwtf = perwt`x'f if year == 20`x'
}
*bysort year: sum perwtf

gen famwtf = .
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	replace famwtf = famwt`x'f if year == 20`x'
}
*bysort year: sum famwtf

gen famwtc = .
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	replace famwtc = famwt`x'c if year == 20`x'
}
*bysort year: sum famwtc

gen saqwtf = .
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	replace saqwtf = saqwt`x'f if year == 20`x'
}
*bysort year: sum saqwtf

* -------- consolidate expenditure variables

gen rxxp = . // total expenditure
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	replace rxxp = rxxp`x'x if year == 20`x'
}
*bysort year: sum rxxp

gen rxsf = . // self paid
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	replace rxsf = rxsf`x'x if year == 20`x'
}
*bysort year: sum rxsf

* -------- drop year specific consolidated variables
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
	drop perwt`x'f famwt`x'f famwt`x'c saqwt`x'f rxxp`x'x rxsf`x'x
}
/*
* ----------- log dataset -----------
local yr "10 11 12 13 14 15 16 17 18 19 20"
foreach x in `yr'{
log using logbook_`x', replace
describe
summarize
labelbook
log close
}
*/
*  -------- save dataset
cd "$obesedrgdata"
*compress
*format dupersid %12.0g
save compile.dta, replace
cd "$obesedrg"

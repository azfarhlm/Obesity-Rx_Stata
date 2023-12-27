cd "$obesedrgdata"

local yrvar "10 11 12 13 14 15 16 17 18 19" 

local n : word count `yrvar'

forvalues i = 1/`n'{
	global year : word `i' of `yrvar'
	copy "yr_20${year}.dta" "${obesedrgdata}/Year_Files/20${year}.dta", replace
}

cd "$obesedrg"

* ------- for years <= 2011 // no rxdrgnam
local yrvar "10 11"
local csdvar "h138 h147"
local plnvar "h136 h145"
local drgvar "h135a h144a"
local cndvar "h137 h146"
local crxvar "h135i h144i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file.do // merge all files
do clean_link.do // produce year file
}

* ------- for years = 2012 // no rxdrgnam
local yrvar "12"
local csdvar "h155"
local plnvar "h153"
local drgvar "h152a"
local cndvar "h154"
local crxvar "h152i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_12.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file.do // merge all files
do clean_link.do // produce year file
}

* ------- for years = 2013
local yrvar "13"
local csdvar "h163"
local plnvar "h161"
local drgvar "h160a"
local cndvar "h162"
local crxvar "h160i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_13.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file.do // merge all files
do clean_link_13.do // produce year file
}

* ------- for years = 2014
local yrvar "14"
local csdvar "h171"
local plnvar "h169"
local drgvar "h168a"
local cndvar "h170"
local crxvar "h168i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_14.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file.do // merge all files
do clean_link_13.do // produce year file
}

* ------- for years >= 2015
local yrvar "15 16"
local csdvar "h181 h192"
local plnvar "h179 h191"
local drgvar "h178a h188a"
local cndvar "h180 h190"
local crxvar "h178i h188i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_15.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file.do // merge all files
do clean_link_13.do // produce year file
}


* ------- for years >= 2017 // omitted from survey: bmindx53
local yrvar "17"
local csdvar "h201"
local plnvar "h200"
local drgvar "h197a"
local lngvar "h210"
local cndvar "h199"
local crxvar "h197i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_lng : word `i' of `lngvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_17.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_long_17.do // import longitudinal file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file_17.do // merge all files
do clean_link_17.do // produce year file
}

* ------- for year == 2018 // unique variable: adbmi42
local yrvar "18"
local csdvar "h209"
local plnvar "h208"
local drgvar "h206a"
local cndvar "h207"
local crxvar "h206i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_18.do clear // import consolidated person file
do clean_plan.do // import person round plan file
do clean_drg.do // import prescribed medicine file
do clean_cond.do // import condition file
do clean_condrx.do // import condition-Rx file
do link_file.do // merge all files
do clean_link_18.do // produce year file
}

* ------- for years >= 2019 // different url structure to download files
local yrvar "19"
local csdvar "h216"
local plnvar "h215"
local drgvar "h213a"
local cndvar "h214"
local crxvar "h213i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_19.do clear // import consolidated person file
do clean_plan_19.do // import person round plan file
do clean_drg_19.do // import prescribed medicine file
do clean_cond_19.do // import condition file
do clean_condrx_19.do // import condition-Rx file
do link_file.do // merge all files
do clean_link_18.do // produce year file
}

/* 2020 round plan file was removed on 5/13/23 due to error
* ------- for year == 2020 // different url structure to download files & unique variable: adbmi42
local yrvar "20"
local csdvar "h224"
local plnvar "h223"
local drgvar "h220a"
local cndvar "h222"
local crxvar "h220i"

local n : word count `yrvar'

forvalues i = 1/`n'{
global year : word `i' of `yrvar' // <-- define data files' year --->
global datafile_csd : word `i' of `csdvar' // <-- define consolidated datafile -->
global datafile_pln : word `i' of `plnvar' // <-- define round plan datafile -->
global datafile_drg : word `i' of `drgvar' // <-- define drug datafile -->
global datafile_cnd : word `i' of `cndvar' // <-- define condition datafile -->
global datafile_crx : word `i' of `crxvar' // <-- define condition-Rx datafile -->

cd "$obesedrg"

do clean_consolidated_20_even.do clear // import consolidated person file
do clean_plan_19.do // import person round plan file
do clean_drg_19.do // import prescribed medicine file
do clean_cond_19.do // import condition file
do clean_condrx_19.do // import condition-Rx file
do link_file.do // merge all files
do clean_link_18.do // produce year file
}
*/

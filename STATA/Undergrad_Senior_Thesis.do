***********
/*Preamble*/
***********
clear all
capture log close
set more off

cd "C:\Users\Andrew\Documents\ECO 490\Stata Stuff"

use kir_top20_pooled_pooled_mean married_pooled_pooled_mean married_pooled_female_mean married_pooled_male_mean married_white_pooled_mean married_black_pooled_mean kir_pooled_pooled_mean two_par_pooled_pooled_mean state county hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean using county_outcomes_dta.dta, clear

replace grad_pooled_pooled_mean=. if grad_pooled_pooled_mean<0
replace kir_top20_pooled_pooled_mean=. if kir_top20_pooled_pooled_mean<0

sort state county
egen countyid=group(state county)

/*Regression 1*/
reg kir_top20_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean married_pooled_pooled_mean, vce(cluster state)
outreg2 using Table_1.xls, alpha(0.01, 0.05, 0.10) excel bd(3) bf(f) stats(coef se) rd(3) bra ctitle(OLS) replace

/*Regression 2*/
reg coll_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean married_pooled_pooled_mean, vce(cluster state)
outreg2 using Table_2.xls, alpha(0.01, 0.05, 0.10) excel bd(3) bf(f) stats(coef se) rd(3) bra ctitle(OLS) replace

/*NOTES*/
reg kir_top20_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean married_pooled_pooled_mean
predict resid, residuals
scatter resid two_par_pooled_pooled_mean
estat hettest

generate ln_kir_top20_pooled_pooled_mean = ln(kir_top20_pooled_pooled_mean)
rreg ln_kir_top20_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean married_pooled_pooled_mean

/*Error Analysis*/
reg kir_top20_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean married_pooled_pooled_mean
predict resid, residuals
scatter resid two_par_pooled_pooled_mean
estat hettest

/*Robust Regression 1*/
generate ln_kir_top20_pooled_pooled_mean = ln(kir_top20_pooled_pooled_mean)
rreg ln_kir_top20_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean married_pooled_pooled_mean

/*Robust Regression 2*/
generate qu_kir_top20_pooled_pooled_mean = kir_top20_pooled_pooled_mean^2
rreg qu_kir_top20_pooled_pooled_mean two_par_pooled_pooled_mean hs_pooled_pooled_mean somecoll_pooled_pooled_mean comcoll_pooled_pooled_mean coll_pooled_pooled_mean grad_pooled_pooled_mean married_pooled_pooled_mean


*/

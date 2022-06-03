'##########
' Chapter 2 #
'##########

wfcreate(wf = ch2, page = ch2) m 1969m01 1984m12

import UKdriversKSI.txt @freq m 1969m01 @rename series01 ksi

genr lksi = log(ksi)

' Local level, constant, simple linear regression

equation eq2.ls lksi c

' Local level, constant, state space estimation
sspace ss_eq2_2
ss_eq2_2.append lksi = sv1 + [var = c(1)]
ss_eq2_2.append @state sv1 = sv1(-1)
ss_eq2_2.ml

freeze(t1) ss_eq2_2.statefinal
scalar sv1_final = @val(t1(3,2))

series eq2_resid = lksi - sv1_final

graph fig2_1.line eq2_resid
fig2_1.axis(l) zeroline

' Local level, stochastic
param c(1) -10 c(2) -10
sspace ss_eq2_2a
ss_eq2_2a.append lksi = sv1 + [var = exp(c(1))]
ss_eq2_2a.append @state sv1 = sv1(-1) + [var = exp(c(2))]
ss_eq2_2a.ml

ss_eq2_2a.makestates(t=filt) *f ' make filtered state estimates series

ss_eq2_2a.makestates(t=smooth) *s  ' make smoothed state estimates series

scalar mu1 = sv1s(1)

group gr2 lksi sv1s

freeze(fig2_3) gr2.line

series residuals =  lksi - sv1s

freeze(fig2_4) residuals.line

fig2_4.axis(l) zeroline

' Norwegian and Finnish fatalities
pagecreate(page=ch2) a 1970 2003
pageselect ch2

import NorwayFinland.txt @freq a 1970 @rename series02 norfat series03 finfat

delete series01 ' time data

genr lnor = log(norfat)
genr lfin = log(finfat)

param c(1) -10 c(2) -10
sspace ss_nor
ss_nor.append lnor = sv1 + [var = exp(c(1))]
ss_nor.append @state sv1 = sv1(-1) + [var = exp(c(2))]
ss_nor.ml

ss_nor.makestates(t=filt) *f ' make filtered state estimates series

ss_nor.makestates(t=smooth) *s  ' make smoothed state estimates series

series res_nor =  lnor - sv1s

scalar var_eps = @var(res_nor)

scalar mu1 = sv1s(1)

group gr3 lnor sv1s

freeze(fig2_5) gr3.line

freeze(fig2_6) res_nor.line

fig2_6.axis(l) zeroline

wfsave ch2.wf1

